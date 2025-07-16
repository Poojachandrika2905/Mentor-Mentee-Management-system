<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page session="true" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
 <%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    String menteeUsername = (String) session.getAttribute("userName"); // From session
    String mentorUsername = request.getParameter("mentorUsername");   // From request parameter
    String statusMessage = "";

    if (mentorUsername != null && !mentorUsername.trim().isEmpty()) {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");

            ps = con.prepareStatement("INSERT INTO mentors (mentor_name, mentee_name) VALUES (?, ?)");
            ps.setString(1, mentorUsername);
            ps.setString(2, menteeUsername);

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                statusMessage = "Mentor successfully selected!";
            } else {
                statusMessage = "Failed to select mentor.";
            }

        } catch (Exception e) {
            statusMessage = "Error: " + e.getMessage();
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    } else {
        statusMessage = "Invalid mentor selected.";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Select Mentor</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #fffaf0;
            padding: 30px;
        }
        .card {
            background: #fff3cd;
            border-radius: 12px;
            padding: 25px;
            max-width: 600px;
            margin: auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            text-align: center;
        }
        h2 {
            color: #d17b00;
        }
    </style>
</head>
<body>

<div class="card">
    <h2>Select Mentor Result</h2>
    <p><strong>Mentee:</strong> <%= menteeUsername %></p>
    <p><strong>Mentor:</strong> <%= mentorUsername %></p>
    <p style="margin-top: 20px;"><strong>Status:</strong> <%= statusMessage %></p>
    <a href="dashboard.jsp">Back to Dashboard</a>
</div>

</body>
</html>
