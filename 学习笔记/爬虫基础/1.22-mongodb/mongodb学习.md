## 一、Nosql简介
> 是一个NoSQL数据库，指非关系型数据库，NoSQL又是Not Only SQL，意即"不仅仅是SQL"，是对不同于传统的关系型数据库的数据库管理系统的统称。到2009年NoSQL趋势越发高涨。NoSQL主要用于超大规模数据的存储，例如谷歌，百度，Facebook等，这些类型的数据存储不需要固定的模式，无需多余操作就可以横向扩展。

> NoSQL 简史
> 
> NoSQL一词最早出现于1998年，是Carlo Strozzi开发的一个轻量、开源、不提供SQL功能的关系数据库。
2009年，Last.fm的Johan Oskarsson发起了一次关于分布式开源数据库的讨论[2]，来自Rackspace的Eric Evans再次提出了NoSQL的概念，这时的NoSQL主要指非关系型、分布式、不提供ACID的数据库设计模式。
2009年在亚特兰大举行的"no:sql(east)"讨论会是一个里程碑，其口号是"select fun, profit from real_world where relational=false;"。因此，对NoSQL最普遍的解释是"非关联型的"，强调Key-Value Stores和文档数据库的优点，而不是单纯的反对RDBMS。

## 二、两种数据库的对比
> 关系型数据库：使用事务transaction，关系型数据库遵循ACID规则，A (Atomicity) 原子性，C (Consistency) 一致性，I (Isolation) 独立性，D (Durability) 持久性

> 分布式系统（distributed system）由多台计算机和通信的软件组件通过计算机网络连接（本地网络或广域网）组成。分布式系统是建立在网络之上的软件系统。正是因为软件的特性，所以分布式系统具有高度的内聚性和透明性。因此，网络和分布式系统之间的区别更多的在于高层软件（特别是操作系统），而不是硬件。分布式系统可以应用在不同的平台上如：Pc、工作站、局域网和广域网上等
>
- 分布式计算的优点：可靠性（容错），可扩展性，资源共享（共享数据是必不可少的应用，如银行，预订系统），灵活性（很容易安装，实施和调试新的服务），更快的速度，开放系统（本地或者远程都可以访问到该服务），更高的性能（相较于集中式计算机网络集群可以提供更高的性能（及更好的性价比））
- 分布式计算的缺点：故障排除（故障排除和诊断问题），软件（更少的软件支持是分布式计算系统的主要缺点），网络（网络基础设施的问题，包括：传输问题，高负载，信息丢失等），安全性（开放系统的特性让分布式计算系统存在着数据的安全性和共享的风险等问题）


> RDBMS vs NoSQL
>
> RDBMS 

- 高度组织化结构化数据 
- 结构化查询语言（SQL） (SQL) 
- 数据和关系都存储在单独的表中。 
- 数据操纵语言，数据定义语言 
- 严格的一致性
- 基础事务

> NoSQL 

- 代表着不仅仅是SQL
- 没有声明性查询语言
- 没有预定义的模式
- 键 - 值对存储，列存储，文档存储，图形数据库
- 最终一致性，而非ACID属性
- 非结构化和不可预知的数据
- CAP定理 
- 高性能，高可用性和可伸缩性

## 三、mongodb介绍
MongoDB 是由C++语言编写的，是一个基于分布式文件存储的开源数据库系统。
在高负载的情况下，添加更多的节点，可以保证服务器性能。
MongoDB 旨在为WEB应用提供可扩展的高性能数据存储解决方案。
MongoDB 将数据存储为一个文档，数据结构由键值(key=>value)对组成。MongoDB 文档类似于 JSON 对象。字段值可以包含其他文档，数组及文档数组

PS:mongodb默认UTF-8，不支持其他
一般查询的字段都需要建立索引。TTL索引是MongoDB中一种特殊的索引， 可以支持文档在一定时间之后自动过期删除，目前TTL索引只能在单字段上建立，
并且字段类型必须是date类型或者包含有date类型的数组（如果数组中包含多个date类型字段，则取最早时间为过期时间）

主要特点：

- MongoDB 是一个面向文档存储的数据库，操作起来比较简单和容易。
- 你可以在MongoDB记录中设置任何属性的索引 (如：FirstName="Sameer",Address="8 Gandhi Road")来实现更快的排序。
- 你可以通过本地或者网络创建数据镜像，这使得MongoDB有更强的扩展性。
- 如果负载的增加（需要更多的存储空间和更强的处理能力） ，它可以分布在计算机网络中的其他节点上这就是所谓的分片。
- Mongo支持丰富的查询表达式。查询指令使用JSON形式的标记，可轻易查询文档中内嵌的对象及数组。
- MongoDb 使用update()命令可以实现替换完成的文档（数据）或者一些指定的数据字段 。
- Mongodb中的Map/reduce主要是用来对数据进行批量处理和聚合操作。
- Map和Reduce。Map函数调用emit(key,value)遍历集合中所有的记录，将key与value传给Reduce函数进行处理。
- Map函数和Reduce函数是使用Javascript编写的，并可以通过db.runCommand或mapreduce命令来执行MapReduce操作。
- GridFS是MongoDB中的一个内置功能，可以用于存放大量小文件。
- MongoDB允许在服务端执行脚本，可以用Javascript编写某个函数，直接在服务端执行，也可以把函数的定义存储在服务端，下次直接调用即可。
- MongoDB支持各种编程语言:RUBY，PYTHON，JAVA，C++，PHP，C#等多种语言。
- MongoDB安装简单。

## 四、mongodb工具
监控
MongoDB提供了网络和系统监控工具Munin，它作为一个插件应用于MongoDB中。
Gangila是MongoDB高性能的系统监视的工具，它作为一个插件应用于MongoDB中。
基于图形界面的开源工具 Cacti, 用于查看CPU负载, 网络带宽利用率,它也提供了一个应用于监控 MongoDB 的插件。

GUI
Fang of Mongo – 网页式,由Django和jQuery所构成。
Futon4Mongo – 一个CouchDB Futon web的mongodb山寨版。
Mongo3 – Ruby写成。
MongoHub – 适用于OSX的应用程序。
Opricot – 一个基于浏览器的MongoDB控制台, 由PHP撰写而成。
Database Master — Windows的mongodb管理工具
RockMongo — 最好的PHP语言的MongoDB管理工具，轻量级, 支持多国语言.
Mongodb Compass Community - mongodb自带的工具

## 五、mongodb操作
1、使用数据库：use DATABASE_NAME(名字存在就选择，不存在救创建，创建后得插入数据才显示)，show dbs

2、删除数据库：db.dropDatabase()，db.表名.drop()

3、插入数据，插入json格式数据：db.表名.insert({"name":"菜鸟教程"})
插入数据（insert插入一个列表多条数据不用遍历，效率高， save需要遍历列表，一个个插入）

4、更新
	db.collection.update(
	   <query>,
	   <update>,
	   {
	     upsert: <boolean>,
	     multi: <boolean>,
	     writeConcern: <document>
	   }
	)
参数说明：

- query : update的查询条件，类似sql update查询内where后面的。
- update : update的对象和一些更新的操作符（如$,$inc...）等，也可以理解为sql update查询内set后面的
- upsert : 可选，这个参数的意思是，如果不存在update的记录，是否插入objNew,true为插入，默认是false，不插入。
- multi : 可选，mongodb 默认是false,只更新找到的第一条记录，如果这个参数为true,就把按条件查出来多条记录全部更新。
- writeConcern :可选，抛出异常的级别。
示例：
	db.col.insert({
	    title: 'MongoDB 教程', 
	    description: 'MongoDB 是一个 Nosql 数据库',
	    by: '菜鸟教程',
	    url: 'http://www.runoob.com',
	    tags: ['mongodb', 'database', 'NoSQL'],
	    likes: 100
	})

	db.col.update({'title':'MongoDB 教程'},{$set:{'title':'MongoDB'}})

	db.col.find().pretty()
	
以上语句只会修改第一条发现的文档，如果你要修改多条相同的文档，则需要设置 multi 参数为 true。

	db.col.save({
    "_id" : ObjectId("5a65432f5d4b64eec694e48b"),
    "title" : "MongoDB",
    "description" : "MongoDB 是一个 Nosql 数据库",
    "by" : "Runoob",
    "url" : "http://www.runoob.com",
    "tags" : [
            "mongodb",
            "NoSQL"
    ],
    "likes" : 110
	})
有则覆盖，没有则新建

5、删除
	db.collection.remove(
	   <query>,
	   {
	     justOne: <boolean>,
	     writeConcern: <document>
	   }
	)

参数说明：
query :（可选）删除的文档的条件。
justOne : （可选）如果设为 true 或 1，则只删除一个文档。
writeConcern :（可选）抛出异常的级别。

	db.col.remove({'title':'MongoDB 教程'})

6、查找
	db.collection.find(query, projection)
	db.collection.findOne(query, projection)
	
	db.col.find({"by":"菜鸟教程"}).pretty()
	db.col.find({"by":"菜鸟教程", "title":"MongoDB 教程"}).pretty()
query ：可选，使用查询操作符指定查询条件
projection ：可选，使用投影操作符指定返回的键。查询时返回文档中所有键值， 只需省略该参数即可（默认省略）。
	
操作	格式	范例	RDBMS中的类似语句
>
- 等于	{<key>:<value>}	db.col.find({"by":"菜鸟教程"}).pretty()	where by = '菜鸟教程'
- 小于	{<key>:{$lt:<value>}}	db.col.find({"likes":{$lt:50}}).pretty()	where likes < 50
- 小于或等于	{<key>:{$lte:<value>}}	db.col.find({"likes":{$lte:50}}).pretty()	where likes <= 50
- 大于	{<key>:{$gt:<value>}}	db.col.find({"likes":{$gt:50}}).pretty()	where likes > 50
- 大于或等于	{<key>:{$gte:<value>}}	db.col.find({"likes":{$gte:50}}).pretty()	where likes >= 50
- 不等于	{<key>:{$ne:<value>}}	db.col.find({"likes":{$ne:50}}).pretty()	where likes != 50


## 六、python操作mongodb
1、连接
	mongodb://[username:password@]host1[:port1][,host2[:port2],...[,hostN[:portN]]][/[database][?options]]

- mongodb:// 这是固定的格式，必须要指定。
- username:password@ 可选项，如果设置，在连接数据库服务器之后，驱动都会尝试登陆这个数据库
- host1 必须的指定至少一个host, host1 是这个URI唯一要填写的。它指定了要连接服务器的地址。如果要连接复制集，请指定多个主机地址。
- portX 可选的指定端口，如果不填，默认为27017
- /database 如果指定username:password@，连接并验证登陆指定数据库。若不指定，默认打开 test 数据库。
- ?options 是连接选项。如果不使用/database，则前面需要加上/。所有连接选项都是键值对name=value，键值对之间通过&或;（分号）隔开
>
- replicaSet=name	验证replica set的名称。 Impliesconnect=replicaSet.
- slaveOk=true|false	
true:在connect=direct模式下，驱动会连接第一台机器，即使这台服务器不是主。在connect=replicaSet模式下，驱动会发送所有的写请求到主并且把读取操作分布在其他从服务器。
false: 在 connect=direct模式下，驱动会自动找寻主服务器. 在connect=replicaSet 模式下，驱动仅仅连接主服务器，并且所有的读写命令都连接到主服务器。
- safe=true|false	
true: 在执行更新操作之后，驱动都会发送getLastError命令来确保更新成功。(还要参考 wtimeoutMS).
false: 在每次更新之后，驱动不会发送getLastError来确保更新成功。
- w=n	驱动添加 { w : n } 到getLastError命令. 应用于safe=true。
- wtimeoutMS=ms	驱动添加 { wtimeout : ms } 到 getlasterror 命令. 应用于 safe=true.
- fsync=true|false	
true: 驱动添加 { fsync : true } 到 getlasterror 命令.应用于 safe=true.
false: 驱动不会添加到getLastError命令中。
- journal=true|false	如果设置为 true, 同步到 journal (在提交到数据库前写入到实体中). 应用于 safe=true
- connectTimeoutMS=ms	可以打开连接的时间。
- socketTimeoutMS=ms	发送和接受sockets的时间。

2、pymongo
3、mongoengine