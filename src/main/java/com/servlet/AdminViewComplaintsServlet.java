package com.servlet;

import com.dao.AdminDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/adminServlet")
public class AdminViewComplaintsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Object role = session != null ? session.getAttribute("role") : null;
        if (role == null || !"admin".equalsIgnoreCase(role.toString())) {
            res.sendRedirect("index.jsp?error=access");
            return;
        }

        req.setAttribute("allComplaints", new AdminDao().getAllComplaints());
        req.getRequestDispatcher("allComplaints.jsp").forward(req, res);
    }
}
