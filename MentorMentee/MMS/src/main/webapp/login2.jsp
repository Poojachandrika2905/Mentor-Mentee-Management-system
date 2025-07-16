<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
 <%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>



<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mentor Mentee Management</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { display: flex; height: 100vh; font-family: Arial, sans-serif; }
        .split { width: 50%; height: 100vh; display: flex; align-items: center; justify-content: center; position: relative; }
        .image-side { background-image: url("./image.png"); background-size: cover; background-position: center; background-repeat: no-repeat; height: 100%; }
        .content-side { background-color: #fef6e4; display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%; }
        .content { text-align: center; padding: 20px; }
        .btn, .login-btn { display: inline-block; padding: 10px 20px; font-size: 16px; color: #ffffff; background-color: #ff6f61; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; }
        .btn:hover, .login-btn:hover { background-color: #d95d50; }
        .login-form { display: flex; flex-direction: column; width: 100%; max-width: 300px; text-align: left; margin-top: 20px; }
        .login-form input { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 5px; }
        .login-form input:focus { outline: none; border-color: #ff6f61; box-shadow: 0 0 5px rgba(255, 111, 97, 0.5); }
        .login-form .signup-link { text-align: center; margin-top: 10px; }
        .login-form .signup-link a { color: #ff6f61; text-decoration: none; }
        .login-form .signup-link a:hover { text-decoration: underline; }
        .heading { font-size: 24px; font-weight: bold; margin-bottom: 20px; color: #333; }
    </style>
</head>

<body>
    <div class="split image-side"></div>

    <div class="split content-side">
        <div class="content">
            <div class="heading">Mentor Mentee Management System</div><br>

            <!-- Login Form -->
          <!-- login.jsp -->
<form class="login-form" >
    <label for="name"></label>
                <input type="text" id="name" name="name" placeholder="user name" required>

              <input type="password" name="password" placeholder="Password" required>
    <input type="submit" value="Log in"
        style="color: #ffffff; background-color: #ff6f61; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">
    <div class="signup-link">
        Don't have an account? <a href="http://localhost:8080/MMS/signup.jsp">Sign Up</a>
    </div>
</form>
<%
    
    // If user is not logged in, redirect to login page
 

    String username = request.getParameter("name");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");

        String sql = "SELECT role FROM signin WHERE name = ? AND password = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);
        rs = ps.executeQuery();

        if (rs.next()) {
            String role = rs.getString("role");

            // ✅ Set session attributes
            session.setAttribute("userName", username);
            session.setAttribute("UserRole", role);

            // ✅ Redirect based on role
            if ("mentee".equalsIgnoreCase(role)) {
                response.sendRedirect("dashboard.jsp");
            } else if ("mentor".equalsIgnoreCase(role)) {
                response.sendRedirect("mentordashboard.jsp");
            } else {
                out.println("Unknown role. Please contact admin.");
            }
        }


    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>


</body>

</html>
