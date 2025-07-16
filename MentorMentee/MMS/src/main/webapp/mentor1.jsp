<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page session="true" %>
<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");

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
        }
        .professor-container{
        background: linear-gradient(to bottom, #ffcc66 0%, #fff7e6 20%);
            border-radius: 10px;
            height:800px;
            position:relative;
            margin: 40px auto;
            padding: 30px;
            max-width: 1000px;
            top:-200px;
            display: flex;
            flex-direction: row;
            align-items: flex-start;
            gap: 30px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
.sidebar {
    width: 280px;
    height: 800px;
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
    overflow: hidden;
    border-radius: 20px;
}

.sidebar-top {
    background-color: #FFF3E0; /* blue */
    width: 100%;
    height: 30%;
}

.sidebar-bottom {
    background-color: #ffcc66; /* black */
    width: 100%;
    height: 50%;
    padding-top: 70px;
    text-align: center;
    color: white;
}

.profile-img {
    position: absolute;
    top: 30%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 120px;
    height: 120px;
    border-radius: 50%;
    border: 4px solid white;
    background-color: white;
    object-fit: cover;       /* ensures image fits nicely inside the circle */
    object-position: center; /* centers the image within the circle */
}


.sidebar h2 {
    margin: 10px 0 5px;
    color: white;
}

.sidebar p,
.sidebar a {
    color: #000000;
    font-size: 14px;
    text-decoration: none;
}

.contact-info {
    margin-top: 10px;
    color: #000000;
    font-size: 13px;
}


    .main-content {
      flex: 1;
      padding: 40px;
    }

    .card {
      background-color: #FFF3E0;
      padding: 20px;
      border-radius: 10px;
      margin-bottom: 20px;
      display:felx;
    }

    .card h3 {
      margin-top: 0;
      border-bottom: 1px solid #444;
      padding-bottom: 10px;
    }

    .subjects {
      display: flex;
      gap: 20px;
      flex-wrap: wrap;
    }

    .subject {
      background-color: #FFF3E0;
      padding: 15px;
      border-radius: 8px;
      flex: 1 1 200px;
    }
    .subject:hover {
            transform: scale(1.05);
        }
    .subject-title {
      font-weight: bold;
    }

    .upload-box {
      text-align: center;
      padding: 40px;
      border: 2px dashed #444;
      border-radius: 10px;
      color: #888;
    }
    .select-mentor-btn {
    padding: 10px 20px;
    background-color: #ffcc66;
    border: none;
    border-radius: 20px;
    font-size: 16px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.select-mentor-btn:hover {
    background-color: #ffb84d;
    transform: scale(1.05);
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
    </div>

    <div style="display: flex; flex: 1;">
        <!-- Sidebar Navigation Buttons -->
        <div class="button-container">
            <a href="http://localhost:8080/MMS/dashboard1.html#" class="btn">Home</a>
            <a href="#" class="btn">Learning</a>
            <a href="#" class="btn">Course</a>
            <a href="#" class="btn">My Mentor</a>
            <a href="#" class="btn">Mentors</a>
        </div>

        <!-- Professor Dashboard -->
        <!-- Sidebar with split color and profile -->
<div class="professor-container">
    <div class="sidebar">
        <div class="sidebar-top"></div>
        <img src="SaiJyothimam.jpg" alt="Mentor Photo" class="profile-img">
        <div class="sidebar-bottom">
            <h2>Dr. B. Sai Jyothi</h2>
            <p>Professor, Information Technology</p>
            <a href="#">Ph.D. in Computer Science</a>
            <div class="contact-info">
                <p>saijyothi@vvit.net</p>
                <p>+91 9989221750</p>
                <p>Staff Room, New Block</p>
            </div>
        </div>
    </div>

    <!-- Main content area -->
    <div class="main-content">
        <div class="card">
            <h3>About</h3>
            <p>
                Dr.B.Saijyothi is a distinguished professor with over 15 years of experience in Computer Science education and research. 
                Her expertise includes Full Stack Development, UI/UX, and Front-End development. She has published numerous papers 
                in leading international journals and conferences.
            </p>
        </div>

        <div class="card">
            <h3>Current Subjects</h3>
            <div class="subjects">
                <div class="subject">
                    <div class="subject-title">Full Stack Development</div>
              
                </div>
                <div class="subject">
                    <div class="subject-title">UI/UX Design</div>
                    
                </div>
                <div class="subject">
                    <div class="subject-title">Front-End Development</div>
                    
                </div>
            </div>
        </div>

        <div class="card">
            <h3>Leave Application</h3>
            <div class="upload-box">
                Upload your leave letter
            </div>
        </div>
        <div style="text-align: center; margin-top: 20px;">
    <form action="SelectMentorServlet" method="post">
        <input type="hidden" name="mentorName" value="Dr. B. Sai Jyothi">
        <button type="submit" class="select-mentor-btn">
            Select as Mentor
        </button>
    </form>
</div>

    </div>
</div>

    </div>
</body>
</html>