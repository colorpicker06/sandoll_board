<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.ResultSet"%>
	<%@page import="java.sql.DriverManager"%>
	<%@page import="java.sql.Statement"%>
	<%@page import="java.sql.Connection"%>
	<%@ page import = "java.io.PrintWriter" %>
	<%@ page import = "board.BoardDAO" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id = "board" class="board.Board" scope="page"/>
    <jsp:setProperty name = "board" property="pk"/>
    <jsp:setProperty name = "board" property="title"/>
    <jsp:setProperty name = "board" property="writer"/>
    <jsp:setProperty name = "board" property="reg_date"/>
    <jsp:setProperty name = "board" property="board_delete"/>
    <jsp:setProperty name = "board" property="board_like"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	BoardDAO boardDAO = new BoardDAO();
		int result = boardDAO.board_state(board);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('실패 ')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 되었습니다.')");
			script.println("location.href='admin_board.jsp'");
			script.println("</script>");
		}
		
%>
</body>
</html>