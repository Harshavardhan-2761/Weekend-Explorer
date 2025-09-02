<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f0f0f0;
        }
        #preloader {
            position: fixed;
            width: 100%;
            height: 100%;
            background: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }
        .loader-icon {
            font-size: 50px;
            color: #007bff;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        #main-content {
            display: none;
            text-align: center;
            padding-top: 100px;
        }
        h1 {
            font-size: 2.5em;
            color: #333;
        }
    </style>
</head>
<body>

<div id="preloader">
    <i class="fas fa-spinner loader-icon"></i>
</div>

<div id="main-content">
    <h1><i class="fas fa-smile-beam"></i> Welcome to the JSP page which is for trial!</h1>
</div>

<script>
    // Simple JS preloader timeout
    window.addEventListener("load", function () {
        const preloader = document.getElementById('preloader');
        const content = document.getElementById('main-content');
        setTimeout(() => {
            preloader.style.display = 'none';
            content.style.display = 'block';
        }, 2000); // 2 second delay
    });
</script>

</body>
</html>
