https://cloud.redhat.com/openshift/install

https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/

Fix Invalid Certificate:
https://github.com/secobau/openshift/blob/master/install/fix-certificate.sh

After running the script you need to open ports 80 and 1936 to the Security Group of the workers.
You also need to open port 443 to the world for the workers.

Then you can enable Github OAuth.
