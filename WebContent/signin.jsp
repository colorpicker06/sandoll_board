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
<script>
	function id_chk(){
		var userID = $('#id').val();
		$.ajax({
			typd:'POST',
			url:'./UserRegisterCheckServlet',
			data:{userId:userID},
			success:function(result){
				if(result==1){
					alert("사용할 수 있는 아이디 입니다.");
				}
				else{
					alert("중복된 아이디 입니다.");
				}
			}
		});
	}
	
	function pass_chk(){
		
		var myform = document.forms['form'];
		
		var pass1 = myform['password'].value;
		var pass2 = myform['password2'].value;

		if(pass1!=pass2){
			alert("패스워드가 다릅니다.");
			return false;
		}
	}
</script>

<style>
*.{
	margin:10%;
	display: inline-block;
}

body{
font-family: 'Nanum Gothic', sans-serif;
padding-bottom: 10%;
}

div.form-group{
		margin-left:auto;
		margin-right:auto;
		}
		
input{
margin-left:auto;
margin-right:auto;
}

</style>

<body>
<%@ include file="../menu.jsp" %>

<center>
<br><br><br>
<form id = "form" class="form-inline" method="post" action="signin_ok.jsp" onsubmit="return pass_chk()" >
<div class="form-group">
<i class="far fa-user-circle fa-5x" style="margin-left:0;"></i>
<h3>회원가입</h3>
아이디:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" type="text" name="id" id = "id" placeholder="아이디 입력" required><br><br>
비밀번호:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" type="password" name="password" id = "password" placeholder="비밀번호 입력" required><br><br>
비밀번호 확인:&nbsp;<input class="form-control" type="password" name="password2" id = "password2" placeholder="비밀번호 확인" required><br><br>
이름:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" type="text" name="name" id = "name" placeholder="이름 입력" required><br><br>
닉네임:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" type="text" name="nickname" id = "nickname" placeholder="닉네임 입력" required><br><br>
<input type="submit" class="form-control" value="회원가입">
</div>
</form>
</center>
</body>
</html>