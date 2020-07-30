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
   
   oc new-project $project-$user
   oc apply -n $project-$user -f https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/$project.yaml
   oc get deployment -n $project-$user
   
   oc delete -n $project-$user -f https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/$project.yaml
   oc delete project $project-$user
   
   project=dockercoins
   
   oc new-project $project-$user
   oc apply -n $project-$user -f https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/$project.yaml
   oc get deployment -n $project-$user
   
   oc delete -n $project-$user -f https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/$project.yaml
   oc delete project $project-$user


   ```
1. Troubleshooting Dockercoins   
1. https://github.com/xwiki-contrib/docker-xwiki
   * https://github.com/secobau/docker-xwiki/tree/openshift

   In order to deploy xwiki in Red Hat Openshift:
   ```bash
   user=dev-x
   
   project=docker-xwiki
   
   oc new-project $project-$user
   oc apply -n $project-$user -f https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/$project.yaml
   oc get deployment -n $project-$user
   
   oc delete -n $project-$user -f https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/$project.yaml
   oc delete project $project-$user


   ```
1. https://github.com/secobau/proxy2aws/tree/openshift
   * https://github.com/secobau/nginx
   * https://hub.docker.com/r/secobau/nginx

   1. In order to deploy phpinfo in Red Hat Openshift:
      ```bash
      user=dev-x

      project=proxy2aws

      oc new-project $project-$user
      oc apply -n $project-$user -f https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/openshift/$project.yaml
      oc get deployment -n $project-$user

      oc delete -n $project-$user -f https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/openshift/$project.yaml
      oc delete project $project-$user


      ```
   1. In order to deploy phpinfo in Red Hat Openshift through templates:
      ```bash
      user=dev-x

      project=proxy2aws

      oc new-project $project-$user
      oc process -f https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/openshift/templates/$project.yaml | oc apply -n $project-$user -f -
      oc get deployment -n $project-$user

      oc process -f https://raw.githubusercontent.com/secobau/$project/openshift/etc/docker/kubernetes/openshift/templates/$project.yaml | oc delete -n $project-$user -f -
      oc delete project $project-$user


      ```
1. https://github.com/secobau/phpinfo

   1. In order to deploy phpinfo in Red Hat Openshift:
      ```bash
      user=dev-x

      project=phpinfo

      oc new-project $project-$user
      oc apply -n $project-$user -f https://raw.githubusercontent.com/secobau/$project/master/etc/docker/kubernetes/openshift/$project.yaml
      oc get deployment -n $project-$user

      oc delete -n $project-$user -f https://raw.githubusercontent.com/secobau/$project/master/etc/docker/kubernetes/openshift/$project.yaml
      oc delete project $project-$user


      ```
   1. In order to deploy phpinfo in Red Hat Openshift through templates:
      ```bash
      user=dev-x

      project=phpinfo

      oc new-project $project-$user
      oc process -f https://raw.githubusercontent.com/secobau/$project/master/etc/docker/kubernetes/openshift/templates/$project.yaml | oc apply -n $project-$user -f -
      oc get deployment -n $project-$user

      oc process -f https://raw.githubusercontent.com/secobau/$project/master/etc/docker/kubernetes/openshift/templates/$project.yaml | oc delete -n $project-$user -f -
      oc delete project $project-$user


      ```
1. Service Mesh:
   1. https://docs.openshift.com/container-platform/4.5/service_mesh/service_mesh_install/installing-ossm.html
   1. https://docs.openshift.com/container-platform/4.5/service_mesh/service_mesh_day_two/ossm-example-bookinfo.html
1. https://github.com/kubernetes/kubernetes/issues/77086
   
   ```
   apiVersion: project.openshift.io/v1
   kind: Project
   metadata:
     name: delete-dev-0
   spec:
     finalizers:
     - foregroundDeletion


   ```
   ```
   oc get ns delete-dev-0 --output json | sed '/ "foregroundDeletion"/d' | curl -k  -H "Authorization: Bearer xxx" -H "Content-Type: application/json" -X PUT --data-binary @- https://api.openshift.sebastian-colomar.es:6443/api/v1/namespaces/delete-dev-0/finalize
   
   
   ```
1. https://github.com/secobau/openshift/blob/master/install/quay.md
   
