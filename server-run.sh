#!/bin/bash

cd /usr/local/mysofts/elasticsearch-7.6.2
bin/elasticsearch &

cd /usr/local/mysofts/kibana-7.6.2-linux-x86_64
bin/kibana &