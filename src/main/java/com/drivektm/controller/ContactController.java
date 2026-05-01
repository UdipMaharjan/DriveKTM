package com.drivektm.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.drivektm.config.DBConfig;
import com.drivektm.model.ContactModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/contact")
public class ContactController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ContactController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Pages/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String topic = request.getParameter("topic");
        String message = request.getParameter("message");

        if (fullName == null || fullName.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || topic == null || topic.trim().isEmpty()
                || message == null || message.trim().isEmpty()) {

            response.sendRedirect(request.getContextPath() + "/contact?error=empty");
            return;
        }

        ContactModel contact = new ContactModel(
                fullName.trim(),
                phone.trim(),
                email.trim(),
                topic.trim(),
                message.trim()
        );

        String sql = "INSERT INTO contact_messages (full_name, phone, email, topic, message) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, contact.getFullName());
            ps.setString(2, contact.getPhone());
            ps.setString(3, contact.getEmail());
            ps.setString(4, contact.getTopic());
            ps.setString(5, contact.getMessage());

            int row = ps.executeUpdate();

            if (row > 0) {
                response.sendRedirect(request.getContextPath() + "/contact?success=sent");
            } else {
                response.sendRedirect(request.getContextPath() + "/contact?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/contact?error=server");
        }
    }
}