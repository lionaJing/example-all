package com.abc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@ResponseBody
public class TestController {

    @Autowired
    WebSocketController webSocketController;

    @RequestMapping(value = "/say", method = RequestMethod.GET)
    private String sayHi() {
        System.out.println("hi....");
        return "hi...";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    private String login(@RequestParam String name, HttpServletRequest request) {
        request.getSession().setAttribute("user", name);
        return "login ok..";
    }

    @RequestMapping(value = "/control", method = RequestMethod.POST)
    private String controlUser(@RequestParam String user, @RequestParam String message) {
        if ("all".equals(user)) {
            webSocketController.sendMessage(message);
            System.out.println("控制 all");
        } else {
            webSocketController.controlUser(user, message);
            System.out.println("控制 userA");
        }
        return "ok";
    }
}
