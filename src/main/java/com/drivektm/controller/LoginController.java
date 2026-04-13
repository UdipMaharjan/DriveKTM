package com.drivektm.controller;

import com.drivektm.config.DBConfig;
import com.drivektm.util.PasswordUtil;
import com.drivektm.util.CookieUtil;
import com.drivektm.util.SessionUtil;
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

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validation
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect("login?error=empty");
            return;
        }

        try (Connection con = DBConfig.getConnection()) {

            // Query to check user credentials
        	String query = "SELECT * FROM users WHERE email = ?";
        	PreparedStatement ps = con.prepareStatement(query);
        	ps.setString(1, email);

        	ResultSet rs = ps.executeQuery();

        	if (rs.next()) {
        	    String storedHashedPassword = rs.getString("password");

        	    if (PasswordUtil.checkPassword(password, storedHashedPassword)) {
        	        HttpSession session = request.getSession();
        	        session.setAttribute("userId", rs.getInt("id"));
        	        session.setAttribute("userName", rs.getString("first_name") + " " + rs.getString("last_name"));
        	        session.setAttribute("userEmail", rs.getString("email"));

        	        CookieUtil.addCookie(response, "userId", String.valueOf(rs.getInt("id")), 3600);
        	        response.sendRedirect("home");
        	    } else {
        	        response.sendRedirect("login?error=invalid");
        	    }
        	} else {
        	    response.sendRedirect("login?error=invalid");
        	}

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login?error=server");
        }
    }
}