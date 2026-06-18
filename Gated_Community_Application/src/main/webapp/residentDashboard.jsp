<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard &mdash; Greenway Residents Portal</title>
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

<%
    Object u = session.getAttribute("userName");
    if (u == null) { response.sendRedirect("index.jsp?error=session"); return; }
    String name = u.toString();
%>

<%@ include file="header.jspf" %>

<main class="page">
    <div class="page-header">
        <h1>Welcome back, <%= name %></h1>
        <p>What would you like to do today?</p>
    </div>

    <div class="tile-grid">
        <a href="raiseComplaint.jsp" class="tile">
            <span class="tile-icon">&#128221;</span>
            <div class="tile-title">Raise a Complaint</div>
            <div class="tile-desc">Report a maintenance issue or community concern.</div>
        </a>
        <a href="residentViewComplaintsServlet" class="tile">
            <span class="tile-icon">&#128203;</span>
            <div class="tile-title">My Complaints</div>
            <div class="tile-desc">View, edit or cancel your open complaints.</div>
        </a>
        <a href="complaintsHistory" class="tile">
            <span class="tile-icon">&#9989;</span>
            <div class="tile-title">History</div>
            <div class="tile-desc">Complaints that have been resolved.</div>
        </a>
    </div>
</main>

</body>
</html>
