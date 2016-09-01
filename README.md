# ycsb_starter

YCSB testing starter

To do automatic ycsb testing, work together with [ycsb2graph](https://github.com/chinglinwen/ycsb2graph)

To do all test with a single command, simplify the testing, and provide a standard testing for ycsb

It's easy to re-test (  since repeatability is important to data accuracy )

## Usage

	 ./ycsb_starter.sh cockroachDB.properties &
	 
Or

	 ./ycsb_starter.sh mysql.properties &
	 
> Note：The first time run, it's need the database **ycsb** and the table **usertable** is exists，
> You can run `./create_database.sh db-name.sh` to create it
	 
It currently provides msyql.properties and cockroachDB properties ( as example)

You may need to change the config in properties file, to connect the right database instance

You need to download ycsb ( eg. ycsb-jdbc-binding-0.10.0.tar.gz) to run this starter, download address：[YCSB download](https://github.com/brianfrankcooper/YCSB/releases)

And to download the respective jdbc sql driver

mysql
	mysql-connector-java-5.1.39-bin.jar （ or higher version）
	
cockroachDB
	postgresql-9.4.1209.jre7.jar（ or higher version）

For mysql, the local command **mysql** must available

For cockroachDB, the local command **cockroach** must available, if Glibc version is lower than 2.17, 
You may need to build a new glibc version ( at least 2.17) , and provide that glibc_build directory

To know more about YCSB, see the official documents [YCSB](https://github.com/brianfrankcooper/YCSB)

end.