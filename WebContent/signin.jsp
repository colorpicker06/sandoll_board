<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/signin.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<style>
*.{
	margin:10%;
	display: inline-block;
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



<h2>&nbsp; &nbsp;Sign In</h2>

<form method="post" action="signin_ok.jsp" onsubmit="return pass_chk(this)" >
<div class="col-xs-2">
<input class="form-control input-sm" type="text" name="id" id = "id" placeholder="아이디 입력" required>
<input type="button" name="id_chk" id="id_chk" onclick="id_chk()" value="중복체크"><br>
<input class="form-control" type="password" name="password" id = "password" placeholder="비밀번호 입력" required><br>
<input class="form-control" type="password" name="password2" id = "password2" placeholder="비밀번호 확인" required><br>
<input class="form-control" type="text" name="name" id = "name" placeholder="이름 입력" required><br>
<input class="form-control" type="text" name="nickname" id = "nickname" placeholder="닉네임 입력" required><br>
<input type="submit" value="회원가입">
</div>
</form>

</body>
</html>