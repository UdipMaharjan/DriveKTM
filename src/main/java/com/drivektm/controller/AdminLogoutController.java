package com.drivektm.controller;

import com.drivektm.util.CookieUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin-logout")
public class AdminLogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminLogoutController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate();
        }

        CookieUtil.deleteCookie(response, "adminId");

        response.sendRedirect(request.getContextPath() + "/admin?success=logout");
    }
}