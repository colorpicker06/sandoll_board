<%@page import="board_like.Board_Like"%>
<%@page import="board_like.Board_LikeDAO"%>
<%@page import="reply.Reply"%>
<%@page import="reply.ReplyDAO"%>
<%@page import="board.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">
	<link rel="stylesheet" href="css/bootstrap.css">
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<title>글 상세보기</title>
<style>
body{
font-family: 'Nanum Gothic', sans-serif;
}
</style>
</head>
<body>

	<script>
		function board_change(){
			location.href = "board_change.jsp";
		}
		
		function board_delete(pk){
			location.href = "board_delete.jsp?pk="+pk;
		}
		
		function reply_delete(pk){
			location.href = "reply_delete.jsp?pk="+pk;
		}
		
		function board_list(){
			location.href = "board_list.jsp";
		}
		
		function like(board_pk,user_pk,heart_count){
			alert("누름");
			document.getElementById("like").className = "fas fa-heart";
			location.href="board_like.jsp?board_pk="+board_pk+"&user_pk="+user_pk+"&heart_count="+heart_count;
		}
	</script>
	
	<style>
		table {
			width: 80%;
			border-top: 1px solid #444444;
			border-collapse: collapse;
		}
		
		th, td {
			border-bottom: 1px solid #444444;
			padding: 10px;
		}
		
		div.form-group{
		margin-left:auto;
		margin-right:auto;
		}
	</style>


	<%@ include file="../menu.jsp"%>
	<center>
<br><br>
	<br>
	<%

	//비회원일시
	if(session.getAttribute("id")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용해 주세요. ')");
		script.println("location.href = 'login.jsp'; ");
		script.println("</script>");
	}

	int pk = Integer.parseInt(request.getParameter("pk"));
	BoardDAO boardDAO = new BoardDAO();
	ArrayList<Board> list = boardDAO.getDetail(pk);
		
	for(int i=0; i<list.size(); i++){ 
	
		//글쓴이가 자신의 게시물을 볼 때 (수정 및 삭제 가능)
		if(session.getAttribute("id").equals(list.get(i).getWriter())){%>
				
			<form method="post" class="form-inline" action="board_change.jsp" name="form1" id="form1">
			<div class="form-group">
			<div class="col-xs-5">
				<input class="form-control"   type="hidden" name="pk" id="pk" value="<%=list.get(i).getPk()%>"></input><br><br>
				<input class="form-control" size="50" style="font-size:30px" type="text" name="title" id="title" value="<%=list.get(i).getTitle()%>"></input><br><br>
				<hr>
				<%= list.get(i).getWriter() %> / <%= list.get(i).getReg_date() %><br><br>
				<textarea class="form-control" rows="15" cols="100" name="content" id="content"><%=list.get(i).getContent()%></textarea>
				<br><br>
				<input class="form-control" type="submit" value="수정"> <input class="form-control" type="button" value="삭제" onclick="board_delete(<%=list.get(i).getPk()%>);">
				<input class="form-control" type="button" value="글 목록으로 돌아가기" onclick="board_list();">
				</div>
			</div>
			</form>
			

		<%} //end of if
		
		//다른 사람이 게시물을 볼 때
		else{
			
	%>
			<h1><%= list.get(i).getTitle() %></h1>
			<hr size="30">
			<h5><%= list.get(i).getWriter()%> / <%= list.get(i).getReg_date()%></h5><br><br>
			<h3><%=list.get(i).getContent()%></h3>

	<%
		} //end of else
	}
	
	Board_LikeDAO likeDAO = new Board_LikeDAO();
	int heart_count = likeDAO.heart_count(pk);
	
	int board_pk = pk;
	String user_id = (String)session.getAttribute("id");
	
	int board_like = likeDAO.getHeart(user_id,board_pk);
	
	//좋아요 눌렀을 때
	 if(board_like == 1){ %>
		 <br><br><i style="margin-left:0;" class="fas fa-heart fa-4x"></i>
	 <%
	 }//end of if
	 
	 //좋아요 안 눌렀을 때
	 else if(board_like == -1){ %>
		 <br><br><i style="margin-left:0;" class="far fa-heart fa-4x" id="like" onclick="like('<%=board_pk%>','<%=session.getAttribute("id")%>','<%= heart_count %>');"></i>
	<% }
	
	 %>

	<h1>Like <%= heart_count %></h1>

<!--  댓글  -->
	<br>
	
	<form action="reply_ok.jsp" method="post" class="form-inline" ><br><br><br><br>
	<div class="form-group">
  	<div class="col-xs-3">
		<%= session.getAttribute("id") %>&nbsp; &nbsp; 
		<input class="form-control"type="text" size="100%" name="replytext" id="replytext"> 
		<input class="form-control" type="hidden" name="board_pk" id="board_pk" value="<%=pk%>">
		<input class="form-control" type="hidden" name="user_reply_pk" id="user_reply_pk" value="<%= session.getAttribute("id") %>">
		<input class="form-control" type="submit" value="댓글 작성">
	</div>
	</div>
	</form>
	
	<table>
		<tr>
			<td>댓글 번호</td>
			<td>댓글</td>
			<td>글쓴이</td>
			<td>날짜</td>
		</tr>

<%
	ReplyDAO replyDAO = new ReplyDAO();
	ArrayList<Reply> reply_list = replyDAO.get_reply_list(pk);
		
	for(int i=0; i<reply_list.size(); i++){ 
		
		int board_reply_delete = reply_list.get(i).getBoard_reply_delete();
		
		if(board_reply_delete!=1){
			
			if(reply_list.get(i).getUser_reply_pk().equals(session.getAttribute("id"))){%>
		
		<tr>
			<td><%= reply_list.get(i).getUser_reply_pk() %></td>
			<form action='reply_change.jsp' method='post' class="form-inline">
				<td>
					<input name="replytext" class="form-control" id="replytext" type='text' value="<%= reply_list.get(i).getReplytext() %>" />
				</td>
				<td>
					<%= reply_list.get(i).getUser_reply_pk() %>
				</td>
				<td>
					<%=reply_list.get(i).getReg_date()%>&nbsp;&nbsp;
					<input class="btn btn-primary" type='submit' value='수정하기' />&nbsp;&nbsp;<input class="btn btn-primary" type='button'value='삭제하기' onclick='reply_delete(<%=reply_list.get(i).getUser_reply_pk()%>);' />
				</td>
				
				<input type="hidden" name="pk" id="pk" value="<%= reply_list.get(i).getUser_reply_pk() %>"> 
				<input type="hidden" name="reg_date" id="reg_date" value="<%= reply_list.get(i).getReg_date() %>">
			</form>
		</tr>
		<%	}	
			else{
				out.print("<tr>");
				out.print("<td>"+ reply_list.get(i).getUser_reply_pk() + "</td>");
				out.print("<td>" + reply_list.get(i).getReplytext() + "</td>");
				out.print("<td>" + reply_list.get(i).getUser_reply_pk() + "</td>");
				out.print("<td>" + reply_list.get(i).getReg_date() + "</td>");
				out.print("</tr>");
			}
		}		
	}
	%>
	</table>
	<br><br><br><br>
	</center>
</body>
</html>