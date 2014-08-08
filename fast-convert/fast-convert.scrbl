#lang scribble/manual

@(require (for-label racket fast-convert))

@title{Fast-convert: fast and easy conversion from bytes to string}
@author{@(author+email "Roman Klochkov" "kalimehtar@mail.ru")}

@defmodule[fast-convert]

@defform/subs[(gen-table charset)
              ()
              #:contracts ([charset string?])]{
Produces convert table for given charset. Charset name is the same, that may be used for
@racket[bytes-open-converter].}

@defform[(gen-tables id ...)]{
Binds convert tables for charsets, whose names are the names of @racket[_id]s, to  @racket[_id]s}

As an example,
@racketblock[(gen-tables cp437 cp866)]
defines convert tables for codepages cp437 and cp866 and binds them to ids @racket[_cp437] 
and @racket[_cp866].

@defproc[(convert-table? [object any/c]) boolean?]{
Tests whether the @racket[_object] is convert table.}

@defproc[(convert [table convert-table?] [bstr bytes?]) string?]{
Converts @racket[_bstr] with charset defined by @racket[_table] to string.}
