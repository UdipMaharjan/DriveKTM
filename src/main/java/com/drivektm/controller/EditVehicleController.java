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
import java.util.HashMap;

@WebServlet("/edit-vehicle")
public class EditVehicleController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EditVehicleController() {
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

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin-vehicles?error=invalid");
            return;
        }

        HashMap<String, String> vehicle = new HashMap<>();

        try (Connection con = DBConfig.getConnection()) {

            String sql = "SELECT * FROM vehicles WHERE vehicle_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                vehicle.put("id", String.valueOf(rs.getInt("vehicle_id")));
                vehicle.put("name", rs.getString("vehicle_name"));
                vehicle.put("category", rs.getString("category"));
                vehicle.put("tag", rs.getString("tag"));
                vehicle.put("type", rs.getString("vehicle_type"));
                vehicle.put("price", String.valueOf(rs.getInt("price_per_day")));
                vehicle.put("fuel", rs.getString("fuel"));
                vehicle.put("seats", rs.getString("seats"));
                vehicle.put("feature", rs.getString("feature"));
                vehicle.put("image", rs.getString("image_name"));
                vehicle.put("status", rs.getString("status"));
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-vehicles?error=notfound");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-vehicles?error=server");
            return;
        }

        request.setAttribute("vehicle", vehicle);
        request.getRequestDispatcher("/WEB-INF/Pages/editVehicle.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        String id = request.getParameter("id");
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

        if (id == null || name == null || category == null || price == null ||
            id.trim().isEmpty() || name.trim().isEmpty() || category.trim().isEmpty() || price.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin-vehicles?error=empty");
            return;
        }

        try (Connection con = DBConfig.getConnection()) {

            String sql = "UPDATE vehicles SET vehicle_name=?, category=?, tag=?, vehicle_type=?, price_per_day=?, fuel=?, seats=?, feature=?, image_name=?, status=? WHERE vehicle_id=?";

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
            ps.setInt(11, Integer.parseInt(id));

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/admin-vehicles?success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-vehicles?error=notfound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-vehicles?error=server");
        }
    }
}