package com.servlet;

import com.dao.ResidentDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/complaintsHistory")
public class ComplaintsHistoryServlet extends HttpServlet {

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

        req.setAttribute("resolvedComplaints", new ResidentDao().getResolvedComplaints((Integer) residentId));
        req.getRequestDispatcher("complaintsHistory.jsp").forward(req, res);
    }
}
