<%@ page import="javax.servlet.http.*, javax.servlet.*, java.sql.*, java.util.*" %>
<%@ page session="true" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
 <%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("UserRole");

    List<Map<String, String>> mentorList = new ArrayList<>();

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String selectedMentor = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");

        if ("Mentee".equalsIgnoreCase(userRole)) {
            ps = con.prepareStatement("SELECT mentor_name FROM mentors WHERE mentee_name = ?");
            ps.setString(1, userName);
            rs = ps.executeQuery();

            if (rs.next()) {
                selectedMentor = rs.getString("mentor_name");
            }

            rs.close();
            ps.close();
        }

        if (selectedMentor != null ) {
            // Fetch full details of the selected mentor
            ps = con.prepareStatement("SELECT * FROM mentor WHERE username = ?");
            ps.setString(1, selectedMentor);
        } else {
            // Show all mentors
            ps = con.prepareStatement("SELECT * FROM mentor");
        }


        rs = ps.executeQuery();
        while (rs.next()) {
            Map<String, String> mentor = new HashMap<>();
            mentor.put("name", rs.getString("username"));
            mentor.put("email", rs.getString("email"));
            mentor.put("image", rs.getString("image")); // Adjust to actual column name
            mentorList.add(mentor);
        }

    } catch (Exception e) {
        out.println("Database error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mentor Cards</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

        body {
            font-family: 'Poppins', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff7e6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .header {
            background-color: #ffcc66;
            height: 300px;
            width: 100%;
            border-bottom-left-radius: 100px;
            border-bottom-right-radius: 100px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            position: relative;
        }

        .home-container {
            position: absolute;
            left: 400px;
            top: 30px;
            text-align: right;
        }

        .home-container1 {
            position: absolute;
            left: 400px;
            top: 80px;
            text-align: right;
        }

        .home-container2 {
            position: absolute;
            left: 400px;
            top: 45px;
            text-align: right;
        }

        .home-link {
            font-size: 20px;
            font-weight: bold;
            text-decoration: none;
            color: black;
            display: block;
        }

        .status-message {
            font-size: 18px;
            margin-top: 10px;
        }

        .profile-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            text-align: left;
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
            margin-bottom: 2px;
        }

        .user-role {
            font-size: 16px;
            color: gray;
            margin-top: 0;
        }

        .main-section {
            display: flex;
            align-items: flex-start;
            padding: 40px;
            gap: 40px;
        }

        .button-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            width: 200px;
            padding-left: 40px;
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
            text-align: center;
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
.mentors-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 40px;
    justify-content: center; /* center the cards */
}


.mentor-card {
    width: 300px; /* or use a percentage like 40% if you want responsive */
    height: auto;
    padding: 20px;
    background-color: #fffde6;
    text-align: center;
    border-radius: 15px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    cursor: pointer;
    box-shadow: 0 6px 12px rgba(0,0,0,0.1);
}
        .mentor-card:hover {
            transform: scale(1.1);
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }

        .mentor-pic {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #ffcc66;
        }

        .mentor-name {
            margin-top: 10px;
            font-size: 18px;
            font-weight: bold;
            color: #333;
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
            <br>
            <h2>Meet Your Mentors</h2>
        </div>
        <div class="home-container2">
            <p>----------------------------------------------------------------------------------------------------------------------</p>
        </div>
    </div>

    <div class="main-section">
        <div class="button-container">
    <a href="dashboard.jsp" class="btn">
        <img src="home.webp" alt="Home" class="btn-icon"> Home
    </a>
    <a href="http://localhost:8080/MMS/learn.jsp" class="btn">
        <img src="learn.jpg" alt="Progress" class="btn-icon"> Learning
    </a>
    <a href="http://localhost:8080/MMS/Courses.jsp" class="btn">
        <img src="courses.jpg" alt="Course" class="btn-icon"> Course
    </a>
   
    <a href="http://localhost:8080/MMS/mentorprofiles.jsp" class="btn">
        <img src="mentor.webp" alt="Mentees" class="btn-icon"> Mentor
    </a>
     <a href="login2.jsp" class="btn">
        <img src="logout.jpg" alt="My Mentee" class="btn-icon"> log out
    </a>
</div>
<div class="mentors-wrapper">
    <div class="main-content">
       <div class="mentors-grid">
    <%
        if (selectedMentor != null) {
            for (Map<String, String> mentor : mentorList) {
                if (selectedMentor.equals(mentor.get("name"))) {
    %>
        <div class="mentor-card">
            <form action="mentorDetails.jsp" method="get" style="display:inline;">
                <input type="hidden" name="username" value="<%= mentor.get("name") %>">
                <button type="submit" style="border:none; background:none; cursor:pointer;">
                    <img src="logo.jpg" alt="Mentor Image" class="mentor-pic">
                    <div class="mentor-info">
                        <h3><%= mentor.get("name") %></h3>
                        <p>Email: <%= mentor.get("email") %></p>
                    </div>
                </button>
            </form>
        </div>
    <%
                break; // only show the selected mentor
                }
            }
        } else {
            for (Map<String, String> mentor : mentorList) {
    %>
        <div class="mentor-card">
            <form action="mentorDetails.jsp" method="get" style="display:inline;">
                <input type="hidden" name="username" value="<%= mentor.get("name") %>">
                <button type="submit" style="border:none; background:none; cursor:pointer;">
                    <img src="logo.jpg" alt="Mentor Image" class="mentor-pic">
                    <div class="mentor-info">
                        <h3><%= mentor.get("name") %></h3>
                        <p>Email: <%= mentor.get("email") %></p>
                    </div>
                </button>
            </form>
        </div>
    <%
            }
        }
    %>
</div>
</div>
</div>
</div>
</body>
</html>
