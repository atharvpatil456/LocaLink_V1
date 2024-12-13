package com.athar.LocaLink.controller;

import java.util.UUID;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.athar.LocaLink.model.Advertisement;
import com.athar.LocaLink.service.AdvertisementService;
import com.google.api.services.storage.Storage.BucketAccessControls.List;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/advertisement")
public class AdvertisementController {

    @Autowired
    private HttpSession session;  

    @Autowired
    private AdvertisementService advertisementService;

    @PostMapping("/addAdvertisement")
    public String addAdvertisement(@RequestParam String adName, 
                                   @RequestParam String adDesc, 
                                   @RequestParam String adPrice, 
                                   @RequestParam String latitude, 
                                   @RequestParam String longitude,
                                   @RequestParam String imageUrl,
                                   @RequestParam String category,
                                   @RequestParam String rating,
                                   @RequestParam String ratingCount,
                                   Model model) {
        try {
            
            String advertiserEmail = (String) session.getAttribute("advertiserEmail");

            if (advertiserEmail == null) {
                model.addAttribute("error", "Advertiser not logged in.");
                return "redirect:/advertiser/advlogin";  // Redirect to login if session expired
            }

            Advertisement ad = new Advertisement();
            String adId = UUID.randomUUID().toString().replace("-", "").substring(0, 20);
            ad.setAdId(adId);  // Set unique adId as String // Unique adId
            ad.setAdName(adName);
            ad.setAdDesc(adDesc);
            ad.setAdPrice(adPrice);
            ad.setLatitude(latitude);
            ad.setLongitude(longitude);
            ad.setImageUrl(imageUrl);
            ad.setCategory(category);
            ad.setRating(rating);
            ad.setRating(ratingCount);
            advertisementService.saveAdvertisement(ad, advertiserEmail);

            return "redirect:/advertiser/dashboard"; 
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred while adding the advertisement.");
            return "addAdvertisement";
        }
    }
    
    @GetMapping("/mapPage")
    public String openMapPage() {
        // Return the name of the HTML/JSP file for the map page
        return "mapPage";
    }
    
    
    @GetMapping("/updateAdvertisement")
    public String showUpdateForm(@RequestParam String adId, Model model) throws InterruptedException, ExecutionException {
        Advertisement advertisement = advertisementService.findById(adId);
        model.addAttribute("advertisement", advertisement);
        return "updateAdvertisement"; // Returns the JSP page to update the advertisement
    }

    // Method to handle the form submission for updating an advertisement
    @PostMapping("/updateAdvertisement")
    public String updateAdvertisement(@ModelAttribute Advertisement advertisement) {
        advertisementService.updateAdvertisement(advertisement);
        
        return "redirect:/advertiser/dashboard"; // Redirect back to the advertisements page
    }
    
    @PostMapping("/deleteAdvertisement")
    public String deleteAdvertisement(@RequestParam String adId) {
        advertisementService.deleteAdvertisement(adId);
        return "redirect:/advertiser/dashboard"; // Redirect back to the advertisements page
    }
   

   
}