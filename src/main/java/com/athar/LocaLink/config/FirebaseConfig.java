package com.athar.LocaLink.config;

import com.athar.LocaLink.ApiKey;
import com.google.api.services.storage.Storage;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreOptions;
import com.google.cloud.storage.StorageOptions;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.FileInputStream;
import java.io.IOException;

@Configuration
public class FirebaseConfig {

	ApiKey key = new ApiKey();
    @Bean
    public Firestore firestore() throws IOException {
        FileInputStream serviceAccount = new FileInputStream("src/main/resources/"+key.json);
        
        GoogleCredentials credentials = GoogleCredentials.fromStream(serviceAccount);
        FirestoreOptions firestoreOptions = FirestoreOptions.newBuilder()
                .setCredentials(credentials)
                .build();
        
        return firestoreOptions.getService();
    }

    @Bean
    public FirebaseAuth firebaseAuth() throws IOException {
    	ApiKey key = new ApiKey();
        FileInputStream serviceAccount = new FileInputStream("src/main/resources/"+key.json);
        
        GoogleCredentials credentials = GoogleCredentials.fromStream(serviceAccount);
        FirebaseOptions options = new FirebaseOptions.Builder()
                .setCredentials(credentials)
                
                .setStorageBucket(key.bucket)
                .build();
        
        if (FirebaseApp.getApps().isEmpty()) {
            FirebaseApp.initializeApp(options);
        }
        
        return FirebaseAuth.getInstance();
    }
    
//    @Bean
//    public Storage storage() throws IOException {
//        GoogleCredentials credentials = GoogleCredentials.fromStream(
//            getClass().getClassLoader().getResourceAsStream("localink-f948f-firebase-adminsdk-mit4k-7c30005b34.json")
//        );
//
//        StorageOptions options = StorageOptions.newBuilder()
//                .setCredentials(credentials)
//                .setProjectId("localink-f948f") // Replace with your actual project ID
//                .build();
//
//        return (Storage) options.getService();
//    }
}
