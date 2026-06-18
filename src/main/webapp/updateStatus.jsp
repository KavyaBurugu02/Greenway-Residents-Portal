<%@page import="com.model.Complaint"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Status &mdash; Greenway Residents Portal</title>
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

<%
    Object r = session.getAttribute("role");
    if (session.getAttribute("userName") == null || r == null || !"admin".equalsIgnoreCase(r.toString())) {
        response.sendRedirect("index.jsp?error=access"); return;
    }
    Complaint c = (Complaint) request.getAttribute("complaint");
    if (c == null) { response.sendRedirect("adminServlet?error=notFound"); return; }
    String current = c.getStatus() != null ? c.getStatus() : "";
%>

<%@ include file="header.jspf" %>

<main class="page" style="max-width: 560px;">
    <div class="page-header">
        <h1>Update Status</h1>
        <p>Complaint #<%= c.getComplaintId() %>: <strong><%= c.getSubject() %></strong></p>
    </div>

    <div class="card">
        <form action="saveStatus" method="post">
            <input type="hidden" name="complaintId" value="<%= c.getComplaintId() %>">

            <div class="form-group">
                <label>Current status</label>
                <div class="radio-group">
                    <label class="radio-option">
                        <input type="radio" name="status" value="Open" <%= "Open".equalsIgnoreCase(current) ? "checked" : "" %>>
                        Open
                    </label>
                    <label class="radio-option">
                        <input type="radio" name="status" value="In Progress" <%= "In Progress".equalsIgnoreCase(current) || "Progress".equalsIgnoreCase(current) ? "checked" : "" %>>
                        In Progress
                    </label>
                    <label class="radio-option">
                        <input type="radio" name="status" value="Resolved" <%= "Resolved".equalsIgnoreCase(current) ? "checked" : "" %>>
                        Resolved
                    </label>
                </div>
            </div>

            <div style="display:flex;gap:10px;flex-wrap:wrap;">
                <button type="submit" class="btn btn-primary">Save</button>
                <a href="adminServlet" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</main>

</body>
</html>
