<%@page import="user.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "user.UserDAO" %>
    <%@ page import = "java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id = "user" class="user.User" scope="page"/>
    <jsp:setProperty name = "user" property="id"/>
    <jsp:setProperty name = "user" property="password"/>
    <jsp:setProperty name = "user" property="name"/>
    <jsp:setProperty name = "user" property="nickname"/>
    <jsp:setProperty name = "user" property="reg_date"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../menu.jsp" %>
<%
	String id = (String)session.getAttribute("id");

	UserDAO userDAO = new UserDAO();
	ArrayList<User> list = userDAO.get_info_list(id);
	
%>
	<form method="post" action="info_change_ok.jsp">
	<% for(int i=0; i<list.size(); i++){ %>
	<input type="hidden" name="pk" id = "pk" value="<%=list.get(i).getPk()%>"></input><br>
	아이디 : <input type="text" name="id" id = "id" value="<%=list.get(i).getId()%>"></input><br>
	비밀번호 : <input type="text" name="password" id = "password" value="<%=list.get(i).getPassword()%>"></input><br>
	이름 : <input type="text" name="name" id = "name" value="<%=list.get(i).getName()%>" disabled></input><br>
	닉네임 : <input type="text" name="nickname" id = "nickname" value="<%=list.get(i).getNickname()%>"></input><br>
	가입일 : <input type="text" value="<%=list.get(i).getReg_date() %>" disabled></input><br>
	<% } %>
	<input type="submit" value="수정하기">
	</form>

</body>
</html>