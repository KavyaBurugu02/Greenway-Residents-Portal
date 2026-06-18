package com.servlet;

import com.dao.LoginDao;
import com.model.Resident;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String username = req.getParameter("userName");
        String password = req.getParameter("password");

        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            req.setAttribute("errorMessage", "Please enter both username and password.");
            req.getRequestDispatcher("index.jsp").forward(req, res);
            return;
        }

        Resident resident = new LoginDao().authenticate(username.trim(), password);
        if (resident == null) {
            res.sendRedirect("index.jsp?error=invalid");
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("userName", resident.getUserName());
        session.setAttribute("residentId", resident.getResidentId());
        session.setAttribute("email", resident.getEmail());
        session.setAttribute("role", resident.getRole());
        session.setAttribute("phoneNumber", resident.getPhoneNumber());

        String role = resident.getRole();
        if ("resident".equalsIgnoreCase(role)) {
            res.sendRedirect("residentDashboard.jsp");
        } else if ("admin".equalsIgnoreCase(role)) {
            res.sendRedirect("adminDashboard.jsp");
        } else {
            session.invalidate();
            res.sendRedirect("index.jsp?error=role");
        }
    }
}
