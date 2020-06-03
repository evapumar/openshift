#!/bin/bash -x
# ./install/fix-config.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
file=install-config.yaml						;
#########################################################################
sed --in-place 								\
	/' 'platform/d 							\
	$file								;
sed --in-place 								\
	/'name.*master/s/^.*$/  name: master\n  platform:\n    aws:\n      type: 3a.xlarge'/ \
	$file								;
#########################################################################
