#!/bin/bash

cd lib/PhysicsPerl/Astro

rm Body.h
rm Body.cpp
rm Body.pmc

rm System.h
rm System.cpp
rm System.pmc

ln -s Body.h.CPPOPS_CPPTYPES Body.h
ln -s Body.cpp.CPPOPS_CPPTYPES Body.cpp
ln -s Body.pmc.CPPOPS_DUALTYPES Body.pmc

ln -s System.h.CPPOPS_CPPTYPES System.h
ln -s System.cpp.CPPOPS_CPPTYPES_SSE System.cpp
ln -s System.pmc.CPPOPS_DUALTYPES System.pmc
