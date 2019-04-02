# Spring WebSocket - STOMP

STOMP是一个简单的互操作协议，用于服务器在客户端之间进行异步消息传递。
* WebSocket 是底层协议，STOMP 是适用于WebSocket 的上层协议。直接使用 WebSocket 就类似于使用 TCP 套接字来编写 web 应用，
* 没有高层协议定义消息的语意，不利于开发与维护。同HTTP在TCP套接字上添加请求-响应模型层一样，
* STOMP在 WebSocket之上提供了一个基于帧的线路格式层，用来定义消息语义

[STOMP Over WebSocket](http://jmesnil.net/stomp-websocket/doc/)

## introduction

本项目使用的是 `Spring-4.1.9` 所以不支持 `@Configuration` 注解,使用的是 xml 配置方式(代码中已经使用注解配置,只需修改 Spring 版本即可)

需要注意的是 spring-websocket 需要依赖 jackson,具体依赖如下:
```
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-websocket</artifactId>
    <version>xxx</version>
</dependency>
 
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-messaging</artifactId>
    <version>xxx</version>
</dependency>

<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-core</artifactId>
    <version>xxx</version>
</dependency>

<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId> 
    <version>xxx</version>
</dependency>
```


### 服务端接入
设置 STOMP 代理,配置路径过滤标识.  
针对不同的 Spring 版本,配置有两种方式:
* 代码注解
```
@Configuration
@EnableWebSocketMessageBroker
class x extends AbstractWebSocketMessageBrokerConfigurer{
    configureMessageBroker(MessageBrokerRegistry r)
        r.enableSimpleBroker(...)
        r.setApplicationDestinationPrefixes()
        r.setUserDestinationPrefix()
        r.setPathMatcher(AntPathMatcher("."))
    registerStompEndpoints(StompEndpointRegistry sr)
        sr.addEndpoint(...)
        sr.addEndpoint(...).setAllowedOrigins("*").withSockJS()
        
}
```
registry.enableSimpleBroker: 设置消息头,用来处理订阅和广播;与 `@SendToUser`/`@SendTo` 和 客户端的 `Stomp.subscribe()` 对应.
setApplicationDestinationPrefixes: 以该前缀开头的消息将被路由到 `@Controller` 类的 `@MessageMapping` 注释的方法.
r.setUserDestinationPrefix: 设置定点推送消息的前缀(默认是 user),当客户端尝试 `subscribe("/user/xx/yy")`,会被转化为 `/xx/yy-J87h`,
后面追加一个唯一标识,从而避免冲突;当发送 `/user/{username}/queue/position-updates`时,目标将转换为`/queue/position-updatesi9o`

* xml 配置
```
<websocket:message-broker application-destination-prefix="/app">
    <websocket:stomp-endpoint path="/portfolio">
        <websocket:sockjs/>
    </websocket:stomp-endpoint>
    <websocket:simple-broker prefix="/topic, /queue"/>
</websocket:message-broker>
```  

经过上面配置,基本可以运行,如果要加入握手拦截如下配置：
* 代码  

```
registerStompEndpoints
    stompEndpointRegistry.addEndpoint("")
            .setHandshakeHandler(new WedSocketHandler())
            .addInterceptors(new SessionAuthHandshakeInterceptor())
            .setAllowedOrigins("*")
            .withSockJS();
```
注意的是 `addInterceptors` 在 `setHandshakeHandler` 之前执行

* xml  

```
<bean id="myHandler" class="com.abc.config.WedSocketHandler"/>
<websocket:stomp-endpoint path="/lemon" allowed-origins="*">
    <websocket:handshake-handler ref="myHandler"/>
    <websocket:handshake-interceptors>
        <bean class="com.abc.interceptor.SessionAuthHandshakeInterceptor"/>
    </websocket:handshake-interceptors>
    <websocket:sockjs/>
</websocket:stomp-endpoint>
```
详细配置请参考实际配置文件 `spring-mvc.xml`  

上面讲的是握手拦截,还有一种方式,是在 WebSocketConfig 中配置拦截器,具体如下：

* 代码
```
ex xtends AbstractWebSocketMessageBrokerConfigurer
    configureClientInboundChannel(ChannelRegistration cr)
        cr.setInterceptors(AppChannelInterceptor)
AppChannelInterceptor extends ChannelInterceptorAdapter
    preSend(Message<?> message, MessageChannel channel)
        首次连接的时候，获取其Header信息，利用Header里面的信息进行权限认证
        通过认证的用户，使用 accessor.setUser(user); 方法，将登陆信息绑定在该 StompHeaderAccessor 上
    preReceive(MessageChannel channel)
```

* xml
```
<bean id="appChannelInterceptor" class="com.abc.interceptor.AppChannelInterceptor"/>
<websocket:client-inbound-channel>
    <websocket:interceptors>
        <ref bean="appChannelInterceptor"/>
    </websocket:interceptors>
</websocket:client-inbound-channel>
```

### 客户端接入

客户端接入需要引入 [stomp.min.js](https://cdn.bootcss.com/stomp.js/2.3.3/stomp.min.js)、[sockjs](https://github.com/sockjs)  

连接服务器：  
```
var socket = new SockJS('http://localhost:8080/xxx')
var stomp = Stomp.over(socket)

//login,passcode 为 string 类型
client.connect(login, passcode, connectCallback)
client.connect(login, passcode, connectCallback, errorCallback)
client.connect(login, passcode, connectCallback, errorCallback, host)

client.connect(headers, connectCallback)
client.connect(headers, connectCallback, errorCallback)

headers 为头信息，如：
var headers = {
    login: '',
    passcode: ''
    // other header
}
```

断开连接：
```
client.disconnect(funcation(){})
```

发送消息：
```
//参数1： 路径
//参数2： 额外的信息头部
//参数3： 发送的消息
client.send('/xx/xx',{},json)
```

订阅消息：
```
// 参数1： 路径
// 参数2： 函数回调
client.subscribe("", function (message) {})
```