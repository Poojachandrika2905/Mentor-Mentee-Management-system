<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
 <%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("UserRole");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mentor-Mentee Dashboard</title>
    <link rel="stylesheet" href="styles.css">
    <style>
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
        body {
            font-family: Arial, sans-serif;
            margin: 0; padding: 0;
            background-color: #fff7e6;
            display: flex; height: 100vh;
            flex-direction: column; overflow-x: hidden;
        }
        .header {
            background-color: #ffcc66;
            height: 300px; width: 100%;
            border-bottom-left-radius: 100px;
            border-bottom-right-radius: 100px;
            display: flex; align-items: center;
            padding: 20px; position: relative;
        }
        .profile-container {
            display: flex; flex-direction: column;
            margin-left: 20px;
        }
        .profile-pic {
            width: 70px; height: 70px;
            border-radius: 50%; border: 3px solid #fff;
        }
        .user-name {
            font-size: 22px; font-weight: bold;
            margin-bottom: 2px;
        }
        .user-role {
            font-size: 16px; color: gray;
        }
        .button-container {
            display: flex; flex-direction: column;
            margin: 20px 0 0 20px; width: 200px;
        }
        .btn {
            display: block; width: 100%;
            padding: 15px; margin-bottom: 10px;
            background-color: #ffcc66; color: black;
            text-decoration: none; font-size: 18px;
            border-radius: 30px; text-align: center;
        }
        .content {
            flex-grow: 1; background: #fff;
            padding: 20px; border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            width: 60%; position: absolute;
            top: 50px; left: 50%; transform: translateX(-50%);
        }
        .course-container {
            background-color: #fff1d6;
            border-radius: 20px; padding: 30px;
            margin-bottom: 40px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .course-title {
            font-size: 28px; color: #cc6600;
            margin-bottom: 10px;
        }
        .course-tagline {
            font-size: 20px; font-weight: bold;
            color: #333; margin-bottom: 15px;
        }
        .course-description {
            font-size: 16px; line-height: 1.6;
            color: #444; margin-bottom: 15px;
        }
        .progress-bar-container {
            width: 80%; margin: 20px auto;
            background-color: #eee; border-radius: 20px;
            overflow: hidden; height: 25px;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.2);
        }
        .progress-bar-fill {
            height: 100%; width: 0%;
            background-color: #4caf50;
            text-align: center; line-height: 25px;
            color: white; font-weight: bold;
            transition: width 0.4s ease;
        }
        .module {
            margin-bottom: 1em;
            background-color: #ffcc66; color: white;
            padding: 1em; border-radius: 8px;
            font-weight: bold; cursor: pointer;
            display: flex; justify-content: space-between;
            align-items: center;
            transition: background-color 0.3s;
        }
        .module:hover { background-color: #ff9900; }
        .arrow {
            font-size: 20px; color: black;
            transition: transform 0.3s;
        }
        .module-details {
            display: none; margin-top: 0.5em;
            background-color: #f0f4f8; color: black;
            padding: 1em; border-radius: 8px;
        }
        .task-box {
            background-color: #fff; border: 1px solid #ddd;
            padding: 10px; margin: 5px 0;
            border-radius: 5px; cursor: pointer;
        }
        .video-container {
            width: 60%; position: absolute;
            top: 0; left: 50%; transform: translateX(-50%);
            display: none; background: rgba(0,0,0,0.8);
            padding: 10px; border-radius: 10px;
            z-index: 10;
        }
        .video-container video {
            width: 100%; border-radius: 10px;
        }
        .close-video {
            position: absolute; top: 5px; right: 10px;
            background: red; color: white;
            border-radius: 50%; padding: 5px;
            cursor: pointer; font-size: 20px;
        }
    </style>
    <script>
        let completedTasks = new Set();
        function toggleModule(id, arr) {
            const det = document.getElementById(id);
            const a = document.getElementById(arr);
            if (det.style.display==='block') {
                det.style.display='none'; a.style.transform='rotate(0deg)';
            } else {
                det.style.display='block'; a.style.transform='rotate(180deg)';
            }
        }
        function playVideo(task) {
            const vc = document.getElementById('video-container');
            const vs = document.getElementById('video-source');
            const vp = document.getElementById('task-video');
            vs.src = 'videos/'+task.replace(/ /g,'_').toLowerCase()+'.mp4';
            vp.load(); vc.style.display='block';
            completedTasks.add(task); updateProgress();
        }
        function closeVideo() {
            document.getElementById('video-container').style.display='none';
        }
        function updateProgress() {
            const total = document.querySelectorAll('.task-box').length;
            const done = completedTasks.size;
            const pct = Math.round(done/total*100)+'%';
            const bar = document.getElementById('progress-fill');
            bar.style.width = pct; bar.innerText = pct;
        }
    </script>
</head>
<body>
    <div class="header">
        <div class="profile-container">
            <img src="logo.jpg" class="profile-pic" alt="Profile">
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
        <video controls id="task-video">
            <source id="video-source" src="" type="video/mp4">
            Your browser does not support the video tag.
        </video>
    </div>

    <div class="content">
        <div class="course-container">
            <h2 class="course-title">Data Science and Analytics Course</h2>
            <p class="course-tagline">Become a skilled Data Science and Analytics professional and kickstart your career in data-driven decision-making!</p>
            <p class="course-description">
                Master the power of data and unlock insights that drive decision-making across industries.
            </p>
            <p class="course-description">
                This course covers the full data science pipeline—from data collection, cleaning, and analysis to building predictive models and visualizing insights.
            </p>
            <p class="course-description">
                You'll gain hands-on experience with <strong>Python, Pandas, SQL, and machine learning libraries</strong>, along with data visualization tools like <strong>Matplotlib, Seaborn, and Tableau</strong>. By the end, you'll be equipped to extract actionable insights, build data-driven solutions, and pursue roles in data science, business analytics, and beyond.
            </p>
        </div>

        <div class="progress-bar-container">
            <div class="progress-bar-fill" id="progress-fill">0%</div>
        </div>

        <h2>Modules in the Course</h2>

        <!-- Module 1 -->
        <div class="module" onclick="toggleModule('mod1','arr1')">
            Module 1: Introduction to Data Science
            <span class="arrow" id="arr1">></span>
        </div>
        <div class="module-details" id="mod1">
            <div class="task-box" onclick="playVideo('What is Data Science?')">Task 1: What is Data Science?</div>
            <div class="task-box" onclick="playVideo('Roles in Data Science')">Task 2: Roles in Data Science</div>
            <div class="task-box" onclick="playVideo('Tools of the Trade')">Task 3: Tools of the Trade</div>
            <div class="task-box" onclick="playVideo('Types of Data')">Task 4: Types of Data</div>
            <div class="task-box" onclick="playVideo('DS Workflow Overview')">Task 5: Overview of Data Science Workflow</div>
        </div>

        <!-- Module 2 -->
        <div class="module" onclick="toggleModule('mod2','arr2')">
            Module 2: Data Collection and Preprocessing
            <span class="arrow" id="arr2">></span>
        </div>
        <div class="module-details" id="mod2">
            <div class="task-box" onclick="playVideo('Data Collection Methods')">Task 1: Data Collection Methods</div>
            <div class="task-box" onclick="playVideo('Data Cleaning')">Task 2: Data Cleaning</div>
            <div class="task-box" onclick="playVideo('Data Transformation')">Task 3: Data Transformation</div>
            <div class="task-box" onclick="playVideo('Exploratory Data Analysis')">Task 4: Exploratory Data Analysis (EDA)</div>
            <div class="task-box" onclick="playVideo('Pandas Wrangling')">Task 5: Data Wrangling with Pandas</div>
        </div>

        <!-- Module 3 -->
        <div class="module" onclick="toggleModule('mod3','arr3')">
            Module 3: Statistical Analysis and Data Visualization
            <span class="arrow" id="arr3">></span>
        </div>
        <div class="module-details" id="mod3">
            <div class="task-box" onclick="playVideo('Descriptive Statistics')">Task 1: Descriptive Statistics</div>
            <div class="task-box" onclick="playVideo('Hypothesis Testing')">Task 2: Hypothesis Testing</div>
            <div class="task-box" onclick="playVideo('Matplotlib & Seaborn')">Task 3: Data Visualization with Matplotlib and Seaborn</div>
            <div class="task-box" onclick="playVideo('Tableau Basics')">Task 4: Tableau Basics</div>
            <div class="task-box" onclick="playVideo('Storytelling with Data')">Task 5: Storytelling with Data</div>
        </div>

        <!-- Module 4 -->
        <div class="module" onclick="toggleModule('mod4','arr4')">
            Module 4: Predictive Modeling and Machine Learning
            <span class="arrow" id="arr4">></span>
        </div>
        <div class="module-details" id="mod4">
            <div class="task-box" onclick="playVideo('Regression & Classification')">Task 1: Regression and Classification</div>
            <div class="task-box" onclick="playVideo('Clustering Basics')">Task 2: Clustering Basics</div>
            <div class="task-box" onclick="playVideo('Model Evaluation')">Task 3: Model Evaluation Metrics</div>
            <div class="task-box" onclick="playVideo('Time Series Forecasting')">Task 4: Time Series and Forecasting</div>
            <div class="task-box" onclick="playVideo('Model Tuning')">Task 5: Model Tuning and Validation</div>
        </div>

        <!-- Module 5 -->
        <div class="module" onclick="toggleModule('mod5','arr5')">
            Module 5: Data-Driven Decision Making and Deployment
            <span class="arrow" id="arr5">></span>
        </div>
        <div class="module-details" id="mod5">
            <div class="task-box" onclick="playVideo('Business Use Cases')">Task 1: Business Use Cases</div>
            <div class="task-box" onclick="playVideo('Data Ethics & Privacy')">Task 2: Data Ethics and Privacy</div>
            <div class="task-box" onclick="playVideo('Deployment Basics')">Task 3: Deployment Basics</div>
            <div class="task-box" onclick="playVideo('Dashboard Automation')">Task 4: Reporting and Dashboard Automation</div>
            <div class="task-box" onclick="playVideo('Career Path Guidance')">Task 5: Career Path Guidance</div>
        </div>

       
    </div>
</body>
</html>