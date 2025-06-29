#!/bin/bash 

tar -cvzf logs_archive_$(date +%Y%m%d_%H%M%S).tar.gz $1
