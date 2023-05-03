Gauche-gis-hubeny
===================

[![CI](https://github.com/mhayashi1120/Gauche-gis-hubeny/actions/workflows/build.yml/badge.svg)](https://github.com/mhayashi1120/Gauche-gis-hubeny/actions/workflows/build.yml)

Calculate distance between 2 latitude/longitude by HUBENY formula.

This module originaly come from: (Dead link 2023-04-11)
http://yamadarake.jp/trdi/report000001.html

Other ref:

- https://www.kashmir3d.com/kash/manual/std_siki.htm
- https://www.trail-note.net/tech/calc_distance/


## Install

    ./configure
    make check
    sudo make install

## Module

gis.hubeny

This module is not intended to measure exact distances. Errors are larger when large values are
passed, such as when the distance exceeds 1000 km.

## Function

[Procedure] hubeny-distance geo1 geo2

geo\* is a compa separated float \<string>
  e.g. "36.1030203, 139.40202"

or lat lng pair
  e.g. (36.1030203 . 139.40202)

[Procedure] hubeny-distance* lat1 lng1 lat2 lng2

lat and lng is a \<real> value
  

[Procedure] hubeny-range meter geo

Inverse of `hubeny-distance` procedure.

Distance is calculated in the positive and negative directions of latitude
and longitude, respectively. Thus, the distance on the diagonal is
approximately (* (sqrt 2) METER), so the coordinates within the rectangle
are approximately METER multiplied by 1.0 to 1.4.



