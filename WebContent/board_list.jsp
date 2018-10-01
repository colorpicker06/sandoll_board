<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import = "board.BoardDAO" %>
<%@ page import = "board.Board" %>
 	<%@ page import = "java.io.PrintWriter" %>
 	<% request.setCharacterEncoding("UTF-8"); %>
    <%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<style>
body{
font-family: 'Nanum Gothic', sans-serif;
}

  table {
    border-top: 1px solid #444444;
    border-collapse: collapse;
    text-decoration: none;
    width: 70%;
    margin-left:auto;
    margin-right:auto;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
    text-decoration: none;
  }
  a{
   text-decoration: none;
   color:black;
   }
  td.admin{
  	color:red;
  }
  a.admin{
  	color:red;
  }
  
  h1{
  	margin-left:15%;
  }
  
  a.btn.btn-primary btn-arrow-left{
  	margin-left:auto;
  	margin-right:auto;
  }
  
</style>
<script type="text/javascript">
    function list(page){
        location.href="detail.jsp?curPage="+page; //페이지 이동
    }
</script>
<body>

<%@ include file="../menu.jsp" %>

<a href="write.jsp"><img src=  "image/img_6.png" width=100%></a>
<%
	String userID = null;
	if (session.getAttribute("id") != null){
		userID = (String) session.getAttribute("id");
	}
	
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
	//ArrayList<Board> list = boardDAO.getList(pageNumber);
	int count = boardDAO.board_count();
	ArrayList<Board> boardList = new BoardDAO().getList(pageNumber);

%>
<br><br>
<h1>글 목록</h1>
<table>
<tr>
<td> 글 제목 </td>
<td> 글쓴이 </td>
<td> 날짜 </td>
<td> 좋아요 </td>
</tr>
<tr>


<%

		
		//Statement stmt = null;
			
		for(int i=0; i<boardList.size(); i++){
		Board board = boardList.get(i);
		
		if(board.getWriter().equals("admin")){ %>
			<tr>
			<td class="admin"> <a class="admin" href = "detail.jsp?pk=<%=board.getPk()%>"> <%= board.getTitle() %></a></td>
			<td class="admin"> <a class="admin" href = "detail.jsp?pk=<%=board.getPk()%>"> <%= board.getWriter()%> </a></td>
			<td class="admin"> <a class="admin" href = "detail.jsp?pk=<%=board.getPk()%>"> <%= board.getReg_date()%> </a></td>
			<td class="admin"> <a class="admin" href = "detail.jsp?pk=<%=board.getPk()%>"> <%= board.getBoard_like()%> </a></td>
			</tr>
		<%}
		
		else{ %>
		<tr>
		<td> <a href = "detail.jsp?pk=<%=board.getPk()%>"> <%= board.getTitle() %></a></td>
		<td> <a href = "detail.jsp?pk=<%=board.getPk()%>"> <%= board.getWriter()%> </a></td>
		<td> <a href = "detail.jsp?pk=<%=board.getPk()%>"> <%= board.getReg_date()%> </a></td>
		<td> <a href = "detail.jsp?pk=<%=board.getPk()%>"> <%= board.getBoard_like()%> </a></td>
		</tr>
		<%}
		}
		%>

</table> <br><br>

<ul class="pagination" style="margin-left:45%;">
<%
	int startPage = (Integer.parseInt(pageNumber)/10)*10 +1;
	if(Integer.parseInt(pageNumber)%10==0) startPage -= 10;
	int targetPage = new BoardDAO().targetPage(pageNumber);
	if(startPage!=1){
%>
<li><a href = "board_list.jsp?pageNumber=<%= startPage-1 %>"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
<% 
	}else {
%>
<li><span class="glyphicon glyphicon-chevron-left" style="color:gray;"></span></li>
<% } 
	for(int i= startPage; i<Integer.parseInt(pageNumber); i++){ %>
	<li><a href = "board_list.jsp?pageNumber=<%= i %>"><%= i %></a></li>
<% }
%>
	<li><a href = "board_list.jsp?pageNumber=<%= pageNumber %>" style="color:red;"><%= pageNumber %></a></li>
	
<%
	for(int i=Integer.parseInt(pageNumber)+1; i<=targetPage+Integer.parseInt(pageNumber); i++){
		if(i<startPage+10){ %>
		<li><a href = "board_list.jsp?pageNumber=<%= i %>"><%= i %></a></li>
<%		}
	}
if(targetPage + Integer.parseInt(pageNumber)>startPage+9){ %>
	<li><a href = "board_list.jsp?pageNumber=<%= startPage+10 %>"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
<%
} else{ %>
	<li><span class="glyphicon glyphicon-chevron-right" style="color:gray;"></span></a></li>
<%
}
%>
</ul>

<br><br><br>
</body>
</html>