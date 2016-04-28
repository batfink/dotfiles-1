#!/bin/bash

# For each file in the failed directory, execute and delete
for f in failed/*
do
  sh $f && rm $f
done
