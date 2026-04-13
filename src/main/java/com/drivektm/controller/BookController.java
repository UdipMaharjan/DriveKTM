package com.drivektm.controller;

import com.drivektm.config.DBConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;

@WebServlet("/book")
public class BookController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BookController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Pages/book.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=pleaselogin");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String vehicleName = request.getParameter("vehicleName");
        String pickupLocation = request.getParameter("pickupLocation");
        String dropoffLocation = request.getParameter("dropoffLocation");
        String pickupDateStr = request.getParameter("pickupDate");
        String dropoffDateStr = request.getParameter("dropoffDate");
        String message = request.getParameter("message");

        if (isEmpty(fullName) || isEmpty(email) || isEmpty(phone) || isEmpty(vehicleName)
                || isEmpty(pickupLocation) || isEmpty(dropoffLocation)
                || isEmpty(pickupDateStr) || isEmpty(dropoffDateStr)) {
            response.sendRedirect(request.getContextPath() + "/book?error=empty");
            return;
        }

        try {
            Date pickupDate = Date.valueOf(pickupDateStr);
            Date dropoffDate = Date.valueOf(dropoffDateStr);

            if (dropoffDate.before(pickupDate)) {
                response.sendRedirect(request.getContextPath() + "/book?error=invaliddates");
                return;
            }

            int userId = (Integer) session.getAttribute("userId");

            String sql = "INSERT INTO bookings "
                    + "(user_id, full_name, email, phone, vehicle_name, pickup_location, dropoff_location, pickup_date, dropoff_date, message) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (Connection con = DBConfig.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, userId);
                ps.setString(2, fullName);
                ps.setString(3, email);
                ps.setString(4, phone);
                ps.setString(5, vehicleName);
                ps.setString(6, pickupLocation);
                ps.setString(7, dropoffLocation);
                ps.setDate(8, pickupDate);
                ps.setDate(9, dropoffDate);
                ps.setString(10, message);

                int result = ps.executeUpdate();

                if (result > 0) {
                    response.sendRedirect(request.getContextPath() + "/book?success=booked");
                } else {
                    response.sendRedirect(request.getContextPath() + "/book?error=server");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/book?error=server");
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}