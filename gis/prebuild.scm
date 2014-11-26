#!/usr/bin/env gosh

(use gauche.configure)

(define (main args)
  ;; dummy
  (cf-init "" "" "")
  (cf-subst 'BESSEL_CONSTANTS (compute-constants 6377397.155 6356079.0))
  (cf-subst 'GRS80_CONSTANTS (compute-constants 6378137.0 6356752.314140))
  (cf-subst 'WGS84_CONSTANTS (compute-constants 6378137.0 6356752.314245))
  (cf-output "hubeny.scm")
  0)

(define (compute-constants a b)
  (let* ((e (sqrt (/ (- (expt a 2) (expt b 2))
                     (expt a 2))))
         (e^2 (expt e 2))
         (M-numerator (* a (- 1 e^2))))
    (list a e^2 M-numerator)))

