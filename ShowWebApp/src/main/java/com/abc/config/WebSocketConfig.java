package com.abc.config;

import com.abc.interceptor.SessionAuthHandshakeInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;

/**
 * EnableWebSocketMessageBroker注解表明： 这个配置类不仅配置了 WebSocket，还配置了 基于代理的 STOMP 消息
 *
 * 配置并启用 webSocket
 * @author Shuai.Jing
 * @date 2019/3/27
 */
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig extends AbstractWebSocketMessageBrokerConfigurer {
    /**
     * 配置消息代理
     * 通俗理解：
     * \app => utl: *\app\message 对应 @MessageMapping("/message") 方法
     * \topic \queue 对应 @SendToUser 或 @SendTo 的地址
     */
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // 设置服务器广播消息的基础路径
        registry.enableSimpleBroker("/errors", "/getMessage","/getResource","/queue","/control");
        // 设置客户端订阅消息的基础路径
        registry.setApplicationDestinationPrefixes("/chat","/myApp");
        // 定点推送 前缀
        registry.setUserDestinationPrefix("/user");
        // 使用 . 作为分隔符
        registry.setPathMatcher(new AntPathMatcher("."));
    }

    /**
     * 注册STOMP端点，将每个端点映射到特定URL，并（可选）启用和配置SockJS后备选项
     * addEndpoint：设置 webSocket 的端点,客户端需要注册这个端点进行链接
     * 例：
     * new WebSocket('ws://localhost:8080/greeting')
     * new SockJS('/greeting')
     *
     * 客户端在订阅发布消息到目的地,要首先连接该地址
     */
    @Override
    public void registerStompEndpoints(StompEndpointRegistry stompEndpointRegistry) {
        stompEndpointRegistry.addEndpoint("/lemon");
        stompEndpointRegistry.addEndpoint("/lemon").setAllowedOrigins("*").withSockJS();

        //握手拦截，获取已登录的User
//        stompEndpointRegistry.addEndpoint("")
//                .setHandshakeHandler(new WedSocketHandler())
//                .addInterceptors(new SessionAuthHandshakeInterceptor())
//                .setAllowedOrigins("*")
//                .withSockJS();
    }

    /**
     *
     * 1、设置拦截器
     * 2、首次连接的时候，获取其Header信息，利用Header里面的信息进行权限认证
     * 3、通过认证的用户，使用 accessor.setUser(user); 方法，将登陆信息绑定在该 StompHeaderAccessor 上，
     * 在Controller方法上可以获取 StompHeaderAccessor 的相关信息
     */
    @Override
    public void configureClientInboundChannel(ChannelRegistration registration) {
        registration.setInterceptors();
    }
}
