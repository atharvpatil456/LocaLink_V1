package com.athar.LocaLink.controller;

import com.athar.LocaLink.model.Advertiser;
import com.athar.LocaLink.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class AdminController {
    private final AdminService adminService;

    @Autowired
    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }

    @GetMapping("/admin/login")
    public String loginPage() {
        return "adminLogin";
    }

    @PostMapping("/admin/login")
    public String login(@RequestParam String email, @RequestParam String password, Model model) {
        if (adminService.validateAdmin(email, password)) {
            return "redirect:/admin/dashboard";
        }
        model.addAttribute("error", "Invalid email or password");
        return "adminLogin";
    }

    @GetMapping("/admin/dashboard")
    public String adminDashboard(Model model) {
        List<Advertiser> advertisers = adminService.getAllAdvertisers();
        model.addAttribute("advertisers", advertisers);
        System.out.println("Advertisers in Dashboard: " + advertisers); // Debug line
        return "adminDashboard";
    }


    @PostMapping("/admin/updateStatus")
    public String updateStatus(@RequestParam String advertiserId, @RequestParam String status) {
        adminService.updateAdvertiserStatus(advertiserId, status);
        return "redirect:/admin/dashboard"; // Redirect back to dashboard after status update
    }
}
