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

for mode in client install
do
  wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.4.5/openshift-$mode-linux-4.4.5.tar.gz
  gunzip openshift-$mode-linux-4.4.5.tar.gz
  tar xf openshift-$mode-linux-4.4.5.tar
  rm openshift-$mode-linux-4.4.5.tar
done
mkdir --parents $HOME/bin
for binary in kubectl oc
do
  mv $binary $HOME/bin
done
mv openshift-install $HOME/bin/openshift-install-4.4.5

openshift-install-4.4.5 create install-config

```
```bash
wget https://raw.githubusercontent.com/secobau/openshift/master/install/fix-config.sh
chmod +x fix-config.sh && ./fix-config.sh
openshift-install-4.4.5 create cluster --log-level=debug

```

Now you can access your cluster in this URL (please substitute 'training' by the actual name of your cluster):
* https://console-openshift-console.apps.$ClusterName.sebastian-colomar.es

In order to fix the problem of the invalid certificate you need to run this script:
```bash
docker run -it --rm -v ~/.aws/credentials:/root/.aws/credentials -v ~/environment/certs:/etc/letsencrypt certbot/dns-route53 certonly -n --dns-route53 --agree-tos --email $EmailAddress -d *.apps.$ClusterName.sebastian-colomar.es

docker run -it --rm -v ~/.aws/credentials:/root/.aws/credentials -v ~/environment/certs:/etc/letsencrypt certbot/dns-route53 certificates

sudo chown $USER. -R ~/environment/certs
cp ~/environment/certs/archive/apps.v4-4-5.sebastian-colomar.es/*.pem ~/environment/openshift/install/$ClusterName.sebastian-colomar.es/tls/

export KUBECONFIG=$PWD/auth/kubeconfig
wget https://raw.githubusercontent.com/secobau/openshift/master/install/fix-certificate.sh
chmod +x fix-certificate.sh && ./fix-certificate.sh

```

Afterwards you can enable Github OAuth.

To relax the security in your cluster so that images are not forced to run as a pre-allocated UID, without granting everyone access to the privileged SCC. Thouh a better solution is to bind only ephemeral ports. Here you have the command anyway:
```bash
oc adm policy add-scc-to-group anyuid system:authenticated
```
