package com.athar.LocaLink.controller;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequestMapping("/Dashboard")
public class HelloController {

    @GetMapping("/index")
    public String Homepage() {
        return "index";
    }
    
    
}
