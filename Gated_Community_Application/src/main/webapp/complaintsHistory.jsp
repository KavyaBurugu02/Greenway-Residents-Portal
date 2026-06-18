<%@page import="com.model.Complaint"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Complaint History &mdash; Greenway Residents Portal</title>
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

<%
    if (session.getAttribute("userName") == null) { response.sendRedirect("index.jsp?error=session"); return; }
    @SuppressWarnings("unchecked")
    List<Complaint> resolved = (List<Complaint>) request.getAttribute("resolvedComplaints");
    if (resolved == null) resolved = java.util.Collections.emptyList();
%>

<%@ include file="header.jspf" %>

<main class="page">
    <div class="page-header">
        <h1>Complaint History</h1>
        <p>Resolved complaints from your account.</p>
    </div>

    <div class="card">
        <% if (resolved.isEmpty()) { %>
            <div class="empty">
                <div class="empty-icon">&#9989;</div>
                <h3>Nothing resolved yet</h3>
                <p>Once a complaint is marked resolved, it appears here.</p>
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
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Complaint c : resolved) {
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
