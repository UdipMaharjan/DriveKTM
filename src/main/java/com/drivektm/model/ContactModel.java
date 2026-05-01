package com.drivektm.model;

public class ContactModel {
    private int id;
    private String fullName;
    private String phone;
    private String email;
    private String topic;
    private String message;
    private String status;
    private String createdAt;

    public ContactModel() {
    }

    public ContactModel(String fullName, String phone, String email, String topic, String message) {
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.topic = topic;
        this.message = message;
    }

    public ContactModel(int id, String fullName, String phone, String email, String topic,
                        String message, String status, String createdAt) {
        this.id = id;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.topic = topic;
        this.message = message;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}