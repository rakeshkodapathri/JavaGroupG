<!-- sessionAttributes.jsp -->
<html>
<head>
    <title>Session Attributes</title>
</head>
<body>
<h2>Session Attributes</h2>
<ul>
    <%
        if (session != null) {
            java.util.Enumeration<String> attributeNames = session.getAttributeNames();
            while (attributeNames.hasMoreElements()) {
                String attributeName = attributeNames.nextElement();
                Object attributeValue = session.getAttribute(attributeName);
    %>
    <li><%= attributeName %>: <%= attributeValue %></li>
    <%
        }
    } else {
    %>
    <li>No session found.</li>
    <%
        }
    %>
</ul>
</body>
</html>
