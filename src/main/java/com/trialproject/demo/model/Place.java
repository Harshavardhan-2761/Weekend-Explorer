// src/main/java/com/example/demo/model/Place.java
package com.trialproject.demo.model;

public class Place {
    private String id;
    private String name;
    private String type;
    private String imageUrl;
    private String priceLevel;
    private double latitude;
    private double longitude;
    private String flagUrl;

    // Getters & Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getPriceLevel() { return priceLevel; }
    public void setPriceLevel(String priceLevel) { this.priceLevel = priceLevel; }

    public double getLatitude() { return latitude; }
    public void setLatitude(double latitude) { this.latitude = latitude; }

    public double getLongitude() { return longitude; }
    public void setLongitude(double longitude) { this.longitude = longitude; }
     public String getFlagUrl() {
        return flagUrl;
    }

    public void setFlagUrl(String flagUrl) {
        this.flagUrl = flagUrl;
    }
}
