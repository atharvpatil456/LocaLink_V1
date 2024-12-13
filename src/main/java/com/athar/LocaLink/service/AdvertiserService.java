package com.athar.LocaLink.service;

import com.athar.LocaLink.model.Advertisement;
import com.athar.LocaLink.model.Advertiser;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.ExecutionException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

@Service
public class AdvertiserService {

    private final Firestore db;
    
    @Autowired
    private Firestore firestore;

    @Autowired
    public AdvertiserService(Firestore db) {
        this.db = db;
    }

    public String registerAdvertiser(Advertiser advertiser) {
        
        String advertiserId = db.collection("advertisers").document().getId();
        advertiser.setAdvertiserId(advertiserId);

        
        saveAdvertiserToFirestore(advertiser);

        return advertiserId;
    }

    public void saveAdvertiserToFirestore(Advertiser advertiser) {
        ApiFuture<WriteResult> future = db.collection("advertisers").document(advertiser.getAdvertiserId()).set(advertiser);
        try {
            future.get();
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }
    }

    public boolean validateAdvertiser(String email, String password , String status) {
        ApiFuture<QuerySnapshot> future = db.collection("advertisers")
            .whereEqualTo("advertiserEmail", email)
            .whereEqualTo("advertiserPassword", password)
            .whereEqualTo("status",status)
            .get();

        try {
            DocumentSnapshot document = future.get().getDocuments().stream().findFirst().orElse(null);
            return document != null;
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Advertiser getRegisteredAdvertiser(String aid) {
        ApiFuture<DocumentSnapshot> future = db.collection("advertisers").document(aid).get();
        try {
            DocumentSnapshot document = future.get();
            if (document.exists()) {
                return document.toObject(Advertiser.class);
            }
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Advertiser> getAllAdvertisers() {
        ApiFuture<QuerySnapshot> future = db.collection("advertisers").get();
        try {
            return future.get().toObjects(Advertiser.class);
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Advertiser getAdvertiserById(String advertiserId) {
        ApiFuture<DocumentSnapshot> future = db.collection("advertisers").document(advertiserId).get();
        try {
            DocumentSnapshot document = future.get();
            if (document.exists()) {
                return document.toObject(Advertiser.class);
            }
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean saveAdvertisement(Advertisement ad, String advertiserEmail) {
        ad.setAdvertiserEmail(advertiserEmail);

        try {
            firestore.collection("advertisements").document(ad.getAdId()).set(ad).get();
            System.out.println("Advertisement saved successfully.");
            return true;
        } catch (Exception e) {
            System.err.println("Error saving advertisement: " + e.getMessage());
            return false;
        }
    }

    public List<Advertisement> getAdvertisementsByAdvertiser(String advertiserEmail) {
        List<Advertisement> advertisements = new ArrayList<>();
        try {
            List<QueryDocumentSnapshot> documents = firestore.collection("advertisements")
                    .whereEqualTo("advertiserEmail", advertiserEmail)
                    .get()
                    .get()
                    .getDocuments();
            for (QueryDocumentSnapshot document : documents) {
                advertisements.add(document.toObject(Advertisement.class));
            }
        } catch (Exception e) {
            System.err.println("Error retrieving advertisements: " + e.getMessage());
        }
        return advertisements;
    }
    
    
}
