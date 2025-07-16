<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
 <%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    String username = (String) session.getAttribute("userName");
    String userrole = (String) session.getAttribute("UserRole");
    
        boolean isEnrolled = false;



    // If user is not logged in, redirect to login page
   
%>
<%
    // Fetch session values
    String enrolledCourse = (String) session.getAttribute("enrolledCourse");
   // String username = (String) session.getAttribute("userName");
    //tring userrole = (String) session.getAttribute("userRole");
    if (username == null || enrolledCourse == null) {
        out.println("<h2>You haven't enrolled in any course yet.</h2>");
        return;
    }

    // Check if the success parameter is passed
    boolean isSuccess = "true".equals(request.getParameter("success"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Learning Dashboard</title>
   
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff7e6;
            display: flex;
            flex-direction: column;
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
            padding-left :40px;
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
    right : 100px;
    text-align : center;
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
        /* New Course Container */
        .course-container {
            background: linear-gradient(to bottom, #ffcc66 0%, #fff7e6 50%); /* Gradient background */
            border-radius: 10px;
            position: relative; /* Allows precise positioning */
            top: -400px; /* Adjust this value to move the container upward */
            margin-left: 350px; /* Moves the container to the right */
            padding: 30px;
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* Ensures 2 courses per row */
            gap: 20px;
            max-width: 1000px; /* Limits width for better alignment */
        }
        .course-card {
            background: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .course-card:hover {
            transform: scale(1.05);
        }
        .course-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #ff6600;
        }
        .course-image {
    width: 100%;
    height: 150px;
    object-fit: cover;
    border-radius: 8px;
    margin-bottom: 10px;
}
        
        .enroll-btn {
            display: inline-block;
            padding: 8px 12px;
            background: #ffcc66;
            color: black;
            text-decoration: none;
            border-radius: 10px;
            font-size: 14px;
        }
        .enroll-btn:hover {
            background: #ff9900;
            color: white;
        }
    </style>
</head>
<body>
<%
    if (isSuccess) {
%>
    <script>alert("🎉 You have successfully enrolled in <%= enrolledCourse %>!");</script>
<%
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");

        String sql = "SELECT * FROM enrolls WHERE username = ? AND courseName = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, enrolledCourse);

        rs = ps.executeQuery();

        if (rs.next()) {
            String imagePath = "";
            String courseLink = "";

            switch (enrolledCourse) {
                case "Full Stack Development":
                    imagePath = "fullstack.jpg";
                    courseLink = "courses1.jsp";
                    break;
                case "Machine Learning":
                    imagePath = "AIML.jpg";
                    courseLink = "courses2.jsp";
                    break;
                case "Cybersecurity":
                    imagePath = "cybersecurity.jpg";
                    courseLink = "courses3.jsp";
                    break;
                case "Data Science and Analytics":
                    imagePath = "datascience.jpg";
                    courseLink = "courses4.jsp";
                    break;
               case "IOT":
                    imagePath = "iot.jpg";
                    courseLink = "courses5.jsp";
                    break;
                case "AWS Cloud Computing":
                    imagePath = "cloud.jpg";
                    courseLink = "courses6.jsp";
                    break;
                case "Blockchain and Cryptocurrency":
                    imagePath = "blockchain.jpg";
                    courseLink = "courses7.jsp";
                    break;
                case "Mobile App Development":
                    imagePath = "mad.jpg";
                    courseLink = "courses8.jsp";
                    break;
                default:
                    imagePath = "default.jpg";
                    courseLink = "#";
            }
%>
<div class="header">
        <div class="profile-container">
            <img src="logo.jpg" alt="Profile" class="profile-pic">
            <p class="user-name"><%= username %></p>
            <p class="user-role"><%= userrole %></p>
        </div>
        <div class="home-container">
            <a href="#" class="home-link">Courses</a>
        </div>
        <div class="home-container1">
            <p class="status-message">"Click, Learn, Succeed...!"</p>
        </div>
        <div class="home-container2">
            <p>--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------</p>
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
    </div>
    <!-- New Course Container -->
    <!-- New Course Container -->

    <div class="course-container">
        <div class="course-card">
            <img src="<%= imagePath %>" alt="<%= enrolledCourse %>" class="course-image">
            <p class="course-title"><%= enrolledCourse %></p>
            <a href="<%= courseLink %>" class="enroll-btn">Start Learning</a>
        </div>
    </div>
<%
        } else {
            out.println("<h2>You are not enrolled in any course.</h2>");
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
</body>
</html>
