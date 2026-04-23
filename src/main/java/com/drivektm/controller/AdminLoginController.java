package com.drivektm.controller;
import com.drivektm.model.AdminModel;
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
        	response.sendRedirect(request.getContextPath() + "/admin?error=empty");
            return;
        }

        try (Connection con = DBConfig.getConnection()) {

            String query = "SELECT * FROM admin WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                AdminModel admin = new AdminModel();
                admin.setAdminId(rs.getInt("admin_id"));
                admin.setEmail(rs.getString("email"));
                admin.setPassword(rs.getString("password"));

                if (password.equals(admin.getPassword())) {
                    HttpSession session = request.getSession();
                    session.setAttribute("adminId", admin.getAdminId());
                    session.setAttribute("adminEmail", admin.getEmail());

                    CookieUtil.addCookie(response, "adminId", String.valueOf(admin.getAdminId()), 3600);

                    response.sendRedirect(request.getContextPath() + "/admin-dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin?error=invalid");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin?error=server");
        }
    }
}