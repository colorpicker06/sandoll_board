<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<title>Insert title here</title>
</head>
<style>
body{
font-family: 'Nanum Gothic', sans-serif;
}

div.login{
	width:30%;
	margin-left:auto;
	margin-right:auto;
}

a.login {
	display: block;
	clear: both;
}

input{
margin-left:auto;
margin-right:auto;
}

h3{
margin-left:auto;
margin-right:auto;
}

div.form-group{
		margin-left:auto;
		margin-right:auto;
		}

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
		<center>
		<br><br><br>
			<i class="far fa-user-circle fa-5x" style="margin-left:0;"></i>
			<h3>로그인</h3>
			<form method="post" class="form-inline" action="login_ok.jsp">
			<div class="form-group">
				<div class="col-xs-10">
				<input type="text" size="30" name="id" class="form-control"  id = "id" placeholder="아이디 입력"><br><br>
				<input type="password" size="30" class="form-control"  name="password" id = "password" placeholder="비밀번호 입력"><br><br>
				<input type="submit" style="margin-left:20%;" class="form-control" value="로그인"><br>
				</div>
			</form><br><br>
			</div>
			<br><br><a class="login" href="signin.jsp">회원이 아니신가요?</a>
			<%	}  %>
</center>
</body>
</html>