package com.drivektm.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.drivektm.config.DBConfig;
import com.drivektm.model.ContactModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-messages")
public class AdminMessagesController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminMessagesController() {
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

        List<ContactModel> messages = new ArrayList<>();

        String sql = "SELECT id, full_name, phone, email, topic, message, status, created_at "
                   + "FROM contact_messages ORDER BY created_at DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ContactModel msg = new ContactModel();

                msg.setId(rs.getInt("id"));
                msg.setFullName(rs.getString("full_name"));
                msg.setPhone(rs.getString("phone"));
                msg.setEmail(rs.getString("email"));
                msg.setTopic(rs.getString("topic"));
                msg.setMessage(rs.getString("message"));
                msg.setStatus(rs.getString("status"));
                msg.setCreatedAt(rs.getString("created_at"));

                messages.add(msg);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unable to load contact messages.");
        }

        request.setAttribute("messages", messages);

        // Change this path only if your JSP file name is different
        request.getRequestDispatcher("/WEB-INF/Pages/adminMessages.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin-messages?error=invalid");
            return;
        }

        int id;

        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-messages?error=invalid");
            return;
        }

        try (Connection conn = DBConfig.getConnection()) {

            if ("delete".equals(action)) {
                String sql = "DELETE FROM contact_messages WHERE id = ?";

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }

                response.sendRedirect(request.getContextPath() + "/admin-messages?success=deleted");
                return;
            }

            if ("read".equals(action)) {
                String sql = "UPDATE contact_messages SET status = 'Read' WHERE id = ?";

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }

                response.sendRedirect(request.getContextPath() + "/admin-messages?success=read");
                return;
            }

            response.sendRedirect(request.getContextPath() + "/admin-messages?error=invalid");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-messages?error=server");
        }
    }
}