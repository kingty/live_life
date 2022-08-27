# 关于用文件存储来让不同终端同步数据的想法。

- 这方面考虑主要是我不想维护一个服务端，这样成本比较高， 比如用Tencent CloudBase这种serverless，最便宜也要20元一个月，
  相对来说还是有成本的。然后如果用对象存储。相对来说就便宜很多，而且，像图片，文件都可以用对象存储。


- 因为个人产生的结构华数据量实际上很小， 可以用类似与一个数据库日志的方式来记录所有的数据修改操作，这个操作是一个线性的。
  每一批次的操作都产生一个id,生成一个文件，然后把这个文件上传到一个各个终端都可以访问到的文件存储端。

## 存储端有的文件：

- all.json
  id 是没你批量操作的id，是唯一并且严格序列的。
  ```json
  {
  "0" : [],
  "1" : [],
  "2" : [],
  "3" : [],
  "..." : [],
  "999" : []
  }
  ```

  - id.json
    latestId： 最近一次批量操作的id， 从0开始递增，没有间断
  ```josn
  {
  "latestId": "1000"
  }
  ```
  - last_merge.json
    lastMergeId： 最近一次合并总数据的id,也就是
  ```josn
  {
  "lastMergeId": "900"
  }
  ```
  
  - transaction_(id).json
  每一次操作的数据
  ```json
  {
  "(id)" : []
  }
  ```

## 各客户端同步流程如下
LocallatestId，是本地同步的最新批次数据的id，如果是新客户端则是0，
  1. 拉取last_merge.json，lastMergeId和本地LocallatestId对比，如果[lastMergeId >LocallatestId], 直接拉取all.json，并执行所有过程。拿到左后一个id[999],存一个本地LocallatestId[999]
  
  2. 拉取id.json，读取`latestId`和本地`LocallatestId`对比，如果一样，说明数据同步完成，如果不一样，说明还有数据，那么依次遍历[LocallatestId - latestId]，拉取transaction_(id).json，执行里面的日志，同步到最新数据
  3. 如果发现读取[`latestId`-`astMergeId` >= 100], 下载all.json， 把[`latestId`-`astMergeId`]这一百个批次对应的文件数据都同步到all.json中，并上传到存储中。并修改last_merge.json
这里同步都是读操作。唯一一个修改操作。就是同步一百个批次对应的文件数据都同步到all.json中，但是，假设有两个端同时做了这个事情，他们做的结果也是一致的，不会影响数据的正确性

## 各客户端写数据流程如下

  1. A:在本地执行了操作（"insert into t1 values (a,b,c)"，"insert into t2 values (d,e,f)"） 这时候它需要把本地操作对应的文件同步到文件存储。

  - 第一

  A: transaction(id=1000)("insert xx into yy values (a,b,c)"，"insert xx into yy values (d,e,f)")