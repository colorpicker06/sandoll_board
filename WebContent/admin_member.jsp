<%@page import="user.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="user.UserDAO"%>
<%@page import="java.net.*"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
<style>
  table {
    width: 80%;
    margin-left:auto;
    margin-right:auto;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
  
  body{
font-family: 'Nanum Gothic', sans-serif;
}

h1{
	margin-left:10%;
}
</style>
<body>
<%@ include file="../menu.jsp" %>
<div id = "main">
<%

	if(!InetAddress.getLocalHost().getHostAddress().equals("192.168.1.79")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자페이지에 접속 할 수 있는 ip가 아닙니다.')");
		script.println("location.href=('index.jsp')");
		script.println("</script>");
	}

		int pageNumber = 1;
		if(request.getParameter("pageNumber")!= null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}

		UserDAO userDAO = new UserDAO();
		ArrayList<User> list = userDAO.getList(pageNumber);

%>
<h1>회원 관리</h1> <br>
<table>
<tr>
<td> 번호 </td>
<td> 아이디 </td>
<td> 비밀번호 </td>
<td> 이름 </td>
<td> 닉네임 </td>
<td> 가입일 </td>
<td> 현재상태 </td>
</tr>

<%
for(int i=0; i<list.size(); i++){ %>
	<tr>
	<form action='admin_member_info_change.jsp' method='post'>
	<td><%=list.get(i).getPk() %></td>
	<td><input type="text" name="id" id = "id" value="<%=list.get(i).getId() %>"></input></td>
	<td><input type="text" name="password" id = "password" value="<%=list.get(i).getPassword() %>"></input></td>
	<td><input type="text" name="name" id = "name" value="<%=list.get(i).getName() %>"></input></td>
	<td><input type="text" name="nickname" id = "nickname" value="<%=list.get(i).getNickname() %>"></input></td>
	<td><input type="text" name="reg_date" id = "reg_date" value="<%=list.get(i).getReg_date() %>"></input></td>
	<td>
	<input type="hidden" name="pk" id="pk" value="<%=list.get(i).getPk() %>">	
	<select name="user_state" id="user_state">
		<option value=0 <% if( list.get(i).getUser_state() ==0){%>selected<% } %>>일반계정 </option>
		<option value=1 <% if( list.get(i).getUser_state()==1){%>selected<% } %>>탈퇴계정</option>
		<option value=2 <% if( list.get(i).getUser_state()==2){%>selected<% } %>>휴면계정</option>
	</select>
	<input type="submit" value="수정">	
	</td>
	</form>	
	</tr>
<%
}
%>
</table>
</div>
</body>
</html>