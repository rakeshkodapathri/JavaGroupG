<%@ page import="java.util.Enumeration" %>
<html>
<head>
    <title>User Login</title>
    <link rel="stylesheet" type="text/css" href="css/register.css">
    <script>
        async function handleLogin(event) {
            event.preventDefault();

            const email = document.getElementById("email").value;
            const password = document.getElementById("password").value;

            const response = await fetch('LoginServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({email, password})
            });

            if (response.ok) {
                const data = await response.json();
                localStorage.setItem('token', data.token);
                window.location.href = 'HomePage.jsp'; // Redirect to homepage
            } else {
                const errorText = await response.text();
                alert(errorText);
            }
        }

    </script>
</head>
<body>
<div class="container">

    <%
        // Remove all session attributes
        Enumeration<String> attributeNames = session.getAttributeNames();
        while (attributeNames.hasMoreElements()) {
            String attributeName = attributeNames.nextElement();
            session.removeAttribute(attributeName);
        }
    %>

    <h2>User Login</h2>
    <div style="color: green;">
        <%  String successMessage = (session != null) ? (String) session.getAttribute("successMessage") : null;
            if (successMessage != null) { %>
        <p><%= successMessage %></p>
        <% session.removeAttribute("successMessage"); %>
        <% } %>
    </div>

    <form onsubmit="handleLogin(event)">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>

        <input type="submit" value="Login">
    </form>

</div>
</body>
</html>
