<%@page import="board.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.net.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
<style>
  table {
    border-top: 1px solid #444444;
    border-collapse: collapse;
    width: 80%;
    margin-left:auto;
    margin-right:auto;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
  
  body{
font-family: 'Nanum Gothic', sans-serif;
}

h1{
	margin-left:10%;
}
  
</style>
<body>
<%@ include file="../menu.jsp" %>
<div id = "main">
<%
	String userID = null;
	if (session.getAttribute("id") != null){
		userID = (String) session.getAttribute("id");
	}
	
	int pageNumber = 1;
	if(request.getParameter("pageNumber")!= null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}

	if(!InetAddress.getLocalHost().getHostAddress().equals("192.168.1.79")){ //192.168.0.22 sandollguest 192.168.1.221
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자페이지에 접속 할 수 있는 ip가 아닙니다.')");
		script.println("location.href=('index.jsp')");
		script.println("</script>");
	}
	
	BoardDAO boardDAO = new BoardDAO();
	ArrayList<Board> list = boardDAO.get_admin_List(pageNumber);

%>
<h1>게시글 관리</h1> <br>
<table>
<tr>
<td> 번호 </td>
<td> 제목 </td>
<td> 작성자 </td>
<td> 날짜 </td>
<td> 좋아요 </td>
<td> 삭제여부 </td>
</tr>

<%
for(int i=0; i<list.size(); i++){ %>
	<tr>
	<form action='admin_board_change.jsp' method='post'>
	<td><%=list.get(i).getPk() %></td>
	<td><input type="text" name="title" id = "title" value="<%=list.get(i).getTitle()%>"></input></td>
	<td><input type="text" name="writer" id = "writer" value="<%=list.get(i).getWriter()%>"></input></td>
	<td><input type="text" name="reg_date" id = "reg_date" value="<%=list.get(i).getReg_date()%>"></input></td>
	<td><input type="number" name="board_like" id = "board_like" value="<%=list.get(i).getBoard_like()%>"></input></td>
	<td>
	<input type="hidden" name="pk" id="pk" value="<%=list.get(i).getPk()%>">	
	<select name="board_delete" id="board_delete">
		<option value=0 <% if(list.get(i).getBoard_delete()==0){%>selected<% } %>>일반 게시물</option>
		<option value=1 <% if(list.get(i).getBoard_delete()==1){%>selected<% } %>>삭제 게시물</option>
	</select>
	<input type="submit" value="수정">	
	</td>
	</form>	
	</tr>
<%}
%>
</table>
<%
	if(pageNumber != 1){ %>
		<a href="admin_board.jsp?pageNumber=<%= pageNumber-1 %>" class="btn btn-primary btn-arrow-left">이전</a>
	<%}
		if(boardDAO.nextPage(pageNumber)){ %>
			<a href="admin_board.jsp?pageNumber=<%= pageNumber+1 %>" class="btn btn-primary btn-arrow-left">다음</a>
		<%}%>
</div>
</body>
</html>