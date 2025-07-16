<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("UserRole");
    String mentorUsername = request.getParameter("username");
    String mentorName = "";
    String mentorEmail = "";
    String mentorImage = "logo.jpg"; // static image
    List<String> courseList = new ArrayList<>();
    String statusMessage = "";
    boolean alreadySelected = false;

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");

        // Fetch mentor email
        ps = con.prepareStatement("SELECT email FROM mentor WHERE username = ?");
        ps.setString(1, mentorUsername);
        rs = ps.executeQuery();
        if (rs.next()) {
            mentorEmail = rs.getString("email");
        }
        rs.close();
        ps.close();

        // Fetch enrolled courses
        ps = con.prepareStatement("SELECT courseName FROM enrollMentor WHERE username = ?");
        ps.setString(1, mentorUsername);
        rs = ps.executeQuery();
        while (rs.next()) {
            courseList.add(rs.getString("courseName"));
        }
        rs.close();
        ps.close();

        // Check if mentee has already selected this mentor
        ps = con.prepareStatement("SELECT * FROM mentors WHERE mentor_name = ? AND mentee_name = ?");
        ps.setString(1, mentorUsername);
        ps.setString(2, userName);
        rs = ps.executeQuery();
        if (rs.next()) {
            alreadySelected = true;
        }
        rs.close();
        ps.close();

        // Insert if form is submitted and mentor not already selected
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("submitMentor") != null && !alreadySelected) {
            ps = con.prepareStatement("INSERT INTO mentors (mentor_name, mentee_name) VALUES (?, ?)");
            ps.setString(1, mentorUsername);
            ps.setString(2, userName);
            int rows = ps.executeUpdate();
            if (rows > 0) {
                statusMessage = "Mentor successfully selected!";
                alreadySelected = true; // Update status after insertion
            } else {
                statusMessage = "Failed to select mentor.";
            }
            ps.close();
        }

    } catch (Exception e) {
        statusMessage = "Error: " + e.getMessage();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Mentor Details</title>
    <style>
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: #fffaf0;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #ffcc66;
            height: 300px;
            border-bottom-left-radius: 100px;
            border-bottom-right-radius: 100px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            position: relative;
        }
        .profile-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin-left: 20px;
        }
        .profile-pic {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            border: 3px solid #fff;
        }
        .user-name {
            font-size: 22px;
            font-weight: bold;
        }
        .user-role {
            font-size: 16px;
            color: gray;
        }
        .home-container {
            position: absolute;
            left: 400px;
            top: 30px;
        }
        .home-container1 {
            position: absolute;
            left: 400px;
            top: 80px;
        }
        .home-container2 {
            position: absolute;
            left: 400px;
            top: 45px;
        }
        .home-link {
            font-size: 20px;
            font-weight: bold;
            text-decoration: none;
            color: black;
        }
        .main-section {
            display: flex;
            padding: 40px;
            gap: 40px;
        }
        .button-container {
            flex: 0 0 200px;
            padding-left: 40px;
        }
        .card {
            background: #fff3cd;
            border-radius: 12px;
            padding: 25px;
            max-width: 1000px;
            width: 100%;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            flex: 1;
        }
        .btn {
            display: flex;
            align-items: center;
            gap: 15px;
            width: 100%;
            padding: 12px 15px;
            background-color: #ffcc66;
            text-decoration: none;
            color: black;
            font-size: 18px;
            border-radius: 35px;
            margin-bottom: 14px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #ffd98a;
        }
        .btn-icon {
            width: 50px;
            height: 30px;
            border-radius: 50%;
            object-fit: cover;
        }
        h2 {
            color: #d17b00;
        }
        ul {
            padding-left: 20px;
        }
        .mentor-img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
            border: 2px solid #d17b00;
            margin-bottom: 20px;
        }
        .select-btn {
            background-color: #fca311;
            color: white;
            font-size: 18px;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px;
        }
        .select-btn:hover {
            background-color: #ffb43a;
        }
        .disabled-btn {
            background-color: grey;
            color: white;
            font-size: 18px;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            margin-top: 20px;
            cursor: not-allowed;
        }
        .status {
            margin-top: 15px;
            font-weight: bold;
            color: green;
        }
    </style>
</head>
<body>

<div class="header">
    <div class="profile-container">
        <img src="logo.jpg" alt="Profile" class="profile-pic">
        <p class="user-name"><%= userName %></p>
        <p class="user-role"><%= userRole %></p>
    </div>
    <div class="home-container">
        <a href="#" class="home-link">Home</a>
    </div>
    <div class="home-container1">
        <p class="status-message">How are you doing today?</p>
    </div>
    <div class="home-container2">
        <p>----------------------------------------------------------------------------------------------------------------------</p>
    </div>
</div>

<div class="main-section">
    <div class="button-container">
        <a href="dashboard.jsp" class="btn"><img src="home.webp" class="btn-icon"> Home</a>
        <a href="learn.jsp" class="btn"><img src="learn.jpg" class="btn-icon"> Learning</a>
        <a href="Courses.jsp" class="btn"><img src="courses.jpg" class="btn-icon"> Course</a>
        <a href="#" class="btn"><img src="mentor.webp" class="btn-icon">Mentor</a>
        <a href="#" class="btn"><img src="logout.jpg" class="btn-icon"> Log out</a>
    </div>

    <div class="card">
        <h2>Mentor Details</h2>
        <img src="<%= mentorImage %>" alt="Mentor Image" class="mentor-img">
        <p><strong>Name:</strong> <%= mentorUsername %></p>
        <p><strong>Email:</strong> <%= mentorEmail %></p>

        <h3>Courses:</h3>
        <ul>
            <% for (String course : courseList) { %>
                <li><%= course %></li>
            <% } %>
        </ul>

        <% if (!alreadySelected) { %>
            <form method="post">
                <input type="hidden" name="submitMentor" value="true">
                <button type="submit" class="select-btn">Select as Mentor</button>
            </form>
        <% } else { %>
            <button class="disabled-btn" disabled>Selected as Mentor</button>
        <% } %>

        <% if (!statusMessage.isEmpty()) { %>
            <p class="status"><%= statusMessage %></p>
        <% } %>
    </div>
</div>

</body>
</html>
