<%@ page isErrorPage="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DriveKTM - Server Error</title>
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
            color: #ff9900;
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
            background-color: #ff9900;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }
        a.button:hover {
            background-color: #ff7700;
        }
    </style>
</head>
<body>
    <h1>500</h1>
    <h2>Something Went Wrong!</h2>
    <p>Oops! Our server encountered an issue. Please try again later.</p>
    <a href="home.jsp" class="button">Back to Home</a>
</body>
</html>