#lang scribble/manual

@(require (for-label racket fast-convert))

@title{Fast-convert: fast and easy conversion from bytes to string}
@author{@(author+email "Roman Klochkov" "kalimehtar@mail.ru")}

@(defmodule fast-convert)

@defform/subs[(gen-table [charset])
              ()
              #:contracts ([charset string?])]{
Produces convert table for given charset. Charset name is the same, that may be used for
@racket[bytes-open-converter].}

@defproc[(convert-table? [object any/c]) boolean?]{
Tests whether the @racket[_object] is convert table.}

@defproc[(convert [table convert-table?] [bstr bytes?]) string?]{
Converts @racket[_bstr] with charset defined by @racket[_table] to string.}
