package com.athar.LocaLink.service;

import com.athar.LocaLink.model.Advertiser;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class AdminService {
    private final Firestore db;

    @Autowired
    public AdminService(Firestore db) {
        this.db = db;
    }

    public boolean validateAdmin(String email, String password) {
        // Hardcoded admin credentials (for demonstration purposes)
        return "admin@gmail.com".equals(email) && "1234".equals(password);
    }

    public List<Advertiser> getAllAdvertisers() {
        List<Advertiser> advertisers = new ArrayList<>();
        try {
            QuerySnapshot querySnapshot = db.collection("advertisers").get().get();
            System.out.println("Number of Advertisers Retrieved: " + querySnapshot.size());
            for (QueryDocumentSnapshot document : querySnapshot.getDocuments()) {
                Advertiser advertiser = document.toObject(Advertiser.class);
                System.out.println("Retrieved Advertiser: " + advertiser);
                advertisers.add(advertiser);
            }
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }
        return advertisers;
    }


    public void updateAdvertiserStatus(String advertiserId, String status) {
        if (advertiserId == null || advertiserId.isEmpty()) {
            throw new IllegalArgumentException("Advertiser ID cannot be null or empty");
        }
        ApiFuture<WriteResult> future = db.collection("advertisers").document(advertiserId).update("status", status);
        try {
            future.get();
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }
    }
}
