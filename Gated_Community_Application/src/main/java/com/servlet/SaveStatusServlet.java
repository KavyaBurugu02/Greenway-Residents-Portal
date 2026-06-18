package com.servlet;

import com.dao.ComplaintDao;
import com.model.Complaint;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/saveStatus")
public class SaveStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Integer id = parseInt(req.getParameter("complaintId"));
        if (id == null) {
            res.sendRedirect("adminServlet?error=invalidId");
            return;
        }

        String status = req.getParameter("status");
        if (status == null || status.isBlank()) {
            res.sendRedirect("loadStatus?complaintId=" + id + "&error=noStatus");
            return;
        }

        ComplaintDao dao = new ComplaintDao();
        Complaint complaint = dao.getById(id);
        if (complaint == null) {
            res.sendRedirect("adminServlet?error=notFound");
            return;
        }

        complaint.setStatus(status.trim());
        dao.update(complaint);
        res.sendRedirect("adminServlet");
    }

    private Integer parseInt(String s) {
        if (s == null || s.isBlank()) return null;
        try { return Integer.parseInt(s.trim()); } catch (NumberFormatException e) { return null; }
    }
}
