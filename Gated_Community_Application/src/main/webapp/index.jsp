<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign In &mdash; Greenway Residents Portal</title>
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

<%
    String err = request.getParameter("error");
    String signup = request.getParameter("signup");
    String logout = request.getParameter("logout");
    String msg = (String) request.getAttribute("errorMessage");
%>

<div class="auth-layout">
    <div class="auth-panel">
        <div class="auth-panel-content">
            <div class="auth-label">Greenway Residents Portal</div>
            <h1>Manage your community, one request at a time.</h1>
            <p>Log maintenance issues, track them in real time, and communicate with the community office — all from one place.</p>
            <div class="auth-divider">
                <div class="auth-divider-post"></div>
                <div class="auth-divider-bars"></div>
                <div class="auth-divider-post"></div>
            </div>
        </div>
    </div>

    <div class="auth-form-panel">
        <div class="auth-form-box">
            <h2>Sign in</h2>
            <p class="sub">Enter your resident or admin credentials below.</p>

            <% if (msg != null && !msg.isEmpty()) { %>
                <div class="alert alert-error">&#9888; <%= msg %></div>
            <% } else if ("invalid".equals(err)) { %>
                <div class="alert alert-error">&#9888; Incorrect username or password.</div>
            <% } else if ("session".equals(err)) { %>
                <div class="alert alert-error">&#9888; Your session has expired. Please sign in again.</div>
            <% } else if ("role".equals(err)) { %>
                <div class="alert alert-error">&#9888; Account type unknown. Contact the community office.</div>
            <% } else if ("access".equals(err)) { %>
                <div class="alert alert-error">&#9888; You don't have permission to view that page.</div>
            <% } %>

            <% if ("success".equals(signup)) { %>
                <div class="alert alert-success">&#10003; Account created. You can sign in now.</div>
            <% } %>

            <% if ("success".equals(logout)) { %>
                <div class="alert alert-info">&#8505; You've been signed out.</div>
            <% } %>

            <form action="login" method="post">
                <div class="form-group">
                    <label for="userName">Username</label>
                    <input type="text" id="userName" name="userName" placeholder="Your username" required autofocus>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Your password" required>
                </div>
                <button type="submit" class="btn btn-primary btn-full">Sign In</button>
            </form>

            <div class="auth-footer">
                New resident? <a href="signup.jsp">Create an account</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
