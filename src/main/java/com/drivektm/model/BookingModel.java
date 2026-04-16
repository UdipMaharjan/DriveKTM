package com.drivektm.model;

import java.sql.Date;

public class BookingModel {
    private int bookingId;
    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private String vehicleName;
    private String pickupLocation;
    private String dropoffLocation;
    private Date pickupDate;
    private Date dropoffDate;
    private String message;

    public BookingModel() {
    }

    public BookingModel(int userId, String fullName, String email, String phone,
                        String vehicleName, String pickupLocation, String dropoffLocation,
                        Date pickupDate, Date dropoffDate, String message) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.vehicleName = vehicleName;
        this.pickupLocation = pickupLocation;
        this.dropoffLocation = dropoffLocation;
        this.pickupDate = pickupDate;
        this.dropoffDate = dropoffDate;
        this.message = message;
    }

    public BookingModel(int bookingId, int userId, String fullName, String email, String phone,
                        String vehicleName, String pickupLocation, String dropoffLocation,
                        Date pickupDate, Date dropoffDate, String message) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.vehicleName = vehicleName;
        this.pickupLocation = pickupLocation;
        this.dropoffLocation = dropoffLocation;
        this.pickupDate = pickupDate;
        this.dropoffDate = dropoffDate;
        this.message = message;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getVehicleName() {
        return vehicleName;
    }

    public void setVehicleName(String vehicleName) {
        this.vehicleName = vehicleName;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getDropoffLocation() {
        return dropoffLocation;
    }

    public void setDropoffLocation(String dropoffLocation) {
        this.dropoffLocation = dropoffLocation;
    }

    public Date getPickupDate() {
        return pickupDate;
    }

    public void setPickupDate(Date pickupDate) {
        this.pickupDate = pickupDate;
    }

    public Date getDropoffDate() {
        return dropoffDate;
    }

    public void setDropoffDate(Date dropoffDate) {
        this.dropoffDate = dropoffDate;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}