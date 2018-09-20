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
	Connection conn = null;
	Statement stmt = null;
	String id = (String)session.getAttribute("id");


	try{
	    Class.forName("com.mysql.jdbc.Driver");
	    String dbURL = "jdbc:mysql://localhost:3306/sandoll_board?useSSL=false";
		String dbID = "root";
		String dbPassword = "1234";
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
	    stmt = conn.createStatement();
	    
	    String sql = "select * from user where id ="+"'"+id+"'";
        ResultSet rs = stmt.executeQuery(sql);
	
%>
<form method="post" action="info_change_ok.jsp">
<% while(rs.next()){ %>
<input type="hidden" name="pk" id = "pk" value="<%=rs.getString("pk")%>"></input><br>
아이디 : <input type="text" name="id" id = "id" value="<%=rs.getString("id")%>"></input><br>
비밀번호 : <input type="text" name="password" id = "password" value="<%=rs.getString("password")%>"></input><br>
이름 : <input type="text" name="name" id = "name" value="<%=rs.getString("name")%>" disabled></input><br>
닉네임 : <input type="text" name="nickname" id = "nickname" value="<%=rs.getString("nickname")%>"></input><br>
가입일 : <input type="text" value="<%=rs.getString("reg_date")%>" disabled></input><br>
<% } %>
<input type="submit" value="수정하기">
</form>
<%
      conn.close();
    }catch(Exception e){
        out.println("데이터베이스에 문제가 있습니다.");
        out.println(e.getMessage());
        e.getStackTrace();
    }
%> 
</body>
</html>