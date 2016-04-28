#!/bin/bash

for f in ~/Library/LaunchAgents/com.shortstack.*
do
  launchctl unload $f
  rm $f
done

# For each launch agent
for plist in launch_agents/*
do
  echo $plist
  cp -f $plist ~/Library/LaunchAgents/
  launchctl load ~/Library/LaunchAgents/$(basename $plist)
done
