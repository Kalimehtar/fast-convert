#lang scribble/manual

@(require (for-label racket finalizer))

@title{Finalizer: trivial finalization}
@author{@(author+email "Roman Klochkov" "kalimehtar@mail.ru")}

@(defmodule finalizer)
This package is based upon idea in 
@(hyperlink "http://www.gigamonkeys.com/book/practical-an-id3-parser.html" 
            "Practical Common Lisp").

@defproc[(register-finalizer [object any/c] [proc (any/c . -> . any)]) void?]{
Register finalize racket[_proc], that will be called, when racket[_object] is garbage collected}
