<%@page import="java.io.PrintWriter"%>
<%@page import="user.User"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<style>
</style>
<body>
<script>
function form_close(){
	window.close();
}
</script>
<center>
<%	
	String id = request.getParameter("id");

	UserDAO userDAO = new UserDAO();
	boolean result = userDAO.id_chk(id);
	
	if(result){ %>
		<img src="image/doll.png" width=20%/><br>
		<h1>이미 사용중인 아이디 입니다.</h1><br>
	<%}
	
	else{ %>
		<img src="image/doll.png" width=20%/><br>
		<h1>사용가능한 아이디 입니다.</h1><br>
	<%}

%>
<div class="form-group row">
  	<div class="col-xs-2">
		<input class="form-control" style="margin-left:320%;" type="button" value="창 닫기" onclick="form_close()">
	</div>
</div>
</center>
</body>
</html>