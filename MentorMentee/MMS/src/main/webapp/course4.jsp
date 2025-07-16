<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
 <%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("UserRole");

        boolean isEnrolled = false;



    // If user is not logged in, redirect to login page
   
%><!DOCTYPE html>
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
            height: 100vh;
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
        }.main-section {
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
        .content {
            flex-grow: 1;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 60%;
            position: absolute;
            top: 50px;
            left: 50%;
            transform: translateX(-50%);
        }
        .module {
    margin-bottom: 1em;
    background-color: #ffcc66;
    color: white;
    padding: 1em;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    display: flex;
    justify-content: space-between;
    align-items: center;
    transition: background-color 0.3s;
    position: relative;
}

.arrow {
    transition: transform 0.3s;
    font-weight: bold;
    font-size: 20px;
    color: black;
    margin-left: auto;
}

        .module:hover {
            background-color: #ff9900;
        }
        
        .module-details {
            display: none;
            margin-top: 0.5em;
            background-color: #f0f4f8;
            color: black;
            padding: 1em;
            border-radius: 8px;
        }
        .task-box {
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 10px;
            margin: 5px 0;
            border-radius: 5px;
        }
        .video-container {
            width: 60%;
            position: absolute;
            top: 0;
            left: 50%;
            transform: translateX(-50%);
            display: none;
            background: rgba(0, 0, 0, 0.8);
            padding: 10px;
            border-radius: 10px;
            z-index: 10;
        }
        .video-container video {
            width: 100%;
            border-radius: 10px;
        }
        .close-video {
            position: absolute;
            top: 5px;
            right: 10px;
            font-size: 20px;
            color: white;
            cursor: pointer;
            background: red;
            border-radius: 50%;
            padding: 5px;
        }
        .course-container {
    background-color: #fff1d6;
    border-radius: 20px;
    padding: 30px;
    margin: 40px 20px;
    max-width: 900px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.course-title {
    font-size: 28px;
    color: #cc6600;
    margin-bottom: 10px;
}

.course-tagline {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    margin-bottom: 15px;
}

.course-description {
    font-size: 16px;
    line-height: 1.6;
    color: #444;
    margin-bottom: 15px;
}
        
    </style>
</head>
<body>
<% 
 
try {
    if (userName != null && userRole != null && userRole.equalsIgnoreCase("mentee")) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");
            String sql = "SELECT * FROM enrolls WHERE username = ? AND courseName = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, userName);
            ps.setString(2, "Data Science and Analytics");
            rs = ps.executeQuery();
            if (rs.next()) {
                isEnrolled = true;
            }
        } catch (Exception e) {
            out.println("Database Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
} catch (Exception e) {
    out.println("General Error: " + e.getMessage());
}
%>
    <script>
    function toggleModule(moduleId, arrowId) {
        var module = document.getElementById(moduleId);
        var arrow = document.getElementById(arrowId);

        if (module.style.display === "none" || module.style.display === "") {
            module.style.display = "block";
            arrow.style.transform = "rotate(180deg)";
        } else {
            module.style.display = "none";
            arrow.style.transform = "rotate(0deg)";
        }
    }

        
        function playVideo() {
            var videoContainer = document.getElementById("video-container");
            videoContainer.style.display = "block";
        }
        
        function closeVideo() {
            var videoContainer = document.getElementById("video-container");
            videoContainer.style.display = "none";
        }
    </script>
    <div class="header">
        <div class="profile-container">
            <img src="logo.jpg" alt="Profile" class="profile-pic">
            <p class="user-name"><%= userName %></p>
            <p class="user-role"><%= userRole %></p>
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
    <div class="video-container" id="video-container">
        <span class="close-video" onclick="closeVideo()">&times;</span>
        <video controls>
            <source src="video.mp4" type="video/mp4">Your browser does not support the video tag.
        </video>
    </div>
    <div class="content">
        <div class="course-container">
    <h2 class="course-title">Data Science and Analytics Course</h2>
    <p class="course-tagline">Turn raw data into actionable insights and shape smarter business decisions.</p>
    <p class="course-description">
        This course offers a comprehensive journey through the data science lifecycle—from data acquisition and preprocessing to advanced analytics and predictive modeling. You'll learn to work with real-world datasets and draw meaningful conclusions that inform strategic decisions.
    </p>
    <p class="course-description">
        Through hands-on projects, you'll master essential tools including <strong>Python</strong>, <strong>Pandas</strong>, <strong>SQL</strong>, and key machine learning libraries. You'll also explore data visualization using <strong>Matplotlib</strong>, <strong>Seaborn</strong>, and <strong>Tableau</strong>, gaining the ability to communicate findings effectively.
    </p>
    <p class="course-description">
        By the end of this course, you'll be equipped to build predictive models, perform statistical analysis, and drive impact across domains such as <strong>business analytics</strong>, <strong>data science</strong>, and <strong>decision intelligence</strong>.
    </p>
</div>

        <h2>Modules in the Course</h2>
        <div class="module" onclick="toggleModule('module1', 'arrow1')">
    Module 1: Introduction to Data Science
    <span class="arrow" id="arrow1"> > </span>
</div>

        <div class="module-details" id="module1">
            <div class="task-box">Task 1: What is Data Science?</div>
            <div class="task-box">Task 2: Roles in Data Science </div>
            <div class="task-box">Task 3: Tools of the Trade </div>
            <div class="task-box">Task 4: Types of Data </div>
            <div class="task-box">Task 5: Overview of Data Science Workflow</div>
        </div>
        <div class="module" onclick="toggleModule('module2', 'arrow2')">
            Module 2:  Data Collection and Preprocessing
            <span class="arrow" id="arrow2">></span>
        </div>
        <div class="module-details" id="module2">
            <div class="task-box">Task 1: Data Collection Methods</div>
            <div class="task-box">Task 2: Data Cleaning </div>
            <div class="task-box">Task 3: Data Transformation</div>
            <div class="task-box">Task 4: Exploratory Data Analysis (EDA)</div>
            <div class="task-box">Task 5: Data Wrangling with Pandas</div>
        </div>
        <div class="module" onclick="toggleModule('module3', 'arrow3')">
            Module 3: Data Analysis and Visualization
            <span class="arrow" id="arrow3">></span>
        </div>
        <div class="module-details" id="module3">
            <div class="task-box">Task 1: Statistical Analysis</div>
            <div class="task-box">Task 2: Hypothesis Testing</div>
            <div class="task-box">Task 3: Data Visualization with Python  </div>
            <div class="task-box">Task 4: Dashboards and BI Tools</div>
            <div class="task-box">Task 5: Storytelling with Data </div>
        </div>
        <div class="module" onclick="toggleModule('module4', 'arrow4')">
            Module 4: Predictive Modeling and Machine Learning
            <span class="arrow" id="arrow4">></span>
        </div>
        <div class="module-details" id="module4">
            <div class="task-box">Task 1: Introduction to ML in Data Science </div>
            <div class="task-box">Task 2: Regression and Classification </div>
            <div class="task-box">Task 3: Model Evaluation </div>
            <div class="task-box">Task 4: Time Series and Forecasting</div>
            <div class="task-box">Task 5: Model Tuning and Validation</div>
        </div>
        <div class="module" onclick="toggleModule('module5', 'arrow5')">
            Module 5: Data-Driven Decision Making and Deployment
            <span class="arrow" id="arrow5">></span>
        </div>
        <div class="module-details" id="module5">
            <div class="task-box">Task 1: Business Use Cases</div>
            <div class="task-box">Task 2: Data Ethics and Privacy </div>
            <div class="task-box">Task 3: Deployment Basics </div>
            <div class="task-box">Task 4: Reporting and Dashboard Automation</div>
            <div class="task-box">Task 5: Career Path Guidance </div>
        </div>
       <div style="display: flex; justify-content: center; margin-top: 20px;">
         <%
        if (isEnrolled) {
    %>
        <button disabled
            style="color: #ffffff; background-color: gray; padding: 12px 30px; font-size: 16px;
                   border: none; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
            ENROLLED
        </button>
    <%
        } else {
    %>
        <form action="enroll.jsp" method="post">
            <input type="hidden" name="courseName" value="Data Science and Analytics" />
            <input type="submit" value="ENROLL "
                style="color: #ffffff; background-color: #ff6f61; padding: 12px 30px; font-size: 16px;
                       border: none; border-radius: 10px; cursor: pointer; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
        </form>
    <%
        }
    %>
    </div>
</body>
</html>