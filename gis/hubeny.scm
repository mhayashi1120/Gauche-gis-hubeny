(define-module gis.hubeny
  (use util.match)
  (use gauche.parameter)
  (use math.const)
  (export
   ;; Parameter
   default-geodesic-datum

   ;; Method
   distance-between))
(select-module gis.hubeny)

;; http://yamadarake.jp/trdi/report000001.html

;; (define (_compute-constants a b)
;;   (let* ((e (sqrt (/ (- (expt a 2) (expt b 2))
;;                      (expt a 2))))
;;          (e^2 (expt e 2))
;;          (M-numerator (* a (- 1 e^2))))
;;     (list a e^2 M-numerator)))

;; BESSEL / GRS80 / WGS84
(define default-geodesic-datum
  (make-parameter 'WGS84))
;; (_compute-constants 6377397.155 6356079.0)
(define-constant BESSEL_CONSTANTS
  '(6377397.155 0.00667436061028297 6334832.10663254))

;; (_compute-constants 6378137.0 6356752.314140)
(define-constant GRS80_CONSTANTS
  '(6378137.0 0.00669438002301188 6335439.32708317))

;; (_compute-constants 6378137.0 6356752.314245)
(define-constant WGS84_CONSTANTS
  '(6378137.0 0.00669437999019758 6335439.32729246))

(define (degree->radian deg)
  (* deg (/ pi 180.0)))

(define-method distance-between ((lat/long1 <string>) (lat/long2 <string>))
  (distance-between lat/long1 lat/long2 (default-geodesic-datum)))

;; e.g. lat/long "36.1030203, 139.40202"
(define-method distance-between ((lat/long1 <string>) (lat/long2 <string>)
                                 (type <symbol>))
  (define (parse-lat/long s)
    (cond
     [(#/^([0-9.]+)[ \t]*,[ \t]*([0-9.]+)$/ s) =>
      (^m (values (string->number (m 1)) (string->number (m 2))))]
     [else
      (errorf "Not matched ~a" s)]))
  
  (receive (lat1 long1) (parse-lat/long lat/long1)
    (receive (lat2 long2) (parse-lat/long lat/long2)
      (distance-between lat1 long1 lat2 long2 type))))

(define-method distance-between ((lat1 <number>) (long1 <number>)
                                 (lat2 <number>) (long2 <number>)
                                 (type <symbol>))
  (match-let1 (a e^2 M-num)
	  (ecase type
		['BESSEL
		 BESSEL_CONSTANTS]
		['GRS80
		 GRS80_CONSTANTS]
		['WGS84
		 WGS84_CONSTANTS])
    (let* ([my (degree->radian (/ (+ lat1 lat2) 2.0))]
           [dy (degree->radian (- lat1 lat2))]
           [dx (degree->radian (- long1 long2))]
           [sin0 (sin my)]
           [w (sqrt (- 1.0 (* e^2 sin0 sin0)))]
           [M (/ M-num (expt w 3))]
           [N (/ a w)]
           [dym (* dy M)]
           [dxncos (* dx N (cos my))]
           [meter (sqrt (+ (expt dym 2) (expt dxncos 2)))])
      meter)))

(define-method distance-between ((lat1 <number>) (long1 <number>)
                                 (lat2 <number>) (long2 <number>))
  (distance-between lat1 long1 lat2 long2
                    (default-geodesic-datum)))

