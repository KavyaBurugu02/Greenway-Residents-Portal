<%@page import="com.model.Complaint"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Complaint &mdash; Greenway Residents Portal</title>
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

<%
    if (session.getAttribute("userName") == null) { response.sendRedirect("index.jsp?error=session"); return; }
    Complaint c = (Complaint) request.getAttribute("complaint");
    if (c == null) { response.sendRedirect("residentViewComplaintsServlet?error=notFound"); return; }
    String pageErr = request.getParameter("error");
%>

<%@ include file="header.jspf" %>

<main class="page" style="max-width: 680px;">
    <div class="page-header">
        <h1>Edit Complaint #<%= c.getComplaintId() %></h1>
        <p>Update the details below and save.</p>
    </div>

    <div class="card">
        <% if ("invalidInput".equals(pageErr)) { %>
            <div class="alert alert-error">&#9888; Please fill in all fields with valid values.</div>
        <% } %>

        <form action="saveComplaint" method="post">
            <input type="hidden" name="complaintId" value="<%= c.getComplaintId() %>">

            <div class="form-group">
                <label for="category">Category</label>
                <input type="text" id="category" name="category" value="<%= c.getCategory() %>" required>
            </div>
            <div class="form-group">
                <label for="subject">Subject</label>
                <input type="text" id="subject" name="subject" value="<%= c.getSubject() %>" required>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" required><%= c.getDescription() %></textarea>
            </div>
            <div class="form-group">
                <label for="flatNo">Flat number</label>
                <input type="number" id="flatNo" name="flatNo" value="<%= c.getFlatNo() %>" required min="1">
            </div>
            <div style="display:flex;gap:10px;flex-wrap:wrap;">
                <button type="submit" class="btn btn-primary">Save Changes</button>
                <a href="residentViewComplaintsServlet" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</main>

</body>
</html>
