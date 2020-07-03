In order to install a new Red Hat Openshift cluster in AWS please follow the steps in the precise order:
* https://cloud.redhat.com/openshift/install

First you need to buy a valid publid domain in Route53:
* https://console.aws.amazon.com/route53/home

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

version=4.4.10
for mode in client install
do
  wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$version/openshift-$mode-linux-$version.tar.gz
  gunzip openshift-$mode-linux-$version.tar.gz
  tar xf openshift-$mode-linux-$version.tar
  rm openshift-$mode-linux-$version.tar
done
mkdir --parents $HOME/bin
for binary in kubectl oc
do
  mv $binary $HOME/bin
done
mv openshift-install $HOME/bin/openshift-install-$version

export EmailAddress=sebastian.colomar@gmail.com
export ClusterName=openshift
export DomainName=sebastian-colomar.es
dir="$HOME/environment/openshift/install/$ClusterName.$DomainName"
test -d $dir || mkdir --parents $dir
cd $dir
openshift-install-$version create install-config

```
The following script will modify the EC2 instance type so as to choose the cheapest possible type enough to correctly set up the cluster:
```bash
wget https://raw.githubusercontent.com/secobau/openshift/master/install/fix-config.sh
chmod +x fix-config.sh && ./fix-config.sh
openshift-install-$version create cluster --log-level=debug

```

In order to fix the problem of the invalid certificate you need to run this script:
```bash
export EmailAddress=sebastian.colomar@gmail.com
export ClusterName=openshift
export DomainName=sebastian-colomar.es

docker run -it --rm -v ~/.aws/credentials:/root/.aws/credentials -v ~/environment/certs:/etc/letsencrypt certbot/dns-route53 certonly -n --dns-route53 --agree-tos --email $EmailAddress -d *.apps.$ClusterName.$DomainName
docker run -it --rm -v ~/.aws/credentials:/root/.aws/credentials -v ~/environment/certs:/etc/letsencrypt certbot/dns-route53 certonly -n --dns-route53 --agree-tos --email $EmailAddress -d *.$ClusterName.$DomainName

docker run -it --rm -v ~/.aws/credentials:/root/.aws/credentials -v ~/environment/certs:/etc/letsencrypt certbot/dns-route53 certificates

dir="$HOME/environment/openshift/install/$ClusterName.$DomainName"
test -d $dir || mkdir --parents $dir

sudo chown $USER. -R ~/environment/certs
cp ~/environment/certs/live/apps.$ClusterName.$DomainName/*.pem ~/environment/openshift/install/$ClusterName.$DomainName/tls/

cd ~/environment/openshift/install/$ClusterName.$DomainName
export KUBECONFIG=$PWD/auth/kubeconfig
file=fix-secret.sh
wget https://raw.githubusercontent.com/secobau/openshift/master/install/$file
chmod +x $file && ./$file

```
You can check the content of the certificate at this website:
* https://www.sslshopper.com/certificate-decoder.html

Afterwards you can enable Github OAuth.

To relax the security in your cluster so that images are not forced to run as a pre-allocated UID, without granting everyone access to the privileged SCC (a better solution is to bind only ephemeral ports in your application):
```bash
oc adm policy add-scc-to-group anyuid system:authenticated
```
