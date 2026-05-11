<%@ page isErrorPage="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DriveKTM - Page Not Found</title>
    <link rel="stylesheet" href="css/style.css"> <!-- Your main CSS -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: #0d1117; 
            color: #ffffff;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            text-align: center;
        }
        h1 {
            font-size: 8rem;
            color: #ff4d4d;
            margin: 0;
        }
        h2 {
            font-size: 2rem;
            margin: 20px 0;
        }
        p {
            font-size: 1.2rem;
            color: #ccc;
        }
        a.button {
            margin-top: 20px;
            padding: 12px 25px;
            background-color: #ff4d4d;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }
        a.button:hover {
            background-color: #ff1a1a;
        }
    </style>
</head>
<body>
    <h1>404</h1>
    <h2>Oops! Page Not Found</h2>
    <p>The page you are looking for doesn’t exist or has been moved.</p>
    <a href="${pageContext.request.contextPath}/home" class="button">Back to Home</a>
</body>
</html>