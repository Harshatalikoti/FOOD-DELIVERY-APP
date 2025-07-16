<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Signup</title>
   <style>
       * {
           margin: 0;
           padding: 0;
           box-sizing: border-box;
           font-family: Arial, sans-serif;
       }

       body {
           background: url('https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&q=80') center/cover no-repeat fixed;
           display: flex;
           justify-content: center;
           align-items: center;
           height: 100vh;
       }

       .container {
           background: rgba(255, 255, 255, 0.15); /* More transparency */
           backdrop-filter: blur(15px); /* Enhanced glass effect */
           padding: 30px;
           border-radius: 15px;
           box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
           width: 100%;
           max-width: 420px;
           text-align: center;
       }

       h2 {
           color: white;
           margin-bottom: 20px;
           font-size: 1.8rem;
       }

       .form-group {
           display: flex;
           flex-direction: column;
           margin-bottom: 15px;
       }

       label {
           color: white;
           font-weight: bold;
           margin-bottom: 5px;
           text-align: left;
       }

       input, select, textarea {
           width: 100%;
           padding: 10px;
           border: none;
           border-radius: 8px;
           outline: none;
           font-size: 1rem;
           background: rgba(255, 255, 255, 0.8);
       }

       textarea {
           resize: vertical;
           min-height: 70px;
       }

       button {
           background: #ff7b54;
           color: white;
           border: none;
           padding: 12px;
           width: 100%;
           border-radius: 8px;
           margin-top: 15px;
           cursor: pointer;
           font-size: 1rem;
           transition: all 0.3s ease-in-out;
       }

       button:hover {
           background: #e06440;
           transform: scale(1.05);
       }
   </style>
</head>
<body>
   <div class="container">
       <h2>Signup</h2>
       <form action="signup" method="POST">
           <div class="form-group">
               <label for="name">Name:</label>
               <input type="text" id="name" name="name" required />
           </div>
           <div class="form-group">
               <label for="username">Username:</label>
               <input type="text" id="username" name="username" required />
           </div>
           <div class="form-group">
               <label for="password">Password:</label>
               <input type="password" id="password" name="password" required />
           </div>
           <div class="form-group">
               <label for="email">Email:</label>
               <input type="email" id="email" name="email" required />
           </div>
           <div class="form-group">
               <label for="phone">Phone:</label>
               <input type="tel" id="phone" name="phone" required />
           </div>
           <div class="form-group">
               <label for="address">Address:</label>
               <textarea id="address" name="address" required></textarea>
           </div>
           <div class="form-group">
               <label for="role">Role:</label>
               <select id="role" name="role">
                   <option value="customer">Customer</option>
                   <option value="admin">Admin</option>
               </select>
           </div>
           <button type="submit">Create Account</button>
       </form>
   </div>
</body>
</html>
