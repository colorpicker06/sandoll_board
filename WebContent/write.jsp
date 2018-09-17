<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../menu.jsp" %>
글 쓰기
<% 

	if(session.getAttribute("id")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용해 주세요. ')");
		script.println("location.href = 'login.jsp'; ");
		script.println("</script>");
	}

	else{
		String userid = (String)session.getAttribute("id");
		%>
			<form method="post" action="write_ok.jsp">
			제목 : <input type="text" placeholder="제목" id="title" name="title"><br>
			내용 :  <textarea id="content" name="content" cols="30"></textarea><br>
			<input type="hidden" name="writer" id="writer" value="<%= userid %>">
			<input type="submit" value="작성완료">
			</form>
			<%	}
%>
</body>
</html>