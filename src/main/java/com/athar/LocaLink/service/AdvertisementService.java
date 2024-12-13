package com.athar.LocaLink.service;

import com.athar.LocaLink.model.Advertisement;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
public class AdvertisementService {

    @Autowired
    private Firestore firestore;

    // Save Advertisement
    public boolean saveAdvertisement(Advertisement ad, String advertiserEmail) {
        ad.setAdvertiserEmail(advertiserEmail);

        Map<String, Object> adData = new HashMap<>();
        adData.put("adId", ad.getAdId());
        adData.put("adName", ad.getAdName());
        adData.put("adDesc", ad.getAdDesc());
        adData.put("adPrice", ad.getAdPrice());
        adData.put("imageUrl", ad.getImageUrl());
        adData.put("latitude", ad.getLatitude());
        adData.put("longitude", ad.getLongitude());
        adData.put("advertiserEmail", ad.getAdvertiserEmail());
        adData.put("category", ad.getCategory());
        adData.put("rating", ad.getRating());
        adData.put("ratingCount", ad.getRatingCount());

        try {
            firestore.collection("advertisements").document(ad.getAdId()).set(adData).get();
            System.out.println("Advertisement saved successfully.");
            return true;
        } catch (InterruptedException | ExecutionException e) {
            System.err.println("Error saving advertisement: " + e.getMessage());
            Thread.currentThread().interrupt(); // Handle interrupt appropriately
            return false;
        }
    }

    // Retrieve all advertisements for a specific advertiser
    public List<Advertisement> getAdvertisementsByAdvertiser(String advertiserEmail) {
        List<Advertisement> ads = new ArrayList<>();
        try {
            QuerySnapshot querySnapshot = firestore.collection("advertisements")
                    .whereEqualTo("advertiserEmail", advertiserEmail).get().get();
            for (QueryDocumentSnapshot document : querySnapshot.getDocuments()) {
                Advertisement ad = document.toObject(Advertisement.class);
                ads.add(ad);
            }
            System.out.println("Advertisements retrieved successfully.");
        } catch (InterruptedException | ExecutionException e) {
            System.err.println("Error retrieving advertisements: " + e.getMessage());
            Thread.currentThread().interrupt(); // Handle interrupt appropriately
        }
        return ads;
    }

    // Update an advertisement
//    public boolean updateAdvertisement(Advertisement ad) {
//        try {
//            firestore.collection("advertisements").document(ad.getAdId()).set(ad).get();
//            System.out.println("Advertisement updated successfully.");
//            return true;
//        } catch (InterruptedException | ExecutionException e) {
//            System.err.println("Error updating advertisement: " + e.getMessage());
//            Thread.currentThread().interrupt(); // Handle interrupt appropriately
//            return false;
//        }
//    }

    
    
    // Method to find an advertisement by ID
    public Advertisement findById(String adId) throws InterruptedException, ExecutionException {
        // Logic to retrieve advertisement from Firestore by adId
        DocumentReference docRef = firestore.collection("advertisements").document(adId);
        return docRef.get().get().toObject(Advertisement.class);
    }

    // Method to update an advertisement
    public void updateAdvertisement(Advertisement advertisement) {
        // Logic to update the advertisement in Firestore
        DocumentReference docRef = firestore.collection("advertisements").document(advertisement.getAdId());
        docRef.set(advertisement); // Updates the document with the new values
    }
    
    public void deleteAdvertisement(String adId) {
        DocumentReference docRef = firestore.collection("advertisements").document(adId);
        docRef.delete(); // Deletes the advertisement document from Firestore
    }
}
