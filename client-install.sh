#!/bin/bash

MY_SOFTS=/usr/local/mysofts
LOGS=logstash-7.6.2
LOGS_TAR=logstash-7.6.2.tar.gz

cd $MY_SOFTS
if [ -e $LOGS_TAR ]
then
    rm -rf $LOGS_TAR
fi
if [ -e $LOGS ]
then
    rm -rf $LOGS
fi

wget https://artifacts.elastic.co/downloads/logstash/logstash-7.6.2.tar.gz
tar -zxvf logstash-7.6.2.tar.gz -C $MY_SOFTS/
cd $MY_SOFTS/logstash-7.6.2/
touch elk.conf
cat >> /usr/local/mysofts/logstash-7.6.2/elk.conf <<"EOF"
input { 
    stdin { } 
    file{
        path => "日志路径"
        start_position => "beginning"
    } 
}
output {
  elasticsearch { hosts => ["服务端IP:9200"] }
  stdout { codec => rubydebug }
}
EOF

cd $MY_SOFTS
useradd elk
chown -R elk.elk $LOGS