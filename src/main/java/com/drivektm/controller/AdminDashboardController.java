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
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/admin-dashboard")
public class AdminDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminDashboardController() {
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

        int totalUsers = 0;
        int totalVehicles = 0;
        int totalBookings = 0;
        int pendingBookings = 0;

        try (Connection con = DBConfig.getConnection()) {

            totalUsers = getCount(con, "SELECT COUNT(*) FROM users");

            totalVehicles = getCount(con, "SELECT COUNT(*) FROM vehicles");

            totalBookings = getCount(con, "SELECT COUNT(*) FROM bookings");

            pendingBookings = getCount(con, "SELECT COUNT(*) FROM bookings WHERE booking_status = 'Pending'");

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalVehicles", totalVehicles);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("pendingBookings", pendingBookings);

        request.getRequestDispatcher("/WEB-INF/Pages/adminDashboard.jsp").forward(request, response);
    }

    private int getCount(Connection con, String sql) {
        int count = 0;

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
}