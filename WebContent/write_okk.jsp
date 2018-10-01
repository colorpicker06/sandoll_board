<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 	<%@ page import = "board.BoardDAO" %>
 	<%@ page import = "java.io.PrintWriter" %>
 	<% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id = "board" class="board.Board" scope="page"/>
    <jsp:setProperty name = "board" property="title"/>
    <jsp:setProperty name = "board" property="content"/>
    <jsp:setProperty name = "board" property="writer"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String content = request.getParameter("content");
	String	title = request.getParameter("title");
	String pk1 = request.getParameter("pk1");
	String pk2 = request.getParameter("pk2");
	String pk3 = request.getParameter("pk3");
	
	out.print("글 내용"+content);
	out.print("pk1"+pk1);
	out.print("pk2"+pk2);
	out.print("pk3"+pk3);
	
	if (content.indexOf(pk2) >-1 && content.indexOf(pk1) >-1 && content.indexOf(pk3) >-1 ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='write_ok.jsp'");
		script.println("</script>");
	}
	
	else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글자를 모두 포함하지 않았습니다. 다시 쓰세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	
%>
</body>
</html>