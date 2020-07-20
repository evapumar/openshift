1. https://github.com/secobau/openshift/blob/master/install/IPI-External.md
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
1. https://labs.play-with-k8s.com
1. https://github.com/spring-projects/spring-petclinic
1. https://github.com/dockersamples/dockercoins
