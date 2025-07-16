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
        .progress-bar-container {
            width: 80%;
            margin: 20px auto;
            background-color: #eee;
            border-radius: 20px;
            overflow: hidden;
            height: 25px;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.2);
        }
        .progress-bar-fill {
            height: 100%;
            width: 0%;
            background-color: #4caf50;
            text-align: center;
            line-height: 25px;
            color: white;
            font-weight: bold;
            transition: width 0.4s ease;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 0; padding: 0;
            background-color: #fff7e6;
            display: flex;
            height: 100vh;
            flex-direction: column;
            overflow-x: hidden;
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
            font-size: 22px; font-weight: bold; margin: 5px 0 0;
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
            top: 50px; left: 50%;
            transform: translateX(-50%);
        }
        .course-container {
            background-color: #fff1d6;
            border-radius: 20px; padding: 30px;
            margin-bottom: 40px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .course-title {
            font-size: 28px; color: #cc6600; margin-bottom: 10px;
        }
        .course-tagline {
            font-size: 20px; font-weight: bold;
            color: #333; margin-bottom: 15px;
        }
        .course-description {
            font-size: 16px; line-height: 1.6;
            color: #444; margin-bottom: 15px;
        }
        .module {
            margin-bottom: 1em;
            background-color: #ffcc66;
            color: white; padding: 1em;
            border-radius: 8px; font-weight: bold;
            cursor: pointer; display: flex;
            justify-content: space-between;
            align-items: center;
            transition: background-color 0.3s;
        }
        .module:hover {
            background-color: #ff9900;
        }
        .arrow {
            font-size: 20px; color: black;
            transition: transform 0.3s;
        }
        .module-details {
            display: none;
            background-color: #f0f4f8;
            padding: 1em; border-radius: 8px;
            margin-top: 0.5em;
        }
        .task-box {
            background-color: #fff; border: 1px solid #ddd;
            padding: 10px; margin: 5px 0;
            border-radius: 5px; cursor: pointer;
        }
        .video-container {
            width: 60%; position: absolute;
            top: 0; left: 50%;
            transform: translateX(-50%);
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
</head>
<body>
    <script>
        let completedTasks = new Set();
        function toggleModule(id, arrowId) {
            const details = document.getElementById(id);
            const arrow = document.getElementById(arrowId);
            if (details.style.display === "block") {
                details.style.display = "none";
                arrow.style.transform = "rotate(0deg)";
            } else {
                details.style.display = "block";
                arrow.style.transform = "rotate(180deg)";
            }
        }
        function playVideo(taskName) {
            const vc = document.getElementById("video-container");
            const vs = document.getElementById("video-source");
            const vp = document.getElementById("task-video");
            vs.src = "videos/" + taskName.replace(/ /g,"_").toLowerCase() + ".mp4";
            vp.load();
            vc.style.display = "block";
            completedTasks.add(taskName);
            updateProgress();
        }
        function closeVideo() {
            document.getElementById("video-container").style.display = "none";
        }
        function updateProgress() {
            const total = document.querySelectorAll(".task-box").length;
            const done = completedTasks.size;
            const pct = Math.round(done/total * 100) + "%";
            const bar = document.getElementById("progress-fill");
            bar.style.width = pct; bar.innerText = pct;
        }
    </script>

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
            <h2 class="course-title">Machine Learning Course</h2>
            <p class="course-tagline">Become a skilled Machine Learning practitioner and kickstart your AI career!</p>
            <p class="course-description">
                Master the fundamentals and advanced concepts of Machine Learning to build intelligent systems that learn from data and make accurate predictions.
            </p>
            <p class="course-description">
                This course takes you through key topics like <strong>supervised and unsupervised learning, deep learning,</strong> and model evaluation using tools such as <strong>Python, Scikit-learn, TensorFlow, and Keras</strong>.
            </p>
            <p class="course-description">
                You'll work on real-world projects involving <strong>data preprocessing, training models, and deploying machine learning solutions</strong>. By the end, you'll be equipped to design, implement, and deploy ML models for roles in data science and AI development.
            </p>
        </div>

        <div class="progress-bar-container">
            <div class="progress-bar-fill" id="progress-fill">0%</div>
        </div>

        <h2>Modules in the Course</h2>

        <!-- Module 1 -->
        <div class="module" onclick="toggleModule('ml1','arr1')">
            Module 1: Introduction to Machine Learning
            <span class="arrow" id="arr1">></span>
        </div>
        <div class="module-details" id="ml1">
            <div class="task-box" onclick="playVideo('What is Machine Learning?')">Task 1: What is Machine Learning?</div>
            <div class="task-box" onclick="playVideo('Types of ML')">Task 2: Types of ML</div>
            <div class="task-box" onclick="playVideo('ML Pipeline')">Task 3: ML Pipeline</div>
            <div class="task-box" onclick="playVideo('Applications of ML')">Task 4: Applications of ML</div>
            <div class="task-box" onclick="playVideo('Tools and Libraries Overview')">Task 5: Tools and Libraries Overview</div>
        </div>

        <!-- Module 2 -->
        <div class="module" onclick="toggleModule('ml2','arr2')">
            Module 2: Data Preprocessing & EDA
            <span class="arrow" id="arr2">></span>
        </div>
        <div class="module-details" id="ml2">
            <div class="task-box" onclick="playVideo('Data Cleaning')">Task 1: Data Cleaning</div>
            <div class="task-box" onclick="playVideo('Feature Engineering')">Task 2: Feature Engineering</div>
            <div class="task-box" onclick="playVideo('Encoding Techniques')">Task 3: Encoding Techniques</div>
            <div class="task-box" onclick="playVideo('Scaling and Normalization')">Task 4: Scaling and Normalization</div>
            <div class="task-box" onclick="playVideo('Exploratory Data Analysis')">Task 5: Exploratory Data Analysis (EDA)</div>
        </div>

        <!-- Module 3 -->
        <div class="module" onclick="toggleModule('ml3','arr3')">
            Module 3: Supervised Learning Algorithms
            <span class="arrow" id="arr3">></span>
        </div>
        <div class="module-details" id="ml3">
            <div class="task-box" onclick="playVideo('Linear & Logistic Regression')">Task 1: Linear & Logistic Regression</div>
            <div class="task-box" onclick="playVideo('Decision Trees')">Task 2: Decision Trees</div>
            <div class="task-box" onclick="playVideo('Ensemble Methods')">Task 3: Random Forest & Ensemble Methods</div>
            <div class="task-box" onclick="playVideo('Support Vector Machines')">Task 4: Support Vector Machines</div>
            <div class="task-box" onclick="playVideo('K-Nearest Neighbors')">Task 5: K-Nearest Neighbors</div>
        </div>

        <!-- Module 4 -->
        <div class="module" onclick="toggleModule('ml4','arr4')">
            Module 4: Unsupervised Learning Algorithms
            <span class="arrow" id="arr4">></span>
        </div>
        <div class="module-details" id="ml4">
            <div class="task-box" onclick="playVideo('Clustering Algorithms')">Task 1: Clustering Algorithms (KMeans, DBSCAN)</div>
            <div class="task-box" onclick="playVideo('Dimensionality Reduction')">Task 2: Dimensionality Reduction (PCA)</div>
            <div class="task-box" onclick="playVideo('Anomaly Detection')">Task 3: Anomaly Detection</div>
            <div class="task-box" onclick="playVideo('Association Rule Learning')">Task 4: Association Rule Learning</div>
            <div class="task-box" onclick="playVideo('Unsupervised Use Cases')">Task 5: Use Cases in Unsupervised Learning</div>
        </div>

        <!-- Module 5 -->
        <div class="module" onclick="toggleModule('ml5','arr5')">
            Module 5: Model Evaluation and Tuning
            <span class="arrow" id="arr5">></span>
        </div>
        <div class="module-details" id="ml5">
            <div class="task-box" onclick="playVideo('Train/Test Split and Cross-Validation')">Task 1: Train/Test Split and Cross-Validation</div>
            <div class="task-box" onclick="playVideo('Evaluation Metrics')">Task 2: Evaluation Metrics</div>
            <div class="task-box" onclick="playVideo('Confusion Matrix')">Task 3: Confusion Matrix</div>
            <div class="task-box" onclick="playVideo('Bias-Variance Tradeoff')">Task 4: Bias-Variance Tradeoff</div>
            <div class="task-box" onclick="playVideo('Hyperparameter Tuning')">Task 5: Hyperparameter Tuning</div>
        </div>

        <!-- Module 6 -->
        <div class="module" onclick="toggleModule('ml6','arr6')">
            Module 6: Deep Learning and Deployment
            <span class="arrow" id="arr6">></span>
        </div>
        <div class="module-details" id="ml6">
            <div class="task-box" onclick="playVideo('Neural Network Basics')">Task 1: Neural Network Basics</div>
            <div class="task-box" onclick="playVideo('Building Deep Learning Models')">Task 2: Building Deep Learning Models</div>
            <div class="task-box" onclick="playVideo('Deep Learning Evaluation')">Task 3: Model Evaluation in Deep Learning</div>
            <div class="task-box" onclick="playVideo('Model Saving and Exporting')">Task 4: Model Saving and Exporting</div>
            <div class="task-box" onclick="playVideo('Deployment Techniques')">Task 5: Deployment Techniques</div>
        </div>

        
    </div>
</body>
</html>