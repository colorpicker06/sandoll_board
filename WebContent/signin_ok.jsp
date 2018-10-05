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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<center>
<%
	UserDAO userDAO = new UserDAO();
	boolean idchk = userDAO.chk_id(request.getParameter("id"));
	//사용중인 아이디 이면
	if(idchk){%>
		<img src="image/doll.png" width="10%"><br><br>
		<h1>이미 사용중인 아이디 입니다.</h1><br><br>
		<a href="signin.jsp">회원가입 하러 가기</a>
		
	<%}
	
	else{
		
		//비밀번호 체크
		String pass1 = request.getParameter("password");
		String pass2 = request.getParameter("password2");
		
		//패스워드가 서로 다를
		if(!pass1.equals(pass2)){ %>
			<img src="image/doll.png" width="10%"><br><br>
			<h1>비밀번호가 일치하지 않습니다.</h1><br><br>
			<a href="signin.jsp">회원가입 하러 가기</a>
		<%}
		
		else{
			
			//회원가입 진
			int result = userDAO.signin(user);
			
			if(result == -1){
				out.print("실패");
			}
			
			else{ %>
				<img src="image/doll.png" width="10%"><br><br>
				<h1>회원가입에 성공했습니다.</h1><br><br>
				<a href="ligin.jsp">로그인 하러 가기</a>
			<% }
		}

	}
	
%>
</center>
</body>
</html>