package com.athar.LocaLink.service;

import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.UUID;

@Service
public class FirebaseStorageService {

    private final String BUCKET_NAME = "localinkv0.appspot.com"; // Use your Firebase Storage bucket

    private final Storage storage = StorageOptions.getDefaultInstance().getService();

    public String uploadFile(MultipartFile file) throws IOException {
        
        String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();

        
        BlobInfo blobInfo = BlobInfo.newBuilder(BUCKET_NAME, fileName).build();

        storage.create(blobInfo, file.getBytes());

    
        return "https://storage.googleapis.com/" + BUCKET_NAME + "/" + fileName;
    }
}
