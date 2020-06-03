* https://cloud.redhat.com/openshift/install
* https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/

First you need to buy a valid publid domain in Route53:
* https://console.aws.amazon.com/route53/home

Then you need to generate a valid certificate in AWS Certificate Manager:
* https://ap-south-1.console.aws.amazon.com/acm/home

You also need to create an S3 bucket:
* https://s3.console.aws.amazon.com/s3/home

Then you need to create a new Access Key in your Security Credentials and configure your AWS Cloud9 terminal:
```bash
aws configure
```
Please remember to disable temporary credentials in AWS Cloud9.

Now generate an SSH key pair.
```bash
ssh-keygen
cat $HOME/.ssh/id_rsa.pub
```

Copy the public key and import it into AWS EC2 dashboard.

Afterwards you can proceed:
```bash
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_rsa

mkdir --parents $HOME/environment/openshift/install/bin && cd $HOME/environment/openshift/install/bin
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux.tar.gz
gunzip openshift-client-linux.tar.gz
gunzip openshift-install-linux.tar.gz
tar xf openshift-client-linux.tar
tar xf openshift-install-linux.tar
mkdir --parents $HOME/bin && mv kubectl oc openshift-install $HOME/bin

openshift-install create install-config --dir=$HOME/environment/openshift/install
cd $HOME/environment/openshift/install
wget https://raw.githubusercontent.com/secobau/openshift/master/install/fix-config.sh
chmod +x fix-config.sh
./fix-config.sh
openshift-install create cluster --dir=$HOME/environment/openshift/install --log-level=debug

```

Now you can access your cluster in this URL:
* https://console-openshift-console.apps.training.sebastian-colomar.es

In order to fix the problem of the invalid certificate you need to follow these instructions:

```bash
export KUBECONFIG=$HOME/environment/openshift/install/auth/kubeconfig
wget https://raw.githubusercontent.com/secobau/openshift/master/install/fix-certificate.sh
chmod +x fix-certificate.sh
./fix-certificate.sh
```

After running the previous script you need to open ports 80 and 1936 internally for the workers.
You also need to open port 443 externaly (open to the world) for the workers.

Afterwards you can enable Github OAuth.

To relax the security in your cluster so that images are not forced to run as a pre-allocated UID, without granting everyone access to the privileged SCC. Better solution is to bind only ephemeral ports. Here you have the command anyway:
```bash
oc adm policy add-scc-to-group anyuid system:authenticated
```

Some Dockerhub images (examples: postgres and redis) require root access and have certain expectations about how volumes are owned. For these images, add the service account to the anyuid SCC.
```bash
oc adm policy add-scc-to-user anyuid system:serviceaccount:my_project:my_svc_account
```
