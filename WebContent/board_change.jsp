<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "board.BoardDAO" %>
	<%@ page import = "java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id = "board" class="board.Board" scope="page"/>
    <jsp:setProperty name = "board" property="pk"/>
    <jsp:setProperty name = "board" property="title"/>
    <jsp:setProperty name = "board" property="content"/>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	String pk = request.getParameter("pk");
	String title = request.getParameter("title");
	String content = request.getParameter("content");

	BoardDAO boardDAO = new BoardDAO();
	int result = boardDAO.board_change(board);
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
		script.println("location.href='board_list.jsp'");
		script.println("</script>");
	}

%>
</body>
</html>