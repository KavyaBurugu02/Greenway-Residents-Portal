package com.servlet;

import com.dao.ComplaintDao;
import com.model.Complaint;
import com.util.ComplaintStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/complaintsServlet")
public class ComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Object residentIdAttr = session != null ? session.getAttribute("residentId") : null;
        if (residentIdAttr == null) {
            res.sendRedirect("index.jsp?error=session");
            return;
        }

        String category = req.getParameter("category");
        String subject = trim(req.getParameter("subject"));
        String description = trim(req.getParameter("description"));
        String flatParam = req.getParameter("flatNo");

        if (isBlank(category) || isBlank(subject) || isBlank(description) || isBlank(flatParam)) {
            req.setAttribute("errorMessage", "Please fill in all fields before submitting.");
            req.getRequestDispatcher("raiseComplaint.jsp").forward(req, res);
            return;
        }

        int flatNo;
        try {
            flatNo = Integer.parseInt(flatParam.trim());
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Flat number must be a valid number.");
            req.getRequestDispatcher("raiseComplaint.jsp").forward(req, res);
            return;
        }

        Complaint complaint = new Complaint((Integer) residentIdAttr, category, subject, description, flatNo);
        complaint.setStatus(ComplaintStatus.OPEN);

        boolean saved = new ComplaintDao().save(complaint);
        if (!saved) {
            req.setAttribute("errorMessage", "Could not submit your complaint. Please try again.");
            req.getRequestDispatcher("raiseComplaint.jsp").forward(req, res);
            return;
        }

        res.sendRedirect("residentViewComplaintsServlet");
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private String trim(String s) {
        return s == null ? null : s.trim();
    }
}
