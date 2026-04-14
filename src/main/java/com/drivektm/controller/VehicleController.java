package com.drivektm.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Home controller for loading the homepage
 * 
 * @author Udip Maharjan
 */
@WebServlet("/vehicles")
public class VehicleController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public VehicleController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Pages/vehicles.jsp").forward(request, response);
    }
}