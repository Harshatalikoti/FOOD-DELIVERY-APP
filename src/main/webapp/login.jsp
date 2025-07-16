<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Login</title>
   <link rel="stylesheet" href="./styles.css">
   <style>
       body {
           font-family: Arial, sans-serif;
           background-color: #f4f4f9; /* Light background color */
           display: flex;
           justify-content: center;
           align-items: center;
           height: 100vh;
           margin: 0;
       }
       .login-container {
           background-color: #ffffff;
           padding: 20px 30px;
           border-radius: 10px;
           box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
           width: 100%;
           max-width: 400px;
       }
       h2 {
           text-align: center;
           color: #333;
       }
       form {
           display: flex;
           flex-direction: column;
           gap: 15px;
       }
       label {
           font-weight: bold;
           color: #555;
       }
       input[type="text"],
       input[type="password"] {
           padding: 10px;
           border: 1px solid #ccc;
           border-radius: 5px;
           font-size: 16px;
       }
       button {
           background-color: #4CAF50; /* Green color for the button */
           color: white;
           padding: 10px;
           border: none;
           border-radius: 5px;
           font-size: 16px;
           cursor: pointer;
       }
       button:hover {
           background-color: #45a049;
       }
       p {
           text-align: center;
           font-size: 14px;
           color: #666;
       }
       a {
           color: #007BFF;
           text-decoration: none;
       }
       a:hover {
           text-decoration: underline;
       }
       .message {
           text-align: center;
           margin-bottom: 15px;
           font-size: 14px;
       }
       .message.success {
           color: green;
       }
       .message.error {
           color: red;
       }
   </style>
</head>
<body>
   <div class="login-container">
       <h2>Login</h2>
       <!-- Display signup success or error message -->
       <% String signupMessage = request.getParameter("signup");
          if ("success".equals(signupMessage)) { %>
          <p class="message success">Signup successful! Please login with your credentials.</p>
       <% } %>
       <% String error = request.getParameter("error");
          if (error != null) { %>
          <p class="message error">Error: <%= error %></p>
       <% } %>
       <!-- Login form -->
       <form action="login" method="post">
           <label for="username">Username:</label>
           <input type="text" id="username" name="username" required />
           <label for="password">Password:</label>
           <input type="password" id="password" name="password" required />
           <button type="submit">Login</button>
       </form>
       <p>Don't have an account? <a href="signup.jsp">Sign up here</a></p>
   </div>
</body>
</html>
