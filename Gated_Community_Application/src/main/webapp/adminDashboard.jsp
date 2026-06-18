<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard &mdash; Greenway Residents Portal</title>
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

<%
    Object u = session.getAttribute("userName");
    Object r = session.getAttribute("role");
    if (u == null || r == null || !"admin".equalsIgnoreCase(r.toString())) {
        response.sendRedirect("index.jsp?error=access"); return;
    }
%>

<%@ include file="header.jspf" %>

<main class="page">
    <div class="page-header">
        <h1>Admin Dashboard</h1>
        <p>Review and manage community complaints.</p>
    </div>

    <div class="tile-grid">
        <a href="adminServlet" class="tile">
            <span class="tile-icon">&#128203;</span>
            <div class="tile-title">All Complaints</div>
            <div class="tile-desc">View every complaint raised by residents and update statuses.</div>
        </a>
    </div>
</main>

</body>
</html>
