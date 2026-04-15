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

        try (Connection con = DBConfig.getConnection()) {

            String query = "SELECT COUNT(*) FROM users";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalUsers = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("totalUsers", totalUsers);
        request.getRequestDispatcher("/WEB-INF/Pages/adminDashboard.jsp").forward(request, response);
    }
}