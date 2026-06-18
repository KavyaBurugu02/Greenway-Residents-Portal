package com.servlet;

import com.dao.ComplaintDao;
import com.model.Complaint;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/updateComplaint")
public class UpdateComplaintServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Integer id = parseInt(req.getParameter("complaintId"));
        if (id == null) {
            res.sendRedirect("residentViewComplaintsServlet?error=invalidId");
            return;
        }

        Complaint complaint = new ComplaintDao().getById(id);
        if (complaint == null) {
            res.sendRedirect("residentViewComplaintsServlet?error=notFound");
            return;
        }

        req.setAttribute("complaint", complaint);
        req.getRequestDispatcher("updateComplaint.jsp").forward(req, res);
    }

    private Integer parseInt(String s) {
        if (s == null || s.isBlank()) return null;
        try { return Integer.parseInt(s.trim()); } catch (NumberFormatException e) { return null; }
    }
}
