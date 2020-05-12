# ELK-install-shell
一键安装ELK（Elasticsearch、Logstash、Kibana）



环境要求：
1. JDK1.8+
2. 脚本会创建一个名为elk的用户，并将ELK文件夹赋权限给这个用户。
3. ELK将需要2G以上的内存空间，你也可以手动到Elasticsearch和Logstash的config里面的jvm.options文件中修改

所需端口：
9200（elasticsearch）、5601（kibana）

所需文件：
1. ELK v7.6.2安装包三件套（elasticsearch、kibana、logstash）

   可以从这里下载：https://pan.baidu.com/s/1LndFYnnZQwFx2-MlDZXdaQ
   提取码：7qnk

2. 服务端一键安装脚本 install-elk-server-linux.sh

3. ELK运行脚本 elk-e-startup.sh、elk-l-startup.sh、elk-k-startup.sh，分别运行elasticsearch、logstash、kibana。

名词说明：
服务端：安装了elasticsearch、kibana和logstash三个服务的服务器，负责日志的收集、分析和网页显示。
客户端：仅安装logstash服务的服务器，负责将本地产生的日志发送给服务端。

操作说明：
1. 在服务端上传ELK三件套的tar压缩包，然后运行服务端一键安装脚本，此脚本将会解压并配置ELK三件套。

2. 解压配置完成后，服务端依次运行elk-e-startup.sh、elk-k-startup.sh两个脚本，运行完成后，即可打开 http://服务器IP:5601，进入kibana的初始页面。在服务端，logstash安不安装都可以，你也可以安装来测试一下另外两个是否已经正常工作。

3. 在客户端服务器，运行elk-l-startup.sh脚本，然后编辑elk.conf中input下file里面的path路径为你想要收集的日志路径即可，具体此处的语法可以参考官方文档

4. 然后触发一次日志的生成，这个时候去kibana中查看就能看到刚才的日志了。

   

   具体实现方法可以参考此处：

   https://blog.csdn.net/heng4719/article/details/105657618