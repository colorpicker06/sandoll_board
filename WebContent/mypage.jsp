<%@page import="reply.Reply"%>
<%@page import="reply.ReplyDAO"%>
<%@page import="board.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<title>Insert title here</title>
</head>
<style>
  table {
    border-top: 1px solid #444444;
    border-collapse: collapse;
    width: 90%;
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

h2,h1{
	margin-left:5%;
}
  
</style>
<body>
<script type="text/javascript">
    function goToDetail(pk){
        location.href="detail.jsp?pk="+pk; //페이지 이동
    }
</script>
<%@ include file="../menu.jsp" %>
<br><br><br>
<h1>마이페이지 </h1>
<div id = "main">
<% 

	if(session.getAttribute("id")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("out.println('반갑습니다.')");
		script.println("</script>");
	}

	else{
		String userid = (String)session.getAttribute("id");
		
		BoardDAO boardDAO = new BoardDAO();
		ArrayList<Board> list = boardDAO.getMypage_board_list(userid);			
	%>
	<br><br>
	<h2>내 글 목록</h2><br>
	<table>
	<tr>
	<td> 글 번호 </td>
	<td> 글 제목 </td>
	<td> 글 내용 </td>
	<td> 날짜 </td>
	<td> 좋아요 </td>
	</tr>
	<tr>
	<%
	for(int i=0; i<list.size(); i++){

			out.print("<tr>");
			out.print("<td onClick='goToDetail("+list.get(i).getPk()+")'>"+ list.get(i).getPk() + "</td>");
			out.print("<td onClick='goToDetail("+list.get(i).getPk()+")'>" + list.get(i).getTitle() + "</td>");
			out.print("<td onClick='goToDetail("+list.get(i).getPk()+")'>" + list.get(i).getContent() + "</td>");
			out.print("<td onClick='goToDetail("+list.get(i).getPk()+")'>" + list.get(i).getReg_date() + "</td>");
			out.print("<td onClick='goToDetail("+list.get(i).getPk()+")'>" + list.get(i).getBoard_like() + "</td>");
			out.print("</tr>");		
	}
	%>
	</table>
	<%
	ReplyDAO replyDAO = new ReplyDAO();
	ArrayList<Reply> list2 = replyDAO.getMypage_reply_list(userid);	
	%>
	<br><br>
	<h2>내 댓글 목록</h2><br>
	<table>
	<tr>
	<td> 댓글 번호 </td>
	<td> 댓글 내용 </td>
	<td> 작성일 </td>
	</tr>
	<tr>
	<%
	for(int i=0; i<list2.size(); i++){
			out.print("<tr>");
			out.print("<td>"+ list2.get(i).getPk() + "</td>");
			out.print("<td>" + list2.get(i).getReplytext() + "</td>");
			out.print("<td>" + list2.get(i).getReg_date() + "</td>");
			out.print("</tr>");		
	}
}
	%>
</table>
</div>
</body>
</html>