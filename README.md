# ycsb_starter

进行ycsb的自动化测试，结合ycsb2graph使用

旨在一键进行ycsb的所有测试，简化测试，并且提供ycsb的标准测试方法

可轻松进行多次重复测试（可重复性是数据准确性的重要前提）

## 使用方法

	 ./ycsb_starter.sh cockroachDB.properties &
	 
或

	 ./ycsb_starter.sh mysql.properties &
	 
目前提供的数据库连接配置文件有mysql和cockroachDB

需要修改对应的properties配置，以连接要进行测试的数据库

需下载ycsb(如：ycsb-jdbc-binding-0.10.0.tar.gz)方可使用，下载地址见：[YCSB download](https://github.com/brianfrankcooper/YCSB/releases)

并下载对应的jdbc数据库驱动

如：
	- mysql-connector-java-5.1.39-bin.jar （ 或更高版本）
	- postgresql-9.4.1209.jre7.jar（ 或更高版本）

对于mysql，本地需提供mysql客户端命令

对于cockroachDB，本地需提供cockroachDB命令，如Glibc低于2.17，则需提供新版本的glibc_build目录

关于YCSB的更多内容，请参考官方文档[YCSB](https://github.com/brianfrankcooper/YCSB)

关于ycsb2graph，请参看此链接[ycsb2graph](http://192.168.100.93:3000/wenzhenglin/ycsb2graph)

end.