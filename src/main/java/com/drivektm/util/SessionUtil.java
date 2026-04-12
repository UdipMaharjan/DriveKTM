package com.drivektm.util;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;

public class SessionUtil {

    // Create or get a session
    public static HttpSession getSession(HttpServletRequest request) {
        // Using request.getSession() to get the session
        HttpSession session = request.getSession();  // Get or create a new session
        return session;
    }

    // Get session attribute
    public static Object getAttribute(HttpSession session, String attribute) {
        return session.getAttribute(attribute);
    }

    // Set session attribute
    public static void setAttribute(HttpSession session, String attribute, Object value) {
        session.setAttribute(attribute, value);
    }

    // Remove session attribute
    public static void removeAttribute(HttpSession session, String attribute) {
        session.removeAttribute(attribute);
    }

    // Invalidate session
    public static void invalidateSession(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
    }
}