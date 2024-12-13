package com.athar.LocaLink.controller;

import com.athar.LocaLink.model.User;
import com.athar.LocaLink.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User()); 
        return "register"; 
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") User user, Model model) {
        try {
            
            String uid = userService.registerUser(user);
            if (uid != null) {
                user.setUserId(uid); 
                userService.saveUserToFirestore(user); 
                return "login"; 
            } else {
                model.addAttribute("error", "Registration failed.");
                return "register";
            }
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "register"; 
        }
    }

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("user", new User()); 
        return "login"; 
    }

    @PostMapping("/login")
    public String loginUser(@ModelAttribute("user") User user, Model model) {
        try {
            String uid = userService.loginUser(user.getUserEmail(), user.getUserPassword());
            if (uid != null) {
                User registeredUser = userService.getRegisteredUser(uid); 
                model.addAttribute("user", registeredUser); 
                return "welcome"; 
            } else {
                model.addAttribute("error", "Invalid credentials.");
                return "login"; 
            }
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "login"; 
        }
    }
}
