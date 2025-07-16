<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
 <%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("UserRole");

    int menteeCount = 0;
    int courseCount = 0;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");

        // Replace these table/column names according to your DB schema
        PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(mentee_name) FROM mentors WHERE mentor_name = ?");
        ps1.setString(1, userName);
        ResultSet rs1 = ps1.executeQuery();
        if (rs1.next()) {
            menteeCount = rs1.getInt(1);
        }

        PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(courseName) FROM enrollMentor WHERE username = ?");
        ps2.setString(1, userName);
        ResultSet rs2 = ps2.executeQuery();
        if (rs2.next()) {
            courseCount = rs2.getInt(1);
        }

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Mentor-Mentee Dashboard</title>
    <link rel="stylesheet" href="styles.css" />
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
.btn1 {
    text-align: center;
    justify-content: center; /* Center horizontally */
    padding: 12px 15px;
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

        .dashboard-card {
            background: #ffffffcc;
            backdrop-filter: saturate(180%) blur(20px);
            border-radius: 20px;
            box-shadow: 0 12px 28px rgba(0,0,0,0.15);
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            padding: 36px 48px;
            max-width: 520px;
            width: 100%;
            gap: 20px;
            user-select: none;
            margin-left: 80px;
        }

        .dashboard-card .button-container {
            width: 100%;
        }

        /* New styles for the overview divs */
        .overview-container {
            /*display: none; */
            width: 100%;
            gap: 30px;
            justify-content: flex-start;
        }

        .overview-card {
            background-color: #fff3d6;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            flex: 1;
            text-align: center;
        }

        .overview-card h3 {
            margin: 0 0 10px 0;
            font-size: 24px;
            font-weight: 700;
            color: #333;
        }

        .overview-card p {
            font-size: 40px;
            font-weight: bold;
            color: #fca311;
            margin: 0;
        }
    </style>

    <script>
    
    function toggleExperienceForm() {
        var form = document.getElementById('experience-form');
        form.style.display = form.style.display === 'none' ? 'block' : 'none';
    }
</script>

    
</head>
<body>
    <div class="header">
        <div class="profile-container">
            <img src="logo.jpg" alt="Profile" class="profile-pic" />
            <p class="user-name"><%= userName %></p>
            <p class="user-role"><%= userRole %></p>
        </div>
        <div class="home-container">
            <h3>Home</h3>
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
            <a href="http://localhost:8080/MMS/mentordashboard.jsp#" class="btn">
                <img src="home.webp" alt="Home" class="btn-icon" /> Home
            </a>
            <a href="http://localhost:8080/MMS/coursesMentor.jsp" class="btn">
                <img src="courses.jpg" alt="Course" class="btn-icon" /> Course
            </a>
            <a href="#" class="btn">
                <img src="mentor.webp" alt="Mentees" class="btn-icon" /> Mentees
            </a>
            <a href="http://localhost:8080/MMS/Mprofile.jsp" class="btn">
                <img src="logo.jpg" alt="Profile" class="btn-icon" /> Profile
            </a>
            <a href="login2.jsp" class="btn">
                <img src="logout.jpg" alt="Logout" class="btn-icon" /> Log Out
            </a>
        </div>

          

            <!-- Add Experience Section -->
<div class="dashboard-card">
    <button class="btn1" onclick="toggleExperienceForm()">Add Experience</button>

    <!-- Form to add new experience -->
    <div id="experience-form" style="display:none; margin-top: 20px;">
        <form method="post" action="addExperience.jsp">
            <input type="hidden" name="mentor_username" value="<%= userName %>">
            <input type="text" name="course_name" placeholder="Course Name" required style="margin-bottom: 10px; width: 100%; padding: 8px;"><br>
            <input type="text" name="organization" placeholder="Organization Name" required style="margin-bottom: 10px; width: 100%; padding: 8px;"><br>
            <input type="text" name="duration" placeholder="Duration (e.g. 6 months or 2 years)" required style="margin-bottom: 10px; width: 100%; padding: 8px;"><br>
            <input type="submit" value="Save Experience" class="btn1">
        </form>
    </div>

    <!-- Display added experiences -->
    <div style="margin-top: 30px;">
        <h3>My Experiences</h3>
        <%
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");

                PreparedStatement ps = con.prepareStatement("SELECT course_name, organization, duration FROM experience WHERE mentor_username = ?");
                ps.setString(1, userName);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    String course = rs.getString("course_name");
                    String org = rs.getString("organization");
                    String duration = rs.getString("duration");
        %>
                    <div class="overview-card" style="margin-bottom: 15px;">
                        <p><strong>Course:</strong> <%= course %></p>
                        <p><strong>Organization:</strong> <%= org %></p>
                        <p><strong>Duration:</strong> <%= duration %></p>
                    </div>
        <%
                }

                con.close();
            } catch (Exception e) {
                out.println();
            }
        %>
    </div>
</div>

       
    
</body>
</html>
