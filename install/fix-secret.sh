#!/bin/bash
#	./install/fix-secret.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
crt=tls/fullchain.pem							;
key=tls/privkey.pem							;
namespace=openshift-ingress						;
secret=router-certs-default						;
crt=$( cat $crt | base64 --wrap 0 )					;
key=$( cat $key | base64 --wrap 0 )					;
kubectl get secret $secret		 				\
	--namespace	$namespace					\
	--output	yaml						\
	1>		$secret						;
sed --in-place s/'  tls.crt: .*$'/"  tls.crt: $crt"/ $secret		;
sed --in-place s/'  tls.key: .*$'/"  tls.key: $key"/ $secret		;
kubectl delete secret $secret --namespace $namespace			;
kubectl apply --filename $secret					;
kubectl delete pod --all --namespace $namespace				;
#########################################################################
