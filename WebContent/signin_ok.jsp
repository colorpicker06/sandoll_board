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
<%
	UserDAO userDAO = new UserDAO();
	boolean idchk = userDAO.chk_id(request.getParameter("id"));
	//아이디가 이미 있을 
	if(idchk){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 사용중인 아이디 입니다.')");
		script.println("location.href='invalid_id.jsp'");
		script.println("</script>");
	}
	
	//아이디가 없을 때
	else{
		
		String pass1 = request.getParameter("password");
		String pass2 = request.getParameter("password2");
		//패스워드가 서로 다를
		if(!pass1.equals(pass2)){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 다릅니다.')");
			script.println("location.href='invalid_pass.jsp'");
			script.println("</script>");
		}
		
		
		int result = userDAO.signin(user);
		
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('실패')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
	}
%>
</body>
</html>