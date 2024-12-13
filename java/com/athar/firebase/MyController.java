package com.athar.firebase;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

@RestController
@RequestMapping("goal")
public class MyController {

    @Autowired
    private FirebaseDatabase firebaseDatabase;
    @GetMapping("yourendpoint")
    public String yourMethod() {
        return "response";
    }


    @GetMapping("/data")
    public String getData() {
        DatabaseReference ref = firebaseDatabase.getReference("users");

        ref.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                // Process data from Firebase
                System.out.println(dataSnapshot.getValue());
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                // Handle errors
                System.err.println("Error reading from database: " + databaseError.getMessage());
            }
        });

        return "Data fetched successfully";
    }
}