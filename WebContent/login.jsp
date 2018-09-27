<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>

</style>
<body>
<%@ include file="../menu.jsp" %>
<% 

	if(session.getAttribute("id")!=null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 되어있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}

	else{
		String userid = (String)session.getAttribute("id");
		%>
			로그인
			<form method="post" action="login_ok.jsp">
			<input type="text" name="id" id = "id" placeholder="아이디 입력"><br>
			<input type="password" name="password" id = "password" placeholder="비밀번호 입력"><br>
			<input type="submit" value="로그인"><br>
			</form>
			<a href="signin.jsp">회원가입</a>
			<%	}
%>

</body>
</html>