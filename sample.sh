#!/bin/bash

set -e
run_dependencies() {
# sed  -i  's_etc/my.cnf_etc/mysql/my.cnf_g' ./usergram-playground/mysql/deployment.yaml
 #sed  -i  's_mysql/my.cnf_my.cnf_g' ./usergram-playground/mysql/deployment.yaml
 cat ./usergram-playground/mysql/deployment.yaml
 kubectl apply -k usergram-playground/mysql
# kubectl apply -k usergram-playground/cassandra
# kubectl apply -k usergram-playground/zookeeper
# kubectl apply -k usergram-playground/kafka
}

#setup_mysql() {
# #kubectl describe -k usergram-playground/mysql
# #echo $(kubectl get pods | grep mysql|cut -d" " -f4)
# mysql_status=$(kubectl get pods | grep mysql|awk '{print $2}')
# while [ "$mysql_status" != "1/1" ]; do
#     mysql_status=$(kubectl get pods | grep mysql|awk '{print $2}')
#     echo $(kubectl get pods | grep mysql|awk '{print $0}')
#     sleep 2
# done
# kubectl exec -it $(kubectl get pods | grep mysql|cut -d" " -f1) bash
# echo "login to the mysql environment successful"
#}
setup_mysql() {
 mysql_status=$(docker service ls | grep mysql|awk '{print $4}')
 while [ "$mysql_status" != "1/1" ]; do
     mysql_status=$(docker service ls | grep mysql|awk '{print $4}')
     echo $(docker service ls | grep mysql|awk '{print $0}')
     sleep 5
 done
 docker exec -it $(docker network ls | grep mysql|cut -d" " -f1) bash
 echo "login to the mysql environment successful"
}
setup_cassandra() {
  echo "setting up cassandra"
  cassandra_status=$(kubectl get pods | grep cassandra|awk '{print $2}')
  echo $(kubectl get pods | grep cassandra|awk '{print $0}')
  while [ "$cassandra_status" != "1/1" ]; do
    cassandra_status=$(kubectl get pods | grep cassandra|awk '{print $2}')
    echo $cassandra_status
    sleep 2
  done
  kubectl exec -it $(kubectl get pods|grep cassandra|cut -d" " -f1) cqlsh
  echo "login to cassandra successful"
  create KEYSPACE usergram_test WITH replication = {'class':'NetworkTopologyStrategy','DC1-K8Demo':'3'} AND durable_writes=true;
  describe keyspaces;
}
#run_dependencies
#setup_mysql
#setup_cassandra
pwd
ls
#mv processor-docker/envs/batch.secret.env.sample processor-docker/envs/batch.secret.env
sed -i '43,160d' processor-docker/docker-compose.yml
#docker swarm init
#docker stack deploy -c processor-docker/docker-compose.yml usergram
docker-compose -f processor-docker/docker-compose.yml -d
#docker-compose -f processor-docker/docker-compose.yml up -d
docker ps
setup_mysql
