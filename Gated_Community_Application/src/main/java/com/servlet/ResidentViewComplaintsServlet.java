package com.servlet;

import com.dao.ComplaintDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/residentViewComplaintsServlet")
public class ResidentViewComplaintsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Object residentId = session != null ? session.getAttribute("residentId") : null;
        if (residentId == null) {
            res.sendRedirect("index.jsp?error=session");
            return;
        }

        req.setAttribute("complaints", new ComplaintDao().getByResident((Integer) residentId));
        req.getRequestDispatcher("residentViewComplaints.jsp").forward(req, res);
    }
}
