Gauche-gis-hubeny
===================

[![CI](https://github.com/mhayashi1120/Gauche-gis-hubeny/actions/workflows/build.yml/badge.svg)](https://github.com/mhayashi1120/Gauche-gis-hubeny/actions/workflows/build.yml)

Calculate distance between 2 latitude/longitude by HUBENY formula.

This module come from:
http://yamadarake.jp/trdi/report000001.html

## Install

    ./configure
    make check
    sudo make install

## Module

gis.hubeny

## Function

[Procedure] hubeny-distance geo1 geo2

geo\* is a compa separated float \<string>
  e.g. "36.1030203, 139.40202"

or lat lng pair
  e.g. (36.1030203 . 139.40202)

[Procedure] hubeny-distance* lat1 lng1 lat2 lng2

lat and lng is a \<real> value
  

