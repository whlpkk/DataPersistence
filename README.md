# DataPersistence

列举了3种常用的数据持久化的方法

* CoreData,苹果官方的数据库，也可以使用一些常用的第三方库，如FMDB等。
* NSKeyArchiver,归档，可以将任意遵循协议的对象持久化到本地。
* Plist文件，也就是写文件到沙盒目录，这里不限定文件类型。