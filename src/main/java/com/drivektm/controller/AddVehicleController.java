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

@WebServlet("/add-vehicle")
public class AddVehicleController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddVehicleController() {
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

        request.getRequestDispatcher("/WEB-INF/Pages/addVehicle.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        String name = request.getParameter("vehicleName");
        String category = request.getParameter("category");
        String tag = request.getParameter("tag");
        String type = request.getParameter("vehicleType");
        String price = request.getParameter("pricePerDay");
        String fuel = request.getParameter("fuel");
        String seats = request.getParameter("seats");
        String feature = request.getParameter("feature");
        String image = request.getParameter("imageName");
        String status = request.getParameter("status");

        if (name == null || category == null || price == null ||
            name.trim().isEmpty() || category.trim().isEmpty() || price.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/add-vehicle?error=empty");
            return;
        }

        try (Connection con = DBConfig.getConnection()) {

            String sql = "INSERT INTO vehicles " +
                    "(vehicle_name, category, tag, vehicle_type, price_per_day, fuel, seats, feature, image_name, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, category);
            ps.setString(3, tag);
            ps.setString(4, type);
            ps.setInt(5, Integer.parseInt(price));
            ps.setString(6, fuel);
            ps.setString(7, seats);
            ps.setString(8, feature);
            ps.setString(9, image);
            ps.setString(10, status);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/admin-vehicles?success=added");
            } else {
                response.sendRedirect(request.getContextPath() + "/add-vehicle?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/add-vehicle?error=server");
        }
    }
}