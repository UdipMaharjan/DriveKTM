package com.drivektm.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.drivektm.config.DBConfig;
import com.drivektm.model.BookingModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-bookings")
public class AdminBookingsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminBookingsController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        List<BookingModel> bookings = new ArrayList<>();

        String sql = "SELECT booking_id, user_id, full_name, email, phone, vehicle_name, "
                   + "pickup_location, dropoff_location, pickup_date, dropoff_date, "
                   + "message, booking_status, created_at "
                   + "FROM bookings ORDER BY created_at DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BookingModel booking = new BookingModel();

                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setFullName(rs.getString("full_name"));
                booking.setEmail(rs.getString("email"));
                booking.setPhone(rs.getString("phone"));
                booking.setVehicleName(rs.getString("vehicle_name"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropoffLocation(rs.getString("dropoff_location"));
                booking.setPickupDate(rs.getDate("pickup_date"));
                booking.setDropoffDate(rs.getDate("dropoff_date"));
                booking.setMessage(rs.getString("message"));
                booking.setBookingStatus(rs.getString("booking_status"));
                booking.setCreatedAt(rs.getString("created_at"));

                bookings.add(booking);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unable to load bookings.");
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/WEB-INF/Pages/adminBookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        String action = request.getParameter("action");
        String idParam = request.getParameter("bookingId");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin-bookings?error=invalid");
            return;
        }

        int bookingId;

        try {
            bookingId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-bookings?error=invalid");
            return;
        }

        try (Connection conn = DBConfig.getConnection()) {

            if ("confirm".equals(action)) {
                updateBookingStatus(conn, bookingId, "Confirmed");
                response.sendRedirect(request.getContextPath() + "/admin-bookings?success=confirmed");
                return;
            }

            if ("cancel".equals(action)) {
                updateBookingStatus(conn, bookingId, "Cancelled");
                response.sendRedirect(request.getContextPath() + "/admin-bookings?success=cancelled");
                return;
            }

            if ("delete".equals(action)) {
                String sql = "DELETE FROM bookings WHERE booking_id = ?";

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, bookingId);
                    ps.executeUpdate();
                }

                response.sendRedirect(request.getContextPath() + "/admin-bookings?success=deleted");
                return;
            }

            response.sendRedirect(request.getContextPath() + "/admin-bookings?error=invalid");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-bookings?error=server");
        }
    }

    private void updateBookingStatus(Connection conn, int bookingId, String status) throws Exception {
        String sql = "UPDATE bookings SET booking_status = ? WHERE booking_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            ps.executeUpdate();
        }
    }
}