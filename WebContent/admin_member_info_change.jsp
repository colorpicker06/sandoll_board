<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.ResultSet"%>
	<%@page import="java.sql.DriverManager"%>
	<%@page import="java.sql.Statement"%>
	<%@page import="java.sql.Connection"%>
	<%@ page import = "java.io.PrintWriter" %>
	<%@ page import = "user.UserDAO" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id = "user" class="user.User" scope="page"/>
    <jsp:setProperty name = "user" property="pk"/>
    <jsp:setProperty name = "user" property="id"/>
    <jsp:setProperty name = "user" property="password"/>
    <jsp:setProperty name = "user" property="nickname"/>
    <jsp:setProperty name = "user" property="name"/>
    <jsp:setProperty name = "user" property="reg_date"/>
    <jsp:setProperty name = "user" property="user_state"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	UserDAO userDAO = new UserDAO();
		int result = userDAO.user_state(user);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('실패 ')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 되었습니다.')");
			script.println("location.href='admin_member.jsp'");
			script.println("</script>");
		}
		
		//out.print(request.getParameter("user_state"));
		//out.print(request.getParameter("id"));
		//out.print(request.getParameter("name"));
		//out.print(request.getParameter("pk"));
%>
</head>
<body>

</body>
</html>