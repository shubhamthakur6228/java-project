<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
<%
String user = request.getParameter("t1");
String pass = request.getParameter("t2");

if ((user != null && pass != null) && 
    ((user.equals("shubham") && pass.equals("shubham")) || 
     (user.equals("admin") && pass.equals("admin")))) {
    
    pageContext.setAttribute("a", user, PageContext.SESSION_SCOPE);
    response.sendRedirect("add_food.jsp");
} else {
    out.println("<script>alert('Invalid User Name or Password..');");
    out.println("window.location.assign('adminlogin.html');</script>");
}
%>
</body>
</html>
