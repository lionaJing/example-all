package com.abc.config;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.DefaultHandshakeHandler;

import javax.servlet.http.HttpSession;
import java.security.Principal;
import java.util.Map;

/**
 * 处理 WebSocket 握手请求
 *
 * @author Shuai.Jing
 * @date 2019/3/31
 */
public class WedSocketHandler extends DefaultHandshakeHandler {
    @Override
    protected Principal determineUser(ServerHttpRequest request,
                                      WebSocketHandler wsHandler,
                                      Map<String, Object> attributes) {
        System.out.println("---WedSocketHandler--");

        ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
        HttpSession session = servletRequest.getServletRequest().getSession();

        System.out.println("得到传递来的 session = " + attributes.get("user"));
        String name = (String) attributes.get("user");
        Principal principal = new Principal() {
            @Override
            public String getName() {
                return name;
            }
        };

        System.out.println("---------");
        return principal;
//        return super.determineUser(request, wsHandler, attributes);
    }
}
