


docker pull kibana:6.8.6


rm -rf /elk/kibana
mkdir -p /elk/kibana/config

###############################  可以各自连接各自的ES，不需要连接集群
tee /elk/kibana/config/kibana.yml <<-'EOF'

#设置Kibana映射端口
server.port: 5601

#设置网关地址
server.host: "0.0.0.0"

#设置Kibana实例对外展示的名称
server.name: "kibana"

#设置ES集群地址
#elasticsearch.hosts: ["http://192.168.79.40:9201","http://192.168.1.100:9202","http://192.168.1.100:9203"]
elasticsearch.hosts: ["http://192.168.79.41:9200" ]

#设置请求超时时长
elasticsearch.requestTimeout: 120000

## 如果需要，设置登录es的用户名、密码
elasticsearch.username: "elastic"
elasticsearch.password: "elastic123"

#设置页面语言
i18n.locale: "zh-CN"

EOF


####################
docker run -d                \
  -p 5601:5601               \
  -v /elk/kibana/config/kibana.yml:/usr/share/kibana/config/kibana.yml \
  --restart=always           \
  --network=host             \
  --name KI              \
  kibana:6.8.6



http://192.168.79.41:5601/app/kibana#/dev_tools/console
http://192.168.79.42:5601/app/kibana#/dev_tools/console
http://192.168.79.43:5601/app/kibana#/dev_tools/console

GET _search
