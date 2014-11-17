;;;
;;; Test gis.hubeny
;;;

(use gauche.test)

(test-start "gis.hubeny")
(use gis.hubeny)
(test-module 'gis.hubeny)

;; allow 0.1% error
(define-method nearly=? ((f1 <real>) (f2 <real>))
  (<= (* 0.999 f2) f1 (* 1.001 f2)))

(let* ([Tokyo "35.65500,139.74472"]
       [Tsukuba "36.10056,140.09111"]
       [FukuokaDome "33.59532,130.36208"]
       )
  (test* "Distance from Yamadarake1"
         58501.873 (distance-between Tokyo Tsukuba) nearly=?)
  (test* "Distance from Yamadarake2"
         889826.431 (distance-between Tokyo FukuokaDome) nearly=?))
  
;; If you don't want `gosh' to exit with nonzero status even if
;; the test fails, pass #f to :exit-on-failure.
(test-end :exit-on-failure #t)




