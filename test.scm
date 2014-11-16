;;;
;;; Test gis.hubeny
;;;

(use gauche.test)

(test-start "gis.hubeny")
(use gis.hubeny)
(test-module 'gis.hubeny)


;; If you don't want `gosh' to exit with nonzero status even if
;; the test fails, pass #f to :exit-on-failure.
(test-end :exit-on-failure #t)




