In order to install a new Red Hat Openshift cluster in AWS please follow the steps in the precise order:
* https://cloud.redhat.com/openshift/install

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
Choose a version number:
```bash
version=4.4.10


```
Afterwards you can proceed:
```bash
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_rsa

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


```
Now you introduce your choice for the name and domain of the cluster:
```bash
export ClusterName=openshift
export DomainName=sebastian-colomar.com


```
Now you create a configuration file template to be later modified:
```bash
dir="$HOME/environment/openshift/install/$ClusterName.$DomainName"
test -d $dir || mkdir --parents $dir
cd $dir
openshift-install-$version create install-config


```
The following script will modify the EC2 instance type so as to choose the cheapest possible type enough to correctly set up the cluster:
```bash
wget https://raw.githubusercontent.com/secobau/openshift/master/install/fix-config.sh
chmod +x fix-config.sh && ./fix-config.sh


```
If you wish your cluster to be private and not accessible from the external network:
```bash
sed --in-place s/External/Internal/ install-config.yaml


```
Be sure to enable the following features in the VPC configuration:
```bash
DNS resolution Enabled
DNS hostnames  Enabled


```
In case you want to install your cluster in an already existing VPC then you will need to add the subnet IDs to the platform.aws.subnets field:
```bash
platform:
  aws:
    subnets: 
    - subnet-1
    - subnet-2
    - subnet-3
    
    
```    
Now you can create the cluster in AWS:
```BASH
openshift-install-$version create cluster --log-level=debug


```

If you need to generate LetsEncrypt certificates you can run this script:
```bash
export EmailAddress=sebastian.colomar@gmail.com

docker run -it --rm -v ~/.aws/credentials:/root/.aws/credentials -v ~/environment/certs:/etc/letsencrypt certbot/dns-route53 certonly -n --dns-route53 --agree-tos --email $EmailAddress -d *.apps.$ClusterName.$DomainName
docker run -it --rm -v ~/.aws/credentials:/root/.aws/credentials -v ~/environment/certs:/etc/letsencrypt certbot/dns-route53 certonly -n --dns-route53 --agree-tos --email $EmailAddress -d *.$ClusterName.$DomainName

docker run -it --rm -v ~/.aws/credentials:/root/.aws/credentials -v ~/environment/certs:/etc/letsencrypt certbot/dns-route53 certificates

sudo chown $USER. -R ~/environment/certs
cp ~/environment/certs/live/apps.$ClusterName.$DomainName/*.pem ~/environment/openshift/install/$ClusterName.$DomainName/tls/


```
In order to substitute the self-signed certificate by a valid one:
* https://docs.openshift.com/container-platform/4.4/authentication/certificates/replacing-default-ingress-certificate.html
* https://docs.openshift.com/container-platform/4.4/authentication/certificates/api-server.html

You can check the content of the certificate at this website:
* https://www.sslshopper.com/certificate-decoder.html

Afterwards you can enable Github OAuth.

To relax the security in your cluster so that images are not forced to run as a pre-allocated UID, without granting everyone access to the privileged SCC (a better solution is to bind only ephemeral ports in your application):
```bash
oc adm policy add-scc-to-group anyuid system:authenticated


```
