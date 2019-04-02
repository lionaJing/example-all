package com.abc.interceptor;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 用于WebSocket握手请求的拦截器。 可用于检查握手请求和响应以及将属性传递给目标
 *
 * @author Shuai.Jing
 * @date 2019/3/31
 */
public class SessionAuthHandshakeInterceptor extends HttpSessionHandshakeInterceptor {
    // 握手之前调用
    @Override
    public boolean beforeHandshake(ServerHttpRequest request,
                                   ServerHttpResponse response,
                                   WebSocketHandler wsHandler,
                                   Map<String, Object> attributes) throws Exception {
        ServletServerHttpRequest req = (ServletServerHttpRequest) request;
        System.out.println("----beforeHandshake----");
        if (req != null) {
            String s = req.getServletRequest().getRequestURI().toString();
            String method = req.getServletRequest().getMethod();
            System.out.println(s); // lemon/771/6dw71rya/websocket
            System.out.println(method); //GET

            HttpSession session = req.getServletRequest().getSession();
            System.out.println("session ? "+(session == null));
            System.out.println("session id = "+session.getId());
            System.out.println("session Attribute(user) =  "+session.getAttribute("user"));

            attributes.put("user",session.getAttribute("user"));
        }
        System.out.println("------------");
        return true;
    }
}
