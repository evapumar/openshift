https://cloud.redhat.com/openshift/install

https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/

Fix Invalid Certificate in AWS:
https://github.com/secobau/openshift/blob/master/install/fix-certificate.sh

After running the previous script you need to open ports 80 and 1936 internally for the workers.
You also need to open port 443 externaly (open to the world) for the workers.

Afterwards you can enable Github OAuth.

To relax the security in your cluster so that images are not forced to run as a pre-allocated UID, without granting everyone access to the privileged SCC:
```bash
oc adm policy add-scc-to-group anyuid system:authenticated
```

Some Dockerhub images (examples: postgres and redis) require root access and have certain expectations about how volumes are owned. For these images, add the service account to the anyuid SCC.
```bash
oc adm policy add-scc-to-user anyuid system:serviceaccount:myproject:mysvcacct
```
