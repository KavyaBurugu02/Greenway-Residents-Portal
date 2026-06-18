package com.servlet;

import com.dao.ComplaintDao;
import com.model.Complaint;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/saveComplaint")
public class SaveComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Integer id = parseInt(req.getParameter("complaintId"));
        if (id == null) {
            res.sendRedirect("residentViewComplaintsServlet?error=invalidId");
            return;
        }

        String category = req.getParameter("category");
        String subject = trim(req.getParameter("subject"));
        String description = trim(req.getParameter("description"));
        Integer flatNo = parseInt(req.getParameter("flatNo"));

        if (isBlank(category) || isBlank(subject) || isBlank(description) || flatNo == null) {
            res.sendRedirect("updateComplaint?complaintId=" + id + "&error=invalidInput");
            return;
        }

        ComplaintDao dao = new ComplaintDao();
        Complaint complaint = dao.getById(id);
        if (complaint == null) {
            res.sendRedirect("residentViewComplaintsServlet?error=notFound");
            return;
        }

        complaint.setCategory(category);
        complaint.setSubject(subject);
        complaint.setDescription(description);
        complaint.setFlatNo(flatNo);
        dao.update(complaint);

        res.sendRedirect("residentViewComplaintsServlet");
    }

    private Integer parseInt(String s) {
        if (s == null || s.isBlank()) return null;
        try { return Integer.parseInt(s.trim()); } catch (NumberFormatException e) { return null; }
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private String trim(String s) {
        return s == null ? null : s.trim();
    }
}
