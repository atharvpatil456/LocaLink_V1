package com.athar.LocaLink.controller;

import com.athar.LocaLink.model.Advertisement;
import com.athar.LocaLink.model.Advertiser;
import com.athar.LocaLink.service.AdvertisementService;
import com.athar.LocaLink.service.AdvertiserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/advertiser")
public class AdvertiserController {

    @Autowired
    private AdvertiserService advertiserService;

    @Autowired
    private AdvertisementService advertisementService;

    @Autowired
    private HttpSession session;
    
    
  
    
    
    
    
    
    
    

//    @GetMapping("/advregister")
//    public String showRegistrationForm(Model model) {
//        model.addAttribute("advertiser", new Advertiser());
//        return "advregister";
//    }

    @PostMapping("/advregister")
    public String registerAdvertiser(@ModelAttribute("advertiser") Advertiser advertiser, Model model) {
        try {
            String aid = advertiserService.registerAdvertiser(advertiser);
            if (aid != null) {
                return "redirect:/advertiser/advlogin";
            } else {
                model.addAttribute("error", "Registration failed.");
                return "advregister";
            }
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "advregister";
        }
    }

    @GetMapping("/advlogin")
    public String showLoginForm(Model model) {
        model.addAttribute("advertiser", new Advertiser());
        return "advlogin";
    }

    @PostMapping("/advlogin")
    public String loginAdvertiser(@ModelAttribute("advertiser") Advertiser advertiser, Model model) {
        try {
            boolean valid = advertiserService.validateAdvertiser(advertiser.getAdvertiserEmail(), advertiser.getAdvertiserPassword(), "approved");
            if (valid) {
                session.setAttribute("advertiserEmail", advertiser.getAdvertiserEmail());
                return "redirect:/advertiser/dashboard";
            } else {
                model.addAttribute("error", "Invalid credentials.");
                return "advlogin";
            }
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "advlogin";
        }
    }

    @GetMapping("/dashboard")
    public String showAdvertiserDashboard(Model model) {
        String advertiserEmail = (String) session.getAttribute("advertiserEmail");
        
        // Retrieve advertisements for the advertiser
        List<Advertisement> advertisements = advertisementService.getAdvertisementsByAdvertiser(advertiserEmail);
        
        // Add the list to the model
        model.addAttribute("advertisements", advertisements);
        
        return "advertiserDashboard";  
    }


    @GetMapping("/advertisement/addAdvertisement")
    public String addAdvertisementPage(Model model) {
        String advertiserEmail = (String) session.getAttribute("advertiserEmail");
        model.addAttribute("advertiserEmail", advertiserEmail);
        return "addAdvertisement";
    }

    @GetMapping("/mapPageforadv")
    public String openMapPage() {
        return "mapPageforadv";
    }
    
    

}
