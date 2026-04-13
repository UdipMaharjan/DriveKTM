package com.drivektm.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Hash plain password
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    // Check plain password against hashed password
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}