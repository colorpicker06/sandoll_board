<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 	<%@ page import = "board_like.Board_LikeDAO" %>
 	<%@ page import = "java.io.PrintWriter" %>
 	<% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id = "board_like" class="board_like.Board_Like" scope="page"/>
    <jsp:setProperty name = "board_like" property="board_pk"/>
    <jsp:setProperty name = "board_like" property="user_pk"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Board_LikeDAO likeDAO = new Board_LikeDAO();
	BoardDAO boardDAO = new BoardDAO();
	
	int board_pk =Integer.parseInt(request.getParameter("board_pk"));
	int heart_count =Integer.parseInt(request.getParameter("heart_count"))+1;
	
	int result2 = boardDAO.board_like_count(board_pk, heart_count);
	
	int result = likeDAO.like(board_like);
	if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('실패')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("history.back()");
		script.println("</script>");
	}
%>
</body>
</html>