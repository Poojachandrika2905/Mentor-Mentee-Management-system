<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - Mentor Mentee Management</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            height: 100vh;
        }

        .image-side {
            flex: 1;
            background-image: url('image.png');
            background-size: cover;
            background-position: center;
        }

        .form-side {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 20px;
            background-color: #fef6e4;
        }

        .form-container {
            width: 100%;
            max-width: 400px;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .form-container h1 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
            text-align: center;
        }

        .form-container label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            color: #555;
        }

        .form-container input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-container input[type="submit"] {
            background-color: #ff6f61;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .form-container input[type="submit"]:hover {
            background-color: #ff4c3b;
        }

        .form-container p {
            text-align: center;
            font-size: 14px;
            color: #777;
            margin-top: 15px;
        }

        .form-container p a {
            color: #4CAF50;
            text-decoration: none;
        }

        .form-container p a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="image-side"></div>
    <div class="form-side">
        <div class="form-container">
            <h1>Create Account</h1>
            <form action="sign2.jsp" method="post">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" placeholder="Enter your name" required>

                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>

                <label for="role">Role</label>
                <input type="text" id="role" name="role" placeholder="Enter Mentor or Mentee" required>

                <input type="submit" value="Sign Up">
            </form>
            <p>Already have an account? <a href="login2.jsp">Log in</a></p>
        </div>
    </div>
</body>
</html>
