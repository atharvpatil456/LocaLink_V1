package com.athar.LocaLink.model;

public class User {
    private String userId;      // Firebase UID
    private String userName;    // User's display name
    private String userEmail;   // User's email
    private String userNumber;  // User's phone number
    private String userPassword;


    public User() {
    }


    public User(String userId, String userName, String userEmail, String userNumber, String userPassword) {
        this.userId = userId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.userNumber = userNumber;
        this.userPassword = userPassword;
    }

    // Getters and Setters
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserNumber() {
        return userNumber;
    }

    public void setUserNumber(String userNumber) {
        this.userNumber = userNumber;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }
}
