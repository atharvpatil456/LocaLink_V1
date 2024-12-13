package com.athar.LocaLink.model;



public class Advertiser {
    private String advertiserEmail;
    private String advertiserId;
    private String advertiserName;
    private String advertiserPassword;
    private String phoneNumber;
    private String status; // Field for admin approval
    private String businessLocation; // Field for business location
    private String shopDescription; // Field for shop description
    private double latitude; // Latitude for location-based approval
    private double longitude; // Longitude for location-based approval
    private String address; // Full address of the advertiser

    // Default constructor for Firebase
    public Advertiser() {}

    public Advertiser(String advertiserEmail, String advertiserId, String advertiserName, String advertiserPassword, String phoneNumber, String status, String businessLocation, String shopDescription, double latitude, double longitude, String address) {
        this.advertiserEmail = advertiserEmail;
        this.advertiserId = advertiserId;
        this.advertiserName = advertiserName;
        this.advertiserPassword = advertiserPassword;
        this.phoneNumber = phoneNumber;
        this.status = status;
        this.businessLocation = businessLocation;
        this.shopDescription = shopDescription;
        this.latitude = latitude;
        this.longitude = longitude;
        this.address = address;
    }

    // Getters and Setters
    public String getAdvertiserEmail() {
        return advertiserEmail;
    }

    public void setAdvertiserEmail(String advertiserEmail) {
        this.advertiserEmail = advertiserEmail;
    }

    public String getAdvertiserId() {
        return advertiserId;
    }

    public void setAdvertiserId(String advertiserId) {
        this.advertiserId = advertiserId;
    }

    public String getAdvertiserName() {
        return advertiserName;
    }

    public void setAdvertiserName(String advertiserName) {
        this.advertiserName = advertiserName;
    }

    public String getAdvertiserPassword() {
        return advertiserPassword;
    }

    public void setAdvertiserPassword(String advertiserPassword) {
        this.advertiserPassword = advertiserPassword;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getBusinessLocation() {
        return businessLocation;
    }

    public void setBusinessLocation(String businessLocation) {
        this.businessLocation = businessLocation;
    }

    public String getShopDescription() {
        return shopDescription;
    }

    public void setShopDescription(String shopDescription) {
        this.shopDescription = shopDescription;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
