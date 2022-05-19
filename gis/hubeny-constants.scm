(define-module gis.hubeny-constants
  (export
   bessel-constants grs80-constants wgs84-constants))
(select-module gis.hubeny-constants)

(define (bessel-constants)
  (compute-constants 6377397.155 6356079.0))

(define (grs80-constants)
  (compute-constants 6378137.0 6356752.314140))

(define (wgs84-constants)
  (compute-constants 6378137.0 6356752.314245))

(define (compute-constants a b)
  (let* ((e (sqrt (/ (- (expt a 2) (expt b 2))
                     (expt a 2))))
         (e^2 (expt e 2))
         (M-numerator (* a (- 1 e^2))))
    (list a e^2 M-numerator)))

