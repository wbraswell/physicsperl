#!/bin/bash

cd lib/PhysicsPerl/Astro

rm Body.h 2> /dev/null
rm Body.cpp 2> /dev/null
rm Body.pmc 2> /dev/null

rm System.h 2> /dev/null
rm System.cpp 2> /dev/null
rm System.pmc 2> /dev/null

rm SystemSSE.h 2> /dev/null
rm SystemSSE.cpp 2> /dev/null
rm SystemSSE.pmc 2> /dev/null

ln -s Body.h.CPPOPS_CPPTYPES Body.h
ln -s Body.cpp.CPPOPS_CPPTYPES Body.cpp
ln -s Body.pmc.CPPOPS_DUALTYPES Body.pmc

ln -s System.h.CPPOPS_CPPTYPES System.h
ln -s System.cpp.CPPOPS_CPPTYPES System.cpp
ln -s System.pmc.CPPOPS_DUALTYPES System.pmc

ln -s SystemSSE.h.CPPOPS_CPPTYPES SystemSSE.h
ln -s SystemSSE.cpp.CPPOPS_CPPTYPES SystemSSE.cpp
ln -s SystemSSE.pmc.CPPOPS_DUALTYPES SystemSSE.pmc
