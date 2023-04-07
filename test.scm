;;;
;;; Test gis.hubeny
;;;

(use gauche.test)

(test-start "gis.hubeny")

(use gis.hubeny)
(test-module 'gis.hubeny)

;; allow 0.5% error
(define (nearly=? f1 f2)
  (<= (* 0.995 f2) f1 (* 1.005 f2)))

;; Deprecating interface tests
(let* ([Tokyo "35.65500,139.74472"]
       [Tsukuba "36.10056,140.09111"]
       [FukuokaDome "33.59532,130.36208"]
       )
  (test* "Distance from Yamadarake1"
         58502.459 (distance-between Tokyo Tsukuba) nearly=?)
  (test* "Distance from Yamadarake2"
         890233.064 (distance-between Tokyo FukuokaDome) nearly=?)
  (test* "Distance from Yamadarake3 on the Narita Airport runway"
         2180 (distance-between "35.802739,140.380034" "35.785796,140.392265") nearly=?)

  (test* "Distance from Yamadarake1 on Japan KokudoChiriin"
         58501.873 (distance-between Tokyo Tsukuba) nearly=?)
  (test* "Distance from Yamadarake2 on Japan KokudoChiriin"
         889826.431 (distance-between Tokyo FukuokaDome) nearly=?)

  (test* "Distance from Google Map"
         261690.0 (distance-between "51.492552, 0.237717" "51.293807, -3.520984") nearly=?)
  (test* "Distance from Google Map 2"
         2255100.0 (distance-between "4.741940, 15.557547" "-11.450795, 3.284581") nearly=?)
  )

(let* ([Tokyo "35.65500,139.74472"]
       [Tsukuba "36.10056,140.09111"]
       [FukuokaDome "33.59532,130.36208"]
       )
  (test* "Distance from Yamadarake1"
         58502.459 (hubeny-distance Tokyo Tsukuba) nearly=?)
  (test* "Distance from Yamadarake2"
         890233.064 (hubeny-distance Tokyo FukuokaDome) nearly=?)
  (test* "Distance from Yamadarake3 on the Narita Airport runway"
         2180 (distance-between "35.802739,140.380034" "35.785796,140.392265") nearly=?)

  (test* "Distance from Yamadarake1 on Japan KokudoChiriin"
         58501.873 (hubeny-distance Tokyo Tsukuba) nearly=?)
  (test* "Distance from Yamadarake2 on Japan KokudoChiriin"
         889826.431 (hubeny-distance Tokyo FukuokaDome) nearly=?)

  (test* "Distance from Google Map"
         261690.0 (hubeny-distance "51.492552, 0.237717" "51.293807, -3.520984") nearly=?)
  (test* "Distance from Google Map 2"
         2255100.0 (hubeny-distance "4.741940, 15.557547" "-11.450795, 3.284581") nearly=?))

;; TODO more test. between NorthEast and SouceWest

(test-end :exit-on-failure #t)
