fast-convert
============

Fast converter for one-byte encoding bytes -> string

Usage

```Racket
(define cp866 (gen-table "cp866"))
(define str (convert cp866 bytes-in-cp866-encoding))
```
