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
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet("/admin-vehicles")
public class AdminVehiclesController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminVehiclesController() {
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

    ArrayList<HashMap<String, String>> vehicles = new ArrayList<>();

    String search = request.getParameter("search");
    if (search == null) {
        search = "";
    }
    search = search.trim();

    String sort = request.getParameter("sort");
    if (sort == null || sort.trim().isEmpty()) {
        sort = "latest";
    }

    String orderBy = "vehicle_id DESC"; // default latest

    if ("oldest".equals(sort)) {
        orderBy = "vehicle_id ASC";
    } else if ("name_asc".equals(sort)) {
        orderBy = "vehicle_name ASC";
    } else if ("name_desc".equals(sort)) {
        orderBy = "vehicle_name DESC";
    } else if ("price_asc".equals(sort)) {
        orderBy = "price_per_day ASC";
    } else if ("price_desc".equals(sort)) {
        orderBy = "price_per_day DESC";
    } else if ("status".equals(sort)) {
        orderBy = "status ASC, vehicle_id DESC";
    }

    try (Connection con = DBConfig.getConnection()) {

        String sql;
        PreparedStatement ps;

        if (search.isEmpty()) {
            sql = "SELECT * FROM vehicles ORDER BY " + orderBy;
            ps = con.prepareStatement(sql);
        } else {
            sql = "SELECT * FROM vehicles "
                + "WHERE vehicle_name LIKE ? "
                + "OR category LIKE ? "
                + "OR vehicle_type LIKE ? "
                + "OR status LIKE ? "
                + "ORDER BY " + orderBy;

            ps = con.prepareStatement(sql);

            String keyword = "%" + search + "%";
            ps.setString(1, keyword);
            ps.setString(2, keyword);
            ps.setString(3, keyword);
            ps.setString(4, keyword);
        }

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            HashMap<String, String> vehicle = new HashMap<>();

            vehicle.put("id", String.valueOf(rs.getInt("vehicle_id")));
            vehicle.put("name", rs.getString("vehicle_name"));
            vehicle.put("category", rs.getString("category"));
            vehicle.put("type", rs.getString("vehicle_type"));
            vehicle.put("price", String.valueOf(rs.getInt("price_per_day")));
            vehicle.put("image", rs.getString("image_name"));
            vehicle.put("status", rs.getString("status"));

            vehicles.add(vehicle);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    request.setAttribute("vehicles", vehicles);
    request.setAttribute("search", search);
    request.setAttribute("sort", sort);

    request.getRequestDispatcher("/WEB-INF/Pages/adminVehicles.jsp").forward(request, response);
}
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        String vehicleId = request.getParameter("vehicleId");

        if (vehicleId == null || vehicleId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin-vehicles?error=invalid");
            return;
        }

        try (Connection con = DBConfig.getConnection()) {

            String sql = "DELETE FROM vehicles WHERE vehicle_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(vehicleId));

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/admin-vehicles?success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-vehicles?error=notfound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-vehicles?error=server");
        }
    }
}