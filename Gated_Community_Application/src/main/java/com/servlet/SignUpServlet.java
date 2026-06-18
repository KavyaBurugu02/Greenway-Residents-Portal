package com.servlet;

import com.dao.LoginDao;
import com.dao.SignUpDao;
import com.model.Resident;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String username = trim(req.getParameter("userName"));
        String password = req.getParameter("password");
        String email = trim(req.getParameter("email"));
        String phone = trim(req.getParameter("phoneNumber"));

        String error = validate(username, password, email, phone);
        if (error != null) {
            req.setAttribute("errorMessage", error);
            req.getRequestDispatcher("signup.jsp").forward(req, res);
            return;
        }

        if (new LoginDao().usernameExists(username)) {
            req.setAttribute("errorMessage", "That username is already taken. Please choose another.");
            req.getRequestDispatcher("signup.jsp").forward(req, res);
            return;
        }

        boolean saved = new SignUpDao().save(new Resident(username, password, email, phone, "Resident"));
        if (saved) {
            res.sendRedirect("index.jsp?signup=success");
        } else {
            req.setAttribute("errorMessage", "We could not create your account. Please try again.");
            req.getRequestDispatcher("signup.jsp").forward(req, res);
        }
    }

    private String validate(String username, String password, String email, String phone) {
        if (username == null || username.isEmpty()) return "Username is required.";
        if (password == null || password.length() < 6) return "Password must be at least 6 characters.";
        if (email == null || !email.contains("@")) return "Please enter a valid email address.";
        if (phone == null || !phone.matches("\\d{10}")) return "Please enter a valid 10-digit phone number.";
        return null;
    }

    private String trim(String s) {
        return s == null ? null : s.trim();
    }
}
