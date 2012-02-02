# Simple Bloom Filter

## Description

This is a very simple bloom filter I wrote for guile because I was
bored. It only uses one hash function, whereas a better bloom filter
would use more. Also, caution is advised, because the default hash
function in guile 2 is a bit crap. I'm told there are better hash
functions in the master branch, but I don't know when they will make
it into circulation.

## License

It is released under the 3 clause BSD license. See LICENSE for more
details.

## Example

    (use-modules (bloom-filter))

    (define bf (make-bloom-filter 1000))

    (for-each (lambda (item)
                (bloom-filter-add! bf item))
              '("scheme" "haskell" "erlang" "ocaml"))

    (bloom-filter-contains? bf "scheme")
    ; $25 = #t
    (bloom-filter-contains? bf "java")
    ; $26 = #f
    (bloom-filter-contains? bf "haskell")
    ; $27 = #t
    (bloom-filter-contains? bf "befunge")
    ; $28 = #f
