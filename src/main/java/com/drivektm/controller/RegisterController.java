package com.drivektm.controller;

import com.drivektm.config.DBConfig;
import com.drivektm.model.UserModel;
import com.drivektm.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegisterController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String licenseType = request.getParameter("licenseType");
        String terms = request.getParameter("terms");

        // Basic validation
        if (isEmpty(firstName) || isEmpty(lastName) || isEmpty(email) || isEmpty(password)) {
            response.sendRedirect("register?error=empty"
                    + "&firstName=" + enc(firstName)
                    + "&lastName=" + enc(lastName)
                    + "&email=" + enc(email)
                    + "&phone=" + enc(phone));
            return;
        }

        if (password.length() < 8) {
            response.sendRedirect("register?error=weak"
                    + "&firstName=" + enc(firstName)
                    + "&lastName=" + enc(lastName)
                    + "&email=" + enc(email)
                    + "&phone=" + enc(phone));
            return;
        }

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register?error=nomatch"
                    + "&firstName=" + enc(firstName)
                    + "&lastName=" + enc(lastName)
                    + "&email=" + enc(email)
                    + "&phone=" + enc(phone));
            return;
        }

        if (terms == null) {
            response.sendRedirect("register?error=terms"
                    + "&firstName=" + enc(firstName)
                    + "&lastName=" + enc(lastName)
                    + "&email=" + enc(email)
                    + "&phone=" + enc(phone));
            return;
        }

        String hashedPassword = PasswordUtil.hashPassword(password);

        UserModel user = new UserModel(
                firstName,
                lastName,
                email,
                phone,
                hashedPassword,
                licenseType
        );

        try (Connection con = DBConfig.getConnection()) {

            // Check if email already exists
            String checkSql = "SELECT id FROM users WHERE email = ?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setString(1, user.getEmail());

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                response.sendRedirect("register?error=exists"
                        + "&firstName=" + enc(user.getFirstName())
                        + "&lastName=" + enc(user.getLastName())
                        + "&phone=" + enc(user.getPhone()));
                return;
            }

            // Insert user into the database
            String insertSql = "INSERT INTO users (first_name, last_name, email, phone, password, license_type) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(insertSql);

            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getPassword());
            ps.setString(6, user.getLicenseType());

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("login?success=registered");
            } else {
                response.sendRedirect("register?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register?error=server");
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String enc(String value) {
        return value == null ? "" : URLEncoder.encode(value, StandardCharsets.UTF_8);
    }
}