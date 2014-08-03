#lang scribble/manual

@(require (for-label racket fast-convert))

@title{Fast-convert: fast and easy conversion from bytes to string}
@author{@(author+email "Roman Klochkov" "kalimehtar@mail.ru")}

@(defmodule fast-convert)

@defthing[(gen-table id [charset string?])]{
Defines charset table. If charset is not set, then it is taken from the
@racket[_id] name.
}

@defproc[(convert [table vector?] [bstr bytes?]) string?]{
Converts @racket[_bstr] with charset defined by @racket[_table] to string.}
