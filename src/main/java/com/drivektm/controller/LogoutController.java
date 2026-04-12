package com.drivektm.controller;

import com.drivektm.util.CookieUtil;
import com.drivektm.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LogoutController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Invalidate session
        SessionUtil.invalidateSession(request.getSession());

        // Delete cookies (userId)
        CookieUtil.deleteCookie(response, "userId");

        // Redirect to login page after logout with a success message
        response.sendRedirect("login?logout=success");
    }

    // You could optionally implement doPost as well, but GET is preferred for logout
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}