package com.abc.controller;

import com.abc.bean.MessageDto;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.MessageHeaders;
import org.springframework.messaging.handler.annotation.*;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

/**
 * MessageMapping：接收客户端消息
 * SendTo：        广播消息到指定客户端订阅的路径
 * SendToUser：    广播消息到指定用户
 * SendToUser("/queue/reply") 实际被 UserDestinationMessageHandler 转化为 "user/role/queue/reply"
 * role 指用户标识,当接收到消息后将广播到订阅了 "user/role/queue/reply" 的特定用户,当该用户打开了多个窗口
 * (webSocket session通道) 这时会推送到不同的session通道中,可以通过 broadcast = false 关闭
 *
 * @author Shuai.Jing
 * @date 2019/3/27
 */
@RestController
public class WebSocketController {

    @MessageMapping("/toOne")
    @SendToUser(value = "/getResource",broadcast = false)
    @ResponseBody
    public String processMessageFromClient(@Payload String message) {
        MessageDto messageDto = JSON.parseObject(message, MessageDto.class);
        System.out.println(messageDto.getFrom()+":"+messageDto.getMessage());
        return message.toString();
    }

    @MessageMapping("/toAll")
    @SendTo("/getMessage/test")
    @ResponseBody
    public String sendMessage(@Payload String message, MessageHeaderAccessor headerAccessor) {
        System.out.println("all = " + message.toString());
        MessageHeaders messageHeaders = headerAccessor.getMessageHeaders();
        messageHeaders.forEach((k,v) -> {
            System.out.println(k+"  -   "+v);
        });
        return message;
    }

    @Autowired
    private SimpMessageSendingOperations simpMessageSendingOperations;
    @Autowired
    private SimpMessagingTemplate template;

    @MessageMapping("/to/{chatChannel}")
    public void sendUser(@Payload String message,
                          @Header("simpSessionId") String sessionId,
                          Principal principal,
                          StompHeaderAccessor stompHeaderAccessor,
                          @DestinationVariable("chatChannel") String chatChannel) {
        System.out.println("chatChannel = " + chatChannel);
        MessageDto messageDto = JSON.parseObject(message, MessageDto.class);
        System.out.println("发送的消息:"+message);

        // 代码控制广播
//        template.convertAndSend("/getMessage/test",
//                messageDto.toString());

        // 推送指定 user
        Principal user = stompHeaderAccessor.getUser();
        System.out.println("user "+(user == null ? "null":user.getName()));
        System.out.println(principal.getName() == null ? "--null" :principal.getName());
        String sessionId_1 = stompHeaderAccessor.getSessionId();
        System.out.println("sessionId = "+sessionId+","+sessionId_1);
        template.convertAndSendToUser(chatChannel, "/queue/reply",message);
    }

    @MessageExceptionHandler(Exception.class)
    @SendToUser("/errors")
    @ResponseBody
    public String handleException(Throwable exception) {
        System.out.println("handleException");
        exception.printStackTrace();
        return exception.getMessage();
    }

    public void controlUser(String userName,String message) {
        template.convertAndSendToUser(userName, "/control/do",message);
        System.out.println("执行到这");
    }

    public String sendMessage(String message) {
        System.out.println("控制广播 = " + message.toString());
        template.convertAndSend("/getMessage/test",message);
        System.out.println("广播到这");
        return message;
    }
}
