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
    <jsp:setProperty name = "user" property="reg_date"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../menu.jsp" %>

<form method="post" action="info_change_ok.jsp">
<input type="text" name="id" id = "id" placeholder="아이디"><br>
<input type="text" name="id" id = "id" placeholder="비밀번호"><br>
<input type="text" name="id" id = "id" placeholder="이름" disabled><br>
<input type="text" name="id" id = "id" placeholder="닉네임"><br>
<input type="text" name="id" id = "id" placeholder="가입일" disabled><br>
</form>

</body>
</html>