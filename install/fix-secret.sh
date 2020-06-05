#!/bin/bash
#	./install/fix-secret.sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
crt=tls/fullchain.pem							;
key=tls/privkey.pem							;
crt=$( cat $crt | base64 --wrap 0 )					;
key=$( cat $key | base64 --wrap 0 )					;
kubectl get secret router-certs-default 				\
	--namespace	openshift-ingress				\
	--output	yaml						\
	1>		router-certs-custom				;
sed --in-place s/'  tls.crt: .*$'/"  tls.crt: $crt"/ router-certs-custom;
sed --in-place s/'  tls.key: .*$'/"  tls.key: $key"/ router-certs-custom;
kubectl delete secret router-certs-default --namespace openshift-ingress;
kubectl apply --filename router-certs-custom				;
kubectl delete pod --all --namespace openshift-ingress			;
#########################################################################
