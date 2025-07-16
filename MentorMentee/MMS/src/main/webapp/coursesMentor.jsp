<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
 <%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("UserRole");
    // If user is not logged in, redirect to login page
   
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mentor-Mentee Dashboard</title>
    <link rel="stylesheet" href="styles.css">
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
        .button-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin-top: 20px;
            width: 200px;
            margin-left: 20px;
        }
        .btn {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: #ffcc66;
            text-decoration: none;
            color: black;
            font-size: 18px;
            border-radius: 30px;
            text-align: center;
            margin-bottom: 10px;
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

.button-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin-top: 20px;
            width: 200px;
            margin-left: 20px;
        }
        .btn {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: #ffcc66;
            text-decoration: none;
            color: black;
            font-size: 18px;
            border-radius: 30px;
            text-align: center;
            margin-bottom: 10px;
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
    <a href="http://localhost:8080/MMS/mentordashboard.jsp#" class="btn">
        <img src="home.webp" alt="Home" class="btn-icon"> Home
    </a>
    
    <a href="http://localhost:8080/MMS/coursesMentor.jsp" class="btn">
        <img src="courses.jpg" alt="Course" class="btn-icon"> Course
    </a>
   
    <a href="" class="btn">
        <img src="mentor.webp" alt="Mentees" class="btn-icon"> Mentees
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
        <img src="fullstack.jpg" alt="Full Stack" class="course-image">
        <p class="course-title">Full Stack Web Development</p>
        <a href="http://localhost:8080/MMS/courseMentor1.jsp" class="enroll-btn">Slect</a>
    </div>
    <div class="course-card">
        <img src="AIML.jpg" alt="Machine Learning" class="course-image">
        <p class="course-title">Machine Learning & AI</p>
        <a href="http://localhost:8080/MMS/courseMentor2.jsp" class="enroll-btn">select</a>
    </div>
    <div class="course-card">
        <img src="cybersecurity.jpg" alt="Cybersecurity" class="course-image">
        <p class="course-title">Cybersecurity Fundamentals</p>
        <a href="http://localhost:8080/MMS/course3.jsp" class="enroll-btn">Select</a>
    </div>
    <div class="course-card">
        <img src="datascience.jpg" alt="Data Science" class="course-image">
        <p class="course-title">Data Science & Analytics</p>
        <a href="http://localhost:8080/MMS/course4.jsp" class="enroll-btn">Select</a>
    </div>
    <div class="course-card">
        <img src="iot.jpg" alt="IoT" class="course-image">
        <p class="course-title">Internet of Things (IoT)</p>
        <a href="http://localhost:8080/MMS/course5.jsp" class="enroll-btn">Select</a>
    </div>
    <div class="course-card">
        <img src="cloud.jpg" alt="Cloud Computing" class="course-image">
        <p class="course-title">Cloud Computing (AWS & Azure)</p>
        <a href="http://localhost:8080/MMS/course6.jsp" class="enroll-btn">Select</a>
    </div>
    <div class="course-card">
        <img src="blockchain.jpg" alt="Blockchain" class="course-image">
        <p class="course-title">Blockchain & Cryptocurrency</p>
        <a href="http://localhost:8080/MMS/course7.jsp" class="enroll-btn">Select</a>
    </div>
    <div class="course-card">
        <img src="mad.jpg" alt="Mobile App" class="course-image">
        <p class="course-title">Mobile App Development</p>
        <a href="http://localhost:8080/MMS/course8.jsp" class="enroll-btn">Select</a>
    </div>
    
</div>

</body>
</html>