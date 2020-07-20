1. https://github.com/secobau/openshift/blob/master/install/IPI-External.md
1. https://github.com/spring-projects/spring-petclinic
1. https://github.com/dockersamples/dockercoins
1. https://labs.play-with-k8s.com
1. https://labs.play-with-docker.com

   START
   
   In node 1:
   ```bash
   docker swarm init --advertise-addr 192.168.0.18
   ```
   ADD NEW INSTANCE
   
   In node 2:
   ```bash
   docker swarm join --token SWMTKN-1-6893uuclrr67k8pi9igfhm91onez9orkco7rlin260192ojkl1-bj2bj4bxjfbzn32d39ajjnwuf 192.168.0.18:2377
   ```
   In node 1 again:
   ```bash
   docker node ls
   ```
   In order to deploy petclinic and dockercoins in Docker Playground:
   ```bash
   wget https://raw.githubusercontent.com/secobau/spring-petclinic/openshift/etc/docker/swarm/petclinic.yaml
   docker stack deploy -c petclinic.yaml petclinic
   docker service ls
   docker stack rm petclinic
   wget https://raw.githubusercontent.com/secobau/dockercoins/openshift/etc/docker/swarm/dockercoins.yaml
   docker stack deploy -c dockercoins.yaml dockercoins
   docker service ls
   docker stack rm dockercoins
   ```
1. https://ap-south-1.console.aws.amazon.com/cloud9
   
   In order to deploy petclinic and dockercoins in AWS Cloud9:
   ```bash
   docker swarm init
   wget https://raw.githubusercontent.com/secobau/spring-petclinic/openshift/etc/docker/swarm/petclinic.yaml
   sed --in-place /node/s/worker/manager/ petclinic.yaml
   docker stack deploy -c petclinic.yaml petclinic
   docker service ls
   docker stack rm petclinic
   wget https://raw.githubusercontent.com/secobau/dockercoins/openshift/etc/docker/swarm/dockercoins.yaml
   docker stack deploy -c dockercoins.yaml dockercoins
   docker service ls
   docker stack rm dockercoins
   ``` 
1. https://console-openshift-console.apps.openshift.sebastian-colomar.es
1. https://oauth-openshift.apps.openshift.sebastian-colomar.es/oauth/token/request
    
   In order to deploy petclinic and dockercoins in Red Hat Openshift:
   ```bash
   oc login --token=xxx-yyy --server=https://api.openshift.sebastian-colomar.es:6443
   wget https://raw.githubusercontent.com/secobau/spring-petclinic/openshift/etc/docker/kubernetes/petclinic.yaml
   oc new-project petclinic-x
   oc apply -f petclinic.yaml -n petclinic-x   
   oc get deployment -n petclinic-x
   oc delete -f petclinic.yaml -n petclinic-x
   oc delete project petclinic-x
   wget https://raw.githubusercontent.com/secobau/dockercoins/openshift/etc/docker/kubernetes/dockercoins.yaml
   oc new-project dockercoins-x
   oc apply -f dockercoins.yaml -n dockercoins-x
   oc get deployment -n dockercoins-x
   oc delete -f dockercoins.yaml -n dockercoins-x
   oc delete project dockercoins-x
   ```
   
