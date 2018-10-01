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
var idck = 0;
$(function() {
    //idck 버튼을 클릭했을 때 
    $("#id_chk()").click(function() {     
        //userid 를 param.
        var id =  $("#id").val(); 
        
        $.ajax({
            async: true,
            type : 'POST',
            data : id,
            url : "idcheck.do",
            dataType : "json",
            contentType: "application/json; charset=UTF-8",
            success : function(data) {
                if (data.cnt > 0) {
                    
                    alert("아이디가 존재합니다. 다른 아이디를 입력해주세요.");
                    //아이디가 존제할 경우 빨깡으로 , 아니면 파랑으로 처리하는 디자인
                    $("#divInputId").addClass("has-error")
                    $("#divInputId").removeClass("has-success")
                    $("#userid").focus();
                    
                
                } else {
                    alert("사용가능한 아이디입니다.");
                    //아이디가 존제할 경우 빨깡으로 , 아니면 파랑으로 처리하는 디자인
                    $("#divInputId").addClass("has-success")
                    $("#divInputId").removeClass("has-error")
                    $("#userpwd").focus();
                    //아이디가 중복하지 않으면  idck = 1 
                    idck = 1;
                    
                }
            },
            error : function(error) {
                
                alert("error : " + error);
            }
        });
    });
});
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
<script>

function pass_chk(password,password2){
	if(password!=password2){
		alert("비밀번호가 다릅니다.");
		location.href='signin.jsp'
	}
}

</script>

<center>
<br><br><br>
<form class="form-inline" method="post" action="signin_ok.jsp" onsubmit="return pass_chk(this)" >
<div class="form-group">
<i class="far fa-user-circle fa-5x" style="margin-left:0;"></i>
<h3>회원가입</h3>
아이디:&nbsp;<input class="form-control input-sm" type="text" name="id" id = "id" placeholder="아이디 입력" required>
<input type="button" class="form-control" name="id_chk" id="id_chk" onclick="id_chk()" value="중복체크"><br><br>
비밀번호 입력:&nbsp;&nbsp;<input class="form-control" type="password" name="password" id = "password" placeholder="비밀번호 입력" required><br><br>
비밀번호 확인:&nbsp;&nbsp;<input class="form-control" type="password" name="password2" id = "password2" placeholder="비밀번호 확인" required><br><br>
이름 입력:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" type="text" name="name" id = "name" placeholder="이름 입력" required><br><br>
닉네임 입력:&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" type="text" name="nickname" id = "nickname" placeholder="닉네임 입력" required><br><br>
<input type="submit" class="form-control" value="회원가입">
</div>
</form>
</center>
</body>
</html>