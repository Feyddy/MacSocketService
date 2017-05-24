# MacSocketService
简单的搭建一个socket的mac应用，使用终端与客户端进行连接通信

两个用户之间进行网络通讯。IP地址决定了设备，端口号决定了应用。

Mac可以通过活动监视器查看应用的端口号等信息：
 
![](https://ws3.sinaimg.cn/large/006tKfTcly1ffwesp1356j30nf0gqwip.jpg)

socket通讯其实就是客户端通过服务端的监听socket与服务端里面的数据进行通信。通俗的比喻就像是，男生通过女生宿舍的宿管阿姨与女生宿舍里的妹子进行交流。

下面我们通过代码创建一个Mac服务器：

> 创建一个Mac工程，然后倒入一个三方工具类:GCDAsyncSocket




通过终端进行连接
```git
xuzhonglindeMac-mini:~ t3$ telnet 127.0.0.1 1234
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
Connection closed by foreign host.
xuzhonglindeMac-mini:~ t3$
```

具体代码可以参考:[MacSocket]()
