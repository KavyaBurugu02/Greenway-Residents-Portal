<%@page import="com.model.Complaint"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Complaints &mdash; Greenway Residents Portal</title>
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

<%
    if (session.getAttribute("userName") == null) { response.sendRedirect("index.jsp?error=session"); return; }
    @SuppressWarnings("unchecked")
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    if (complaints == null) complaints = java.util.Collections.emptyList();
    String pageErr = request.getParameter("error");
%>

<%@ include file="header.jspf" %>

<main class="page">
    <div class="page-header flex-row">
        <div>
            <h1>My Complaints</h1>
            <p>Everything you've reported and its current status.</p>
        </div>
        <a href="raiseComplaint.jsp" class="btn btn-primary">+ New Complaint</a>
    </div>

    <% if ("invalidId".equals(pageErr) || "notFound".equals(pageErr)) { %>
        <div class="alert alert-error">&#9888; That complaint could not be found.</div>
    <% } %>

    <div class="card">
        <% if (complaints.isEmpty()) { %>
            <div class="empty">
                <div class="empty-icon">&#128203;</div>
                <h3>No complaints yet</h3>
                <p>Raise one and it will appear here.</p>
            </div>
        <% } else { %>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Category</th>
                            <th>Subject</th>
                            <th>Description</th>
                            <th>Flat</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Complaint c : complaints) {
                            if (c == null) continue;
                            request.setAttribute("_bc", c);
                        %>
                        <tr>
                            <td>#<%= c.getComplaintId() %></td>
                            <td><%= c.getCategory() %></td>
                            <td><%= c.getSubject() %></td>
                            <td><%= c.getDescription() %></td>
                            <td><%= c.getFlatNo() %></td>
                            <td><%@ include file="statusBadge.jspf" %></td>
                            <td>
                                <div class="cell-actions">
                                    <a href="updateComplaint?complaintId=<%= c.getComplaintId() %>" class="btn btn-secondary btn-sm">Edit</a>
                                    <a href="deleteComplaint?complaintId=<%= c.getComplaintId() %>"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Cancel this complaint?')">Cancel</a>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
    </div>
</main>

</body>
</html>
