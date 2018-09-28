<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/signin.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
</head>
<style>
*.{
	margin:10%;
	display: inline-block;
}

body{
font-family: 'Nanum Gothic', sans-serif;
padding-bottom: 40%;
}

</style>

<body>
<%@ include file="../menu.jsp" %>
<script>

function pass_chk(password,password2){
	if(password!=password2){
		alert("비밀번호가 다릅니다.");
		location.href='signin.jsp'
	}
}

</script>

<center>
<form method="post" action="signin_ok.jsp" onsubmit="return pass_chk(this)" >
<div class="col-xs-2" style="margin-left:40%">
<i class="far fa-user-circle fa-5x"></i>
<h3>회원가입</h3>
<input class="form-control input-sm" type="text" name="id" id = "id" placeholder="아이디 입력" required><br>
<input type="button" class="form-control" name="id_chk" id="id_chk" onclick="id_chk()" value="중복체크"><br><br>
<input class="form-control" type="password" name="password" id = "password" placeholder="비밀번호 입력" required><br><br>
<input class="form-control" type="password" name="password2" id = "password2" placeholder="비밀번호 확인" required><br><br>
<input class="form-control" type="text" name="name" id = "name" placeholder="이름 입력" required><br><br>
<input class="form-control" type="text" name="nickname" id = "nickname" placeholder="닉네임 입력" required><br>
<input type="submit" class="form-control" value="회원가입">
</div>
</form>
<br><br><br><br>
</center>
</body>
</html>