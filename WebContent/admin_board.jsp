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
<link rel="stylesheet" href="css/bootstrap.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
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

	/*if(!InetAddress.getLocalHost().getHostAddress().equals("192.168.1.79")){ //192.168.0.22 sandollguest 192.168.1.221
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자페이지에 접속 할 수 있는 ip가 아닙니다.')");
		script.println("location.href=('index.jsp')");
		script.println("</script>");
	}*/
	
	String pageNumber = "1";
	if(request.getParameter("pageNumber")!= null){
		pageNumber = request.getParameter("pageNumber");
	}
	try{
		Integer.parseInt(pageNumber);
	}catch(Exception e){
		response.sendRedirect("board_list.jsp");
		return;
	}
	
	BoardDAO boardDAO = new BoardDAO();
	ArrayList<Board> boardList = new BoardDAO().getList(pageNumber);


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
for(int i=0; i<boardList.size(); i++){
	Board board = boardList.get(i); %>
	<tr>
	<form action='admin_board_change.jsp' method='post'>
	<td><%=board.getPk() %></td>
	<td><input type="text" name="title" id = "title" value="<%=board.getTitle()%>"></input></td>
	<td><input type="text" name="writer" id = "writer" value="<%=board.getWriter()%>"></input></td>
	<td><input type="text" name="reg_date" id = "reg_date" value="<%=board.getReg_date()%>"></input></td>
	<td><input type="number" name="board_like" id = "board_like" value="<%=board.getBoard_like()%>"></input></td>
	<td>
	<input type="hidden" name="pk" id="pk" value="<%=board.getPk()%>">	
	<select name="board_delete" id="board_delete">
		<option value=0 <% if(board.getBoard_delete()==0){%>selected<% } %>>일반 게시물</option>
		<option value=1 <% if(board.getBoard_delete()==1){%>selected<% } %>>삭제 게시물</option>
	</select>
	<input type="submit" value="수정">	
	</td>
	</form>	
	</tr>
<%}
%>
</table>
<ul class="pagination" style="margin-left:45%;">
<%
	int startPage = (Integer.parseInt(pageNumber)/10)*10 +1;
	if(Integer.parseInt(pageNumber)%10==0) startPage -= 10;
	int targetPage = new BoardDAO().targetPage(pageNumber);
	if(startPage!=1){
%>
<li><a href = "admin_board?pageNumber=<%= startPage-1 %>"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
<% 
	}else {
%>
<li><span class="glyphicon glyphicon-chevron-left" style="color:gray;"></span></li>
<% } 
	for(int i= startPage; i<Integer.parseInt(pageNumber); i++){ %>
	<li><a href = "admin_board.jsp?pageNumber=<%= i %>"><%= i %></a></li>
<% }
%>
	<li><a href = "admin_board.jsp?pageNumber=<%= pageNumber %>" style="color:red;"><%= pageNumber %></a></li>
	
<%
	for(int i=Integer.parseInt(pageNumber)+1; i<=targetPage+Integer.parseInt(pageNumber); i++){
		if(i<startPage+10){ %>
		<li><a href = "admin_board.jsp?pageNumber=<%= i %>"><%= i %></a></li>
<%		}
	}
if(targetPage + Integer.parseInt(pageNumber)>startPage+9){ %>
	<li><a href = "admin_board.jsp?pageNumber=<%= startPage+10 %>"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
<%
} else{ %>
	<li><span class="glyphicon glyphicon-chevron-right" style="color:gray;"></span></a></li>
<%
}
%>
</ul>
</div>
</body>
</html>