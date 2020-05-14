#!/bin/bash

MY_SOFTS=/usr/local/mysofts
ELAS=elasticsearch-7.6.2
ELAS_TAR=elasticsearch-7.6.2-linux-x86_64.tar.gz
LOGS=logstash-7.6.2
LOGS_TAR=logstash-7.6.2.tar.gz
KIBANA=kibana-7.6.2
KIBANA_TAR=kibana-7.6.2-linux-x86_64.tar.gz
ELAS_DATA=/data/es-data
ELAS_LOG=/var/log/elasticsearch

mkdir -p $MY_SOFTS
mkdir -p $ELAS_DATA
mkdir -p $ELAS_LOG

cd $MY_SOFTS
if [ -e $ELAS ]
then
    rm -rf $ELAS
fi
if [ -e $LOGS ]
then
    rm -rf $LOGS
fi
if [ -e $KIBANA-linux-x86_64 ]
then
    rm -rf $KIBANA
fi
if [ -e $ELAS_TAR ]
then
    rm -rf $ELAS_TAR
fi
if [ -e $LOGS_TAR ]
then
    rm -rf $LOGS_TAR
fi
if [ -e $KIBANA_TAR ]
then
    rm -rf $KIBANA_TAR
fi

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.6.2-linux-x86_64.tar.gz
tar -zxvf elasticsearch-7.6.2-linux-x86_64.tar.gz -C $MY_SOFTS/
cd $MY_SOFTS/elasticsearch-7.6.2/
cat >> /usr/local/mysofts/elasticsearch-7.6.2/config/elasticsearch.yml <<"EOF"
cluster.name: myCluster
node.name: node-1
path.data: /data/es-data
path.logs: /var/log/elasticsearch/
bootstrap.memory_lock: false
network.host: 0.0.0.0
http.port: 9200
discovery.seed_hosts: ["127.0.0.1", "[::1]"]
cluster.initial_master_nodes: ["node-1"]
EOF


cd $MY_SOFTS
wget https://artifacts.elastic.co/downloads/logstash/logstash-7.6.2.tar.gz
tar -zxvf logstash-7.6.2.tar.gz -C $MY_SOFTS/
cd $MY_SOFTS/logstash-7.6.2/
touch elk.conf
cat >> /usr/local/mysofts/logstash-7.6.2/elk.conf <<"EOF"
input { 
    stdin { }
}
output {
  elasticsearch { hosts => ["127.0.0.1:9200"] }
  stdout { codec => rubydebug }
}
EOF

cd $MY_SOFTS
wget https://artifacts.elastic.co/downloads/kibana/kibana-7.6.2-linux-x86_64.tar.gz
tar -zxvf kibana-7.6.2-linux-x86_64.tar.gz
cd kibana-7.6.2-linux-x86_64/
cat >> /usr/local/mysofts/kibana-7.6.2-linux-x86_64/config/kibana.yml <<"EOF"
server.port: 5601
server.host: "0.0.0.0"
elasticsearch.hosts: ["http://127.0.0.1:9200/"]
kibana.index: ".kibana"
i18n.locale: "zh-CN"
EOF

cd $MY_SOFTS
useradd elk
chown -R elk.elk $ELAS_DATA
chown -R elk.elk $ELAS_LOG
chown -R elk.elk $ELAS
chown -R elk.elk $LOGS
chown -R elk.elk $KIBANA-linux-x86_64