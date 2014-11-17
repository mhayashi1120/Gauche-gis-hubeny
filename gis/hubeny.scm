(define-module gis.hubeny
  (use gauche.parameter)
  (use math.const)
  (export
   ;; Class
   <gis-point>

   ;; Parameter
   default-geodesic-datum

   ;; Method
   distance-between))
(select-module gis.hubeny)

;; http://yamadarake.jp/trdi/report000001.html

;; BESSEL / GRS80 / WGS84
(define default-geodesic-datum
  (make-parameter 'GRS80))

;; METER / MILE
(define distance-unit
  (make-parameter 'METER))

(define-constant BESSEL_A 6377397.155)
(define-constant BESSEL_E2 0.00667436061028297)
(define-constant BESSEL_MNUM 6334832.10663254)

(define-constant GRS80_A 6378137.000)
(define-constant GRS80_E2 0.00669438002301188)
(define-constant GRS80_MNUM 6335439.32708317)

(define-constant WGS84_A 6378137.000)
(define-constant WGS84_E2 0.00669437999019758)
(define-constant WGS84_MNUM 6335439.32729246)

(define (degree->radian deg)
  (* deg (/ pi 180.0)))

(define (meter->mile i)
  (/ i 1609.344))

(define (mile->meter i)
  (* 1609.344 i))

(define-class <gis-point> ()
  ((lat :init-keyword :lat)
   (long :init-keyword :long)))

(define-method distance-between ((lat/long1 <string>) (lat/long2 <string>))
  (distance-between lat/long1 lat/long2 (default-geodesic-datum)))

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
  (receive (a e2 mnum)
      (ecase type
        ['BESSEL
         (values BESSEL_A BESSEL_E2 BESSEL_MNUM)]
        ['GRS80
         (values GRS80_A GRS80_E2 GRS80_MNUM)]
        ['WGS84
         (values WGS84_A WGS84_E2 WGS84_MNUM)])
    (let* ([my (degree->radian (/ (+ lat1 lat2) 2.0))]
           [dy (degree->radian (- lat1 lat2))]
           [dx (degree->radian (- long1 long2))]
           [sin0 (sin my)]
           [w (sqrt (- 1.0 (* e2 sin0 sin0)))]
           [m (/ mnum (expt w 3))]
           [n (/ a w)]
           [dym (* dy m)]
           [dxncos (* dx n (cos my))]
           [meter (sqrt (+ (expt dym 2) (expt dxncos 2)))])
      (ecase (distance-unit)
        ['METER
         meter]
        ['MILE
         (meter->mile meter)]))))

(define-method distance-between ((lat1 <number>) (long1 <number>)
                                 (lat2 <number>) (long2 <number>))
  (distance-between lat1 long2 lat2 long2
                    (default-geodesic-datum)))

(define-method distance-between ((p1 <gis-point>) (p2 <gis-point>))
  (distance-between p1 p2 (default-geodesic-datum)))

(define-method distance-between ((p1 <gis-point>) (p2 <gis-point>) (type <symbol>))
  (distance-between (~ p1 'lat) (~ p1 'long)
                    (~ p2 'lat) (~ p2 'long) type))

