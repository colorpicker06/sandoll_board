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
<%


	String userID = null;
	if (session.getAttribute("id") != null){
		userID = (String) session.getAttribute("id");
	}
	
	int pageNumber = 1;
	if(request.getParameter("pageNumber")!= null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}

%>
<br><br>
<h1>글 목록</h1>
<table>
<tr>
<td> 글 번호 </td>
<td> 글 제목 </td>
<td> 글쓴이 </td>
<td> 날짜 </td>
<td> 좋아요 </td>
</tr>
<tr>
<%

		BoardDAO boardDAO = new BoardDAO();
		ArrayList<Board> list = boardDAO.getList(pageNumber);
		int count = boardDAO.board_count();
		Statement stmt = null;
		
		//페이징
		int totalRecord = count; //전체 글의 수
		int numPerPage = 5; //한 페이지당 보여질 근의 수
		int pagePerBlock =3; //한 블럭당묶여질 페이지 수
		int totalPage = 0; //전체 페이지의 수
		int totalBlock = 0; //전체 블럭  수
		int nowPage = 0; //현재 보여질 페이지
		int nowBlock = 0; //현재 보여질 블럭
		int beginPerPage = 0;//각 페이지의 시작 글 번호
			
		for(int i=0; i<list.size(); i++){
		
		if(list.get(i).getWriter().equals("admin")){ %>
			<tr>
			<td class="admin"> <a class="admin" href = "detail.jsp?pk=<%=list.get(i).getPk()%>"><%= count %></a></td>
			<td class="admin"> <a class="admin" href = "detail.jsp?pk=<%=list.get(i).getPk()%>"> <%= list.get(i).getTitle() %></a></td>
			<td class="admin"> <a class="admin" href = "detail.jsp?pk=<%=list.get(i).getPk()%>"> <%= list.get(i).getWriter()%> </a></td>
			<td class="admin"> <a class="admin" href = "detail.jsp?pk=<%=list.get(i).getPk()%>"> <%= list.get(i).getReg_date()%> </a></td>
			<td class="admin"> <a class="admin" href = "detail.jsp?pk=<%=list.get(i).getPk()%>"> <%= list.get(i).getBoard_like()%> </a></td>
			</tr>
		<%}
		
		else{ %>
		<tr>
		<td> <a href = "detail.jsp?pk=<%=list.get(i).getPk()%>"><%= count %></a></td>
		<td> <a href = "detail.jsp?pk=<%=list.get(i).getPk()%>"> <%= list.get(i).getTitle() %></a></td>
		<td> <a href = "detail.jsp?pk=<%=list.get(i).getPk()%>"> <%= list.get(i).getWriter()%> </a></td>
		<td> <a href = "detail.jsp?pk=<%=list.get(i).getPk()%>"> <%= list.get(i).getReg_date()%> </a></td>
		<td> <a href = "detail.jsp?pk=<%=list.get(i).getPk()%>"> <%= list.get(i).getBoard_like()%> </a></td>
		</tr>
		<%}
		}
		%>

</table> <br><br>
<%

	if(pageNumber != 1){ %>
		<a href="board_list.jsp?pageNumber=<%= pageNumber-1 %>" class="btn btn-primary btn-arrow-left">이전</a>
	<%}
		if(boardDAO.nextPage(pageNumber)){ %>
			<a href="board_list.jsp?pageNumber=<%= pageNumber+1 %>" class="btn btn-primary btn-arrow-left">다음</a>
		<%}%>
</body>
</html>