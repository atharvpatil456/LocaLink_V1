package com.athar.LocaLink;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Objects;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.v1.FirestoreClient;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Base64;
import javax.annotation.PostConstruct;

@SpringBootApplication
public class LocaLinkApplication {

	public static void main(String[] args) throws IOException  {
		ClassLoader classLoader = LocaLinkApplication.class.getClassLoader();
		 ApiKey key = new ApiKey();
		String firebaseConfig = System.getenv("FIREBASE_CONFIG");
            byte[] decodedBytes = Base64.getDecoder().decode(firebaseConfig);
            InputStream serviceAccount = new ByteArrayInputStream(decodedBytes);
		
		//File file  = new 
				//File(Objects.requireNonNull(classLoader.getResource(key.json)).getFile());
		
		//FileInputStream serviceaccount = new FileInputStream("src/main/resources/"+key.json);
		
		
		FirebaseOptions options = new FirebaseOptions.Builder()
				  .setCredentials(GoogleCredentials.fromStream(serviceaccount))
				  .setStorageBucket(key.bucket)
				  
				  .build();

				FirebaseApp.initializeApp(options);
		
		
		SpringApplication.run(LocaLinkApplication.class, args);
	}
	

}
