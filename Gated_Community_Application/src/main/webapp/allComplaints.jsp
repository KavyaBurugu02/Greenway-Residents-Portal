<%@page import="com.model.Complaint"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>All Complaints &mdash; Greenway Residents Portal</title>
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

<%
    Object r = session.getAttribute("role");
    if (session.getAttribute("userName") == null || r == null || !"admin".equalsIgnoreCase(r.toString())) {
        response.sendRedirect("index.jsp?error=access"); return;
    }
    @SuppressWarnings("unchecked")
    List<Complaint> all = (List<Complaint>) request.getAttribute("allComplaints");
    if (all == null) all = java.util.Collections.emptyList();
    String pageErr = request.getParameter("error");
%>

<%@ include file="header.jspf" %>

<main class="page">
    <div class="page-header">
        <h1>All Complaints</h1>
        <p><%= all.size() %> complaint<%= all.size() == 1 ? "" : "s" %> in total.</p>
    </div>

    <% if ("invalidId".equals(pageErr) || "notFound".equals(pageErr)) { %>
        <div class="alert alert-error">&#9888; That complaint could not be found.</div>
    <% } %>

    <div class="card">
        <% if (all.isEmpty()) { %>
            <div class="empty">
                <div class="empty-icon">&#9989;</div>
                <h3>No complaints</h3>
                <p>Residents haven't raised anything yet.</p>
            </div>
        <% } else { %>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Resident ID</th>
                            <th>Category</th>
                            <th>Subject</th>
                            <th>Description</th>
                            <th>Flat</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Complaint c : all) {
                            if (c == null) continue;
                            request.setAttribute("_bc", c);
                        %>
                        <tr>
                            <td>#<%= c.getComplaintId() %></td>
                            <td><%= c.getUserId() %></td>
                            <td><%= c.getCategory() %></td>
                            <td><%= c.getSubject() %></td>
                            <td><%= c.getDescription() %></td>
                            <td><%= c.getFlatNo() %></td>
                            <td><%@ include file="statusBadge.jspf" %></td>
                            <td>
                                <a href="loadStatus?complaintId=<%= c.getComplaintId() %>" class="btn btn-secondary btn-sm">Update Status</a>
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
