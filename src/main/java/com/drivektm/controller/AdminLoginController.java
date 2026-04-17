package com.drivektm.controller;

import com.drivektm.config.DBConfig;
import com.drivektm.util.CookieUtil;

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

@WebServlet("/admin")
public class AdminLoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminLoginController() {
        super();
    }

    // Opens admin login page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Pages/adminLogin.jsp").forward(request, response);
    }

    // Handles admin login form submit
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect("admin?error=empty");
            return;
        }

        try (Connection con = DBConfig.getConnection()) {

            String query = "SELECT * FROM admin WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                // If your admin password is plain text in database
                if (password.equals(storedPassword)) {

                    HttpSession session = request.getSession();
                    session.setAttribute("adminId", rs.getInt("admin_id"));
                    session.setAttribute("adminEmail", rs.getString("email"));

                    CookieUtil.addCookie(response, "adminId", String.valueOf(rs.getInt("admin_id")), 3600);

                    response.sendRedirect("admin-dashboard");

                } else {
                    response.sendRedirect("admin?error=invalid");
                }

            } else {
                response.sendRedirect("admin?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin?error=server");
        }
    }
}