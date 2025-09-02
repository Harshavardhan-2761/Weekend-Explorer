package com.trialproject.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class usercontroller {
    @GetMapping("/welcome")
    public String sayHello() {
        return "Hello";
    }
    // http://localhost:9090/api/welcome

    @GetMapping("/home")
    public ModelAndView homePage() {
        return new ModelAndView("home");  // refers to /WEB-INF/jsp/home.jsp
    }

}
