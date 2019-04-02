package com.abc.interceptor;

import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageHeaders;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptorAdapter;
import org.springframework.messaging.support.MessageHeaderAccessor;

import java.security.Principal;

/**
 * @author Shuai.Jing
 * @date 2019/3/30
 */
public class AppChannelInterceptor extends ChannelInterceptorAdapter {
    /**
     * 消息实际发送到通道之前调用
     * 该方法如果返回 null,则不会再发生调用
     */
    @Override
    public Message<?> preSend(Message<?> message, MessageChannel channel) {

        StompHeaderAccessor accessor = MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);
        // 判断是否首次连接
        if (StompCommand.CONNECT.equals(accessor.getCommand())){
            // 判断用户名和密码
            String username = accessor.getNativeHeader("login").get(0);
            String password = accessor.getNativeHeader("passcode").get(0);
            String username1 = accessor.getNativeHeader("username").get(0);
        }
        return message;
    }
    /**
     * 调用receive后立即调用，并在实际检索消息之前调用
     */
    @Override
    public boolean preReceive(MessageChannel channel) {
        return super.preReceive(channel);
    }
}
