#lang racket/base
(require (for-syntax racket/base) racket/contract)
(provide gen-table         
         gen-tables
         (contract-out [convert (-> vector? bytes? string?)]
                       [convert-table? (-> any/c boolean?)]))

(define convert-table? vector?)

(define-for-syntax (make-codevector codepage)
  (define conv (bytes-open-converter codepage "utf-8"))
  (begin0
    (for/list ([i 256])
      (define-values (str _ status) (bytes-convert conv (bytes i)))
      (if (eq? status 'complete)
          (string-ref (bytes->string/utf-8 str) 0)
          (integer->char i)))
    (bytes-close-converter conv)))

(define-syntax (gen-table stx)
  (syntax-case stx ()
    [(_ CODEPAGE)
     (with-syntax ([(GEN-CODE ...) (make-codevector (syntax-e #'CODEPAGE))])
       #'(vector GEN-CODE ...))]))

(define-syntax (gen-tables stx)
  (syntax-case stx ()
    [(_ ID ...)
     (with-syntax ([(CODEPAGE ...) (map symbol->string (syntax->datum #'(ID ...)))])
       #'(begin (define ID (gen-table CODEPAGE)) ...))]))

;;; Should be this, but it is 2 times slower
#;(define (convert conv datum)
    (build-string (bytes-length datum)
                  (λ (i) (vector-ref conv
                                     (bytes-ref datum i)))))

(define (convert table datum)
  (define length (bytes-length datum))
  (define res (make-string length))
  (for ([i (in-range length)])
    (string-set! res i (vector-ref table 
                                   (bytes-ref datum i))))
  res)

(module+ test
  (require rackunit)
  (define bstr (list->bytes (for/list ([i 256]) i)))
  (define conv (bytes-open-converter "cp866" "utf-8"))
  (define-values (res1 _ __) (bytes-convert conv bstr))
  (define cp866 (gen-table "cp866"))
  (check-equal? (bytes->string/utf-8 res1) (convert cp866 bstr))
  (displayln "Check-time bytes-convert:")
  (time (for ([i 100000])
          (define-values (res1 _ __) (bytes-convert conv bstr))
          (bytes->string/utf-8 res1)))
  (displayln "Check-time fast convert:")
  (time (for ([i 100000])
          (convert cp866 bstr)))
  (set! bstr (bytes 159 160 161))
  (displayln "Check-time bytes-convert short string:")
  (time (for ([i 1000000])
          (define-values (res1 _ __) (bytes-convert conv bstr))
          (bytes->string/utf-8 res1)))
  (displayln "Check-time fast convert short string:")
  (time (for ([i 1000000])
          (convert cp866 bstr)))  
  (bytes-close-converter conv))
  
  