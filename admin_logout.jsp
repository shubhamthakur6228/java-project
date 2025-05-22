<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<html> 
 <body> 
 <%  
 session.invalidate(); 
 response.sendRedirect("adminlogin.html"); 
 %> 
 </body> 
</html> 
