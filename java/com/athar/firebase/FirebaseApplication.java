package com.athar.firebase;

import java.io.FileInputStream;
import java.io.IOException;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

@SpringBootApplication
public class FirebaseApplication {

//	@Bean
//    public FirebaseApp initializeFirebaseApp() throws IOException {
//        FileInputStream serviceAccount = new FileInputStream("src\\main\\resources\\templates\\Firebase.json");
//
//        FirebaseOptions options = new FirebaseOptions.Builder()
//                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
//                .build();
//
//        return FirebaseApp.initializeApp(options);
//    }
	public static void main(String[] args) {
		SpringApplication.run(FirebaseApplication.class, args);
	}

}
