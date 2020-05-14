# ELK-install-shell
一键安装ELK（Elasticsearch、Logstash、Kibana）



环境要求与影响说明：
1. JDK1.8+
2. 脚本会创建一个名为elk的用户，并将ELK文件夹的权限赋给这个用户。
3. ELK将需要2G以上的内存空间，你也可以手动到Elasticsearch和Logstash的config里面的jvm.options文件中修改

所需端口：
9200（elasticsearch）、5601（kibana）

所需文件：
1. server-install.sh 服务端安装脚本：下载解压并配置elasticsearch、kibana和logstash
2. server-run.sh     服务端运行脚本：运行elasticsearch和kibana服务，如需要运行logstash进行测试，可以运行客户端运行脚本
3. client-install.sh 客户端安装脚本：下载解压并配置logstash
4. client-run.sh     客户端运行脚本：运行logstash服务

名词说明：
服务端：安装了elasticsearch、kibana和logstash三个服务的服务器，负责日志的收集、分析、搜索和网页显示。
客户端：仅安装logstash服务的服务器，负责将本地产生的日志发送给服务端。

操作说明：
1. 服务端安装与测试
    1.1 在打算作为服务端的服务器上运行服务端安装脚本
    1.2 运行服务端运行脚本，运行成功后可以如下测试
    1.3 测试elasticsearch： 访问接口 curl http://127.0.0.1:9200/ 正常情况会返回一个json，json最后是一句话 "You Know, for Search"
    1.4 测试kibana：        浏览器访问 http://IP:5601，正常情况就会进入kibana的页面了，初次进入可能会比较慢。

2. 客户端安装与测试
    2.1 在需要收集日志的服务器上运行客户端安装脚本
    2.2 安装完成后，需要配置安装目录下的elk.conf文件，将里面的 path => "日志路径" 修改为正确路径，elasticsearch { hosts => ["服务端IP:9200"] }的服务端IP修改为安装服务端程序的服务器IP。
    2.3 运行客户端运行脚本，运行成功后可以如下测试：
    2.4 运行成功后终端会等待你的输入或是日志路径中日志的更新。这时输入 "Hello"，他会返回一个json，里面是一些信息和你刚才输入的Hello字符串，接着去kibana页面查看logstash索引下的日志，顺利的话就能看到刚才的那句hello。

   

   具体实现方法可以参考此处：

   https://blog.csdn.net/heng4719/article/details/105657618