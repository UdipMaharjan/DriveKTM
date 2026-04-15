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
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet("/admin-users")
public class AdminUsersController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminUsersController() {
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

        ArrayList<HashMap<String, String>> users = new ArrayList<>();

        try (Connection con = DBConfig.getConnection()) {

            String sql = "SELECT id, first_name, last_name, email, phone, license_type, created_at FROM users ORDER BY id DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                HashMap<String, String> user = new HashMap<>();

                user.put("id", String.valueOf(rs.getInt("id")));
                user.put("firstName", rs.getString("first_name"));
                user.put("lastName", rs.getString("last_name"));
                user.put("email", rs.getString("email"));
                user.put("phone", rs.getString("phone"));
                user.put("licenseType", rs.getString("license_type"));
                user.put("createdAt", String.valueOf(rs.getTimestamp("created_at")));

                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/Pages/adminUsers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        String userId = request.getParameter("userId");

        if (userId == null || userId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin-users?error=invalid");
            return;
        }

        try (Connection con = DBConfig.getConnection()) {

            int id = Integer.parseInt(userId);

            // 1. Delete bookings of this user first
            String deleteBookingsSql = "DELETE FROM bookings WHERE user_id = ?";
            PreparedStatement bookingPs = con.prepareStatement(deleteBookingsSql);
            bookingPs.setInt(1, id);
            bookingPs.executeUpdate();

            // 2. Then delete user
            String deleteUserSql = "DELETE FROM users WHERE id = ?";
            PreparedStatement userPs = con.prepareStatement(deleteUserSql);
            userPs.setInt(1, id);

            int result = userPs.executeUpdate();

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/admin-users?success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-users?error=notfound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-users?error=server");
        }
    }
}