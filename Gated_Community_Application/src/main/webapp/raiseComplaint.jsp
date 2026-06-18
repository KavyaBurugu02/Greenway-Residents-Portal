<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Raise a Complaint &mdash; Greenway Residents Portal</title>
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

<%
    if (session.getAttribute("userName") == null) { response.sendRedirect("index.jsp?error=session"); return; }
    String errMsg = (String) request.getAttribute("errorMessage");
%>

<%@ include file="header.jspf" %>

<main class="page" style="max-width: 680px;">
    <div class="page-header">
        <h1>Raise a Complaint</h1>
        <p>Describe the issue and we'll get it to the right team.</p>
    </div>

    <div class="card">
        <% if (errMsg != null && !errMsg.isEmpty()) { %>
            <div class="alert alert-error">&#9888; <%= errMsg %></div>
        <% } %>

        <form action="complaintsServlet" method="post">
            <div class="form-group">
                <label for="category">Category</label>
                <select id="category" name="category" required>
                    <option value="" disabled selected>Select a category</option>
                    <option>Electricity</option>
                    <option>Water</option>
                    <option>Kitchen</option>
                    <option>Restrooms</option>
                    <option>Security</option>
                    <option>Parking</option>
                    <option>Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="subject">Subject</label>
                <input type="text" id="subject" name="subject" placeholder="Brief summary of the issue" required maxlength="120">
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" placeholder="Describe what's wrong and where" required maxlength="1000"></textarea>
            </div>
            <div class="form-group">
                <label for="flatNo">Flat number</label>
                <input type="number" id="flatNo" name="flatNo" placeholder="e.g. 304" required min="1">
            </div>
            <div style="display:flex;gap:10px;flex-wrap:wrap;">
                <button type="submit" class="btn btn-primary">Submit Complaint</button>
                <a href="residentDashboard.jsp" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</main>

</body>
</html>
