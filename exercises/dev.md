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
   wget https://raw.githubusercontent.com/secobau/spring-petclinic/openshift/etc/docker/swarm/spring-petclinic.yaml
   docker stack deploy -c spring-petclinic.yaml spring-petclinic
   docker service ls
   docker stack rm spring-petclinic
   wget https://raw.githubusercontent.com/secobau/dockercoins/openshift/etc/docker/swarm/dockercoins.yaml
   docker stack deploy -c dockercoins.yaml dockercoins
   docker service ls
   docker stack rm dockercoins
   
   
   ```
1. https://ap-south-1.console.aws.amazon.com/cloud9
   
   In order to deploy petclinic and dockercoins in AWS Cloud9:
   ```bash
   docker swarm init
   wget https://raw.githubusercontent.com/secobau/spring-petclinic/openshift/etc/docker/swarm/spring-petclinic.yaml
   sed --in-place /node/s/worker/manager/ spring-petclinic.yaml
   docker stack deploy -c spring-petclinic.yaml spring-petclinic
   docker service ls
   docker stack rm spring-petclinic
   wget https://raw.githubusercontent.com/secobau/dockercoins/openshift/etc/docker/swarm/dockercoins.yaml
   docker stack deploy -c dockercoins.yaml dockercoins
   docker service ls
   docker stack rm dockercoins
   
   
   ``` 
1. https://console-openshift-console.apps.openshift.sebastian-colomar.es
1. https://oauth-openshift.apps.openshift.sebastian-colomar.es/oauth/token/request

   In order to access the Openshift cluster from AWS Cloud9 terminal:
   ```bash
   oc login --token=xxx-yyy --server=https://api.openshift.sebastian-colomar.es:6443
   
   
   ```   
   In order to deploy petclinic and dockercoins in Red Hat Openshift:
   ```bash
   user=dev-x
   
   project=spring-petclinic
   
   mkdir --parents $project && cd $project
   wget https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/$project.yaml
   oc new-project $project-$user
   oc apply -f $project.yaml -n $project-$user   
   oc get deployment -n $project-$user
   
   oc delete -f $project.yaml -n $project-$user
   oc delete project $project-$user
   cd .. && rm --recursive --force $project
   
   project=dockercoins
   
   mkdir --parents $project && cd $project
   wget https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/$project.yaml
   oc new-project $project-$user
   oc apply -f $project.yaml -n $project-$user   
   oc get deployment -n $project-$user
   
   oc delete -f $project.yaml -n $project-$user
   oc delete project $project-$user
   cd .. && rm --recursive --force $project


   ```
1. Troubleshooting Dockercoins   
1. https://github.com/xwiki-contrib/docker-xwiki
   * https://github.com/secobau/docker-xwiki/tree/openshift

   In order to deploy xwiki in Red Hat Openshift:
   ```bash
   user=dev-x
   
   project=docker-xwiki
   
   mkdir --parents $project && cd $project
   wget https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/$project.yaml
   oc new-project $project-$user
   oc apply -f $project.yaml -n $project-$user   
   oc get deployment -n $project-$user
   
   oc delete -f $project.yaml -n $project-$user
   oc delete project $project-$user
   cd .. && rm --recursive --force $project


   ```
1. https://github.com/secobau/proxy2aws

   In order to deploy proxy2aws in Red Hat Openshift:
   ```bash
   user=dev-x
   
   project=proxy2aws
   
   mkdir --parents $project && cd $project
   wget https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/$project.yaml
   oc new-project $project-$user
   oc apply -f $project.yaml -n $project-$user   
   oc get deployment -n $project-$user
   
   oc delete -f $project.yaml -n $project-$user
   oc delete project $project-$user
   cd .. && rm --recursive --force $project


   ```
