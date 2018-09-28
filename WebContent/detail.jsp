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
			width: 100%;
			border-top: 1px solid #444444;
			border-collapse: collapse;
		}
		
		th, td {
			border-bottom: 1px solid #444444;
			padding: 10px;
		}
	</style>


	<%@ include file="../menu.jsp"%>
	<h2>글 상세보기</h2>
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
			<form method="post" action="board_change.jsp" name="form1" id="form1">
				<input type="hidden" name="pk" id="pk" value="<%=list.get(i).getPk()%>"></input><br>
				<h3>글 제목</h3>
				<input type="text" name="title" id="title" value="<%=list.get(i).getTitle()%>"></input><br>
				<h3>글 내용</h3>
				<textarea name="content" id="content"><%=list.get(i).getContent()%></textarea>
				<br>
				<h3>글쓴이</h3><%= list.get(i).getWriter() %><br>
				<h3>작성일</h3><%= list.get(i).getReg_date() %><br>
				<h3>좋아요 수</h3><%= list.get(i).getBoard_like() %><br>
				<input type="submit" value="수정"> <input type="button" value="삭제" onclick="board_delete(<%=list.get(i).getPk()%>);">
				<input type="button" value="글 목록으로 돌아가기" onclick="board_list();">
			</form>

		<%} //end of if
		
		//다른 사람이 게시물을 볼 때
		else{
			
	%>
			<h1>제목</h1><%= list.get(i).getTitle() %>
			<h1>글쓴이</h1><%= list.get(i).getWriter()%>
			<h1>작성일</h1><%= list.get(i).getReg_date()%><br><br>

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
		 <i class="fas fa-heart"></i>
	 <%
	 }//end of if
	 
	 //좋아요 안 눌렀을 때
	 else if(board_like == -1){ %>
		 <i class="far fa-heart" id="like" onclick="like('<%=board_pk%>','<%=session.getAttribute("id")%>','<%= heart_count %>');"></i>
	<% }
	
	 %>

	<h1>좋아요</h1><%= heart_count %>

<!--  댓글  -->
	<br>
	<br> 댓글 목록
	<br>
	<br>
	<br>
	<br>
	<form action="reply_ok.jsp" method="post">
		<%= session.getAttribute("id") %>&nbsp; &nbsp; 
		<input type="text" size="100%" name="replytext" id="replytext"> 
		<input type="hidden" name="board_pk" id="board_pk" value="<%=pk%>">
		<input type="hidden" name="user_reply_pk" id="user_reply_pk" value="<%= session.getAttribute("id") %>">
		<input type="submit" value="댓글 작성">
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
			<form action='reply_change.jsp' method='post'>
				<td>
					<input name="replytext" id="replytext" type='text' value="<%= reply_list.get(i).getReplytext() %>" />
				</td>
				<td>
					<%= reply_list.get(i).getUser_reply_pk() %>
				</td>
				<td>
					<%=reply_list.get(i).getReg_date()%>
					<input type='submit' value='수정하기' /><input type='button' value='삭제하기' onclick='reply_delete(<%=reply_list.get(i).getUser_reply_pk()%>);' />
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
</body>
</html>