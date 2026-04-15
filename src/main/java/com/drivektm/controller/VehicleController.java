package com.drivektm.controller;

import com.drivektm.config.DBConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet("/vehicles")
public class VehicleController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public VehicleController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<HashMap<String, String>> cars = new ArrayList<>();
        ArrayList<HashMap<String, String>> bikes = new ArrayList<>();
        ArrayList<HashMap<String, String>> scooters = new ArrayList<>();
        ArrayList<HashMap<String, String>> bicycles = new ArrayList<>();

        try (Connection con = DBConfig.getConnection()) {

            String sql = "SELECT * FROM vehicles WHERE status = 'Available' ORDER BY vehicle_id ASC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                HashMap<String, String> vehicle = new HashMap<>();

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

                String category = rs.getString("category");

                if ("Cars".equalsIgnoreCase(category)) {
                    cars.add(vehicle);
                } else if ("Bikes".equalsIgnoreCase(category)) {
                    bikes.add(vehicle);
                } else if ("Scooters".equalsIgnoreCase(category)) {
                    scooters.add(vehicle);
                } else if ("Bicycles".equalsIgnoreCase(category)) {
                    bicycles.add(vehicle);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("cars", cars);
        request.setAttribute("bikes", bikes);
        request.setAttribute("scooters", scooters);
        request.setAttribute("bicycles", bicycles);

        request.getRequestDispatcher("/WEB-INF/Pages/vehicles.jsp").forward(request, response);
    }
}