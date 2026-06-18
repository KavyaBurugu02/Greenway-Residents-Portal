<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Create Account &mdash; Greenway Residents Portal</title>
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

<%
    String errorMsg = (String) request.getAttribute("errorMessage");
%>

<div class="auth-layout">
    <div class="auth-panel">
        <div class="auth-panel-content">
            <div class="auth-label">Greenway Residents Portal</div>
            <h1>Join your community.</h1>
            <p>Create a resident account to raise and track maintenance requests without calling the office.</p>
            <div class="auth-divider">
                <div class="auth-divider-post"></div>
                <div class="auth-divider-bars"></div>
                <div class="auth-divider-post"></div>
            </div>
        </div>
    </div>

    <div class="auth-form-panel">
        <div class="auth-form-box">
            <h2>Create your account</h2>
            <p class="sub">All new accounts are registered as residents.</p>

            <% if (errorMsg != null && !errorMsg.isEmpty()) { %>
                <div class="alert alert-error">&#9888; <%= errorMsg %></div>
            <% } %>

            <form action="signup" method="post">
                <div class="form-group">
                    <label for="userName">Username</label>
                    <input type="text" id="userName" name="userName" placeholder="Choose a username" required autofocus>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="At least 6 characters" required minlength="6">
                </div>
                <div class="form-group">
                    <label for="email">Email address</label>
                    <input type="email" id="email" name="email" placeholder="you@example.com" required>
                </div>
                <div class="form-group">
                    <label for="phoneNumber">Phone number</label>
                    <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="10-digit mobile number" pattern="\d{10}" required>
                    <div class="hint">10 digits, no spaces or dashes.</div>
                </div>
                <button type="submit" class="btn btn-primary btn-full">Create Account</button>
            </form>

            <div class="auth-footer">
                Already registered? <a href="index.jsp">Sign in</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
