<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
    <%@ page import = "board.BoardDAO" %>
    <%@ page import = "java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id = "board" class="board.Board" scope="page"/>
    <jsp:setProperty name = "board" property="pk"/>
     <jsp:setProperty name = "board" property="board_delete"/>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//int pk = Integer.parseInt(request.getParameter("pk"));

	//String pk = request.getParameter("pk");
	//String title = request.getParameter("title");
	//String content = request.getParameter("content");
	
	BoardDAO boardDAO = new BoardDAO();
	int result = boardDAO.board_delete(board);
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
		script.println("alert('삭제 되었습니다.')");
		script.println("location.href='board_list.jsp'");
		script.println("</script>");
	}
%>

<%


/*
Connection conn = null;
Statement stmt = null;
int count=0;
String pk = request.getParameter("pk");

out.print(pk);


try{	
    Class.forName("com.mysql.jdbc.Driver");
    String dbURL = "jdbc:mysql://localhost:3306/sandoll_board?useSSL=false";
	String dbID = "root";
	String dbPassword = "1234";
	conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
    stmt = conn.createStatement();

    //String sql = "delete from board where pk ="+"'"+pk+"'";
    //ResultSet rs = stmt.executeQuery(sql);
    
    String sql = "delete from board where pk="+pk;
    ResultSet rs = stmt.executeQuery(sql);
    
    PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('삭제되었습니다.')");
	script.println("location.href='board_list.jsp'");
	script.println("</script>");

    conn.close();
}catch(Exception e){
    out.println("데이터베이스에 문제가 있습니다.");
    out.println(e.getMessage());
    e.getStackTrace();
}*/
%> 
</body>
</html>