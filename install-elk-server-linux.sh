<<!
 **********************************************************
 * Author        : zhangdali
 * Email         : 986472954@qq.com
 * Last modified : 2020-05-12 09:25
 * Filename      : install-elk-server-linux.sh
 * Description   : 一键安装ELK 7.6.2
 * *******************************************************
!
#!/bin/bash

MY_SOFTS=/usr/local/mysofts
ELAS=elasticsearch-7.6.2
LOGS=logstash-7.6.2
KIBANA=kibana-7.6.2
ELAS_DATA=/data/es-data
ELAS_LOG=/var/log/elasticsearch

mkdir -p $MY_SOFTS
mkdir -p $ELAS_DATA
mkdir -p $ELAS_LOG

cd $MY_SOFTS
if [ -e $ELAS ]
then
    echo "删除已存在的elasticsearch-7.6.2"
    rm -rf $ELAS
fi
if [ -e $LOGS ]
then
    echo "删除已存在的logstash-7.6.2"
    rm -rf $LOGS
fi
if [ -e $KIBANA-linux-x86_64 ]
then
    echo "删除已存在的kibana-7.6.2"
    rm -rf $KIBANA
fi

tar -zxvf elasticsearch-7.6.2-linux-x86_64.tar.gz
cd elasticsearch-7.6.2/

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
tar -zxvf logstash-7.6.2.tar.gz
cd logstash-7.6.2/
touch elk.conf
cat >> /usr/local/mysofts/logstash-7.6.2/elk.conf <<"EOF"
input { 
    stdin { } 
    file{
        path => "/usr/local/myapps/ttg-server/nohup.out"
        start_position => "beginning"
    } 
}
output {
  elasticsearch { hosts => ["127.0.0.1:9200"] }
  stdout { codec => rubydebug }
}
EOF

cd $MY_SOFTS
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