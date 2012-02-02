(define-module (bloom-filter)
  #:use-module (rnrs records syntactic)
  #:export (make-bloom-filter
            bloom-filter?
            bloom-filter-add!
            bloom-filter-contains?))

(define default-hash hash)

(define-record-type bloom-filter
  (fields (immutable size)
          (immutable bitvector)
          (immutable hash))
  (protocol
   (lambda (new)
     (case-lambda
       [(size)
        (new size (make-bitvector size #f) default-hash)]
       [(size hash)
        (new size (make-bitvector size #f) hash)]))))

(define (bloom-filter-add! bf item)
  (let ((size (bloom-filter-size bf))
        (bv   (bloom-filter-bitvector bf))
        (hash (bloom-filter-hash bf)))
    (bitvector-set! bv (hash item size) #t)))

(define (bloom-filter-contains? bf item)
  (let ((size (bloom-filter-size bf))
        (bv   (bloom-filter-bitvector bf))
        (hash (bloom-filter-hash bf)))
    (bitvector-ref bv (hash item size))))
