
这是我写的第一个Swift Demo，用于刷微博，当然功能很简单，bug还是多得去的。
而且是Command Line Tool。。。

如何使用？

1. 首先，你需要在[新浪微博开发平台](http://open.weibo.com/wiki/首页)注册应用，以获取AppKey

2. 接着还需要uid和accessToken，进入[API测试工具](http://open.weibo.com/tools/console?uri=statuses/user_timeline&amp;httpmethod=GET&amp;)，在左侧就可以看到*accessToken*
,点击调用接口，在返回的json数据中找到*"user": {"id": 2839054733,*这里的id就是uid了。

3. 打开RESTEngine.swift，填写kUid,kAppKey,kAccessToken,然后运行。。。