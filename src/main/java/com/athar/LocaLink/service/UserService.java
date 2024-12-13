package com.athar.LocaLink.service;

import com.athar.LocaLink.ApiKey;
import com.athar.LocaLink.model.User;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreOptions;
import com.google.cloud.firestore.WriteResult;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.google.firebase.auth.UserRecord;
import org.springframework.stereotype.Service;

import java.io.FileInputStream;
import java.io.IOException;

@Service
public class UserService {

    private final Firestore db;
    private final FirebaseAuth firebaseAuth;

    public UserService() throws IOException {
    	ApiKey key = new ApiKey();
        // Initialize Firestore
        FileInputStream serviceAccount = new FileInputStream("src/main/resources/"+key.json);
        FirestoreOptions firestoreOptions = FirestoreOptions.getDefaultInstance().toBuilder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .build();
        this.db = firestoreOptions.getService();

        // Initialize Firebase Authentication
        this.firebaseAuth = FirebaseAuth.getInstance();
    }

    public String registerUser(User user) throws FirebaseAuthException {
        // Register user in Firebase Authentication
        UserRecord.CreateRequest request = new UserRecord.CreateRequest()
                .setEmail(user.getUserEmail())
                .setPassword(user.getUserPassword())
                .setDisplayName(user.getUserName());

        UserRecord userRecord = firebaseAuth.createUser(request);
        return userRecord.getUid(); // Return the Firebase UID
    }

    public void saveUserToFirestore(User user) {
        // Store the user with UID as document ID in Firestore
        ApiFuture<WriteResult> future = db.collection("users").document(user.getUserId()).set(user);
        try {
            future.get(); // Ensure the write is completed
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String loginUser(String email, String password) throws FirebaseAuthException {
        // Fetch the user details from Firebase by email
        UserRecord userRecord = firebaseAuth.getUserByEmail(email);
        if (userRecord != null && userRecord.getEmail().equals(email)) {
            return userRecord.getUid(); // Return the UID if found
        }
        return null; // Return null if not found
    }

    public User getRegisteredUser(String uid) {
        // Retrieve user from Firestore by UID
        ApiFuture<DocumentSnapshot> future = db.collection("users").document(uid).get();
        try {
            DocumentSnapshot document = future.get();
            if (document.exists()) {
                return document.toObject(User.class); // Map Firestore document to User object
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
