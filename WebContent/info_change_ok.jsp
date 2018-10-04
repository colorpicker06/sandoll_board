<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id = "user" class="user.User" scope="page"/>
    <jsp:setProperty name = "user" property="pk"/>
    <jsp:setProperty name = "user" property="id"/>
    <jsp:setProperty name = "user" property="password"/>
    <jsp:setProperty name = "user" property="nickname"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String pk = request.getParameter("pk");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String nickname = request.getParameter("nickname");
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.info_change(user);
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
		script.println("history.back()");
		script.println("</script>");
	}
%>
</body>
</html>