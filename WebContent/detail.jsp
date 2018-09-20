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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<title>글 상세보</title>
</head>
<body>
<script>
function board_change(){
	location.href = "board_change.jsp";
}

function board_delete(pk){
	location.href = "board_delete.jsp?pk="+pk;
}

function board_list(){
	location.href = "board_list.jsp";
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


<%@ include file="../menu.jsp" %>
<%

if(session.getAttribute("id")==null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인 후 이용해 주세요. ')");
	script.println("location.href = 'login.jsp'; ");
	script.println("</script>");
}

else{
	String pk = request.getParameter("pk");
	Connection conn = null;
	Statement stmt = null;
	int count=0;


	try{
	    Class.forName("com.mysql.jdbc.Driver");
	    String dbURL = "jdbc:mysql://localhost:3306/sandoll_board?useSSL=false";
		String dbID = "root";
		String dbPassword = "1234";
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
	    stmt = conn.createStatement();

        ResultSet rs = stmt.executeQuery("select * from board where pk ="+pk);
        
        

%>

<h2>글 상세보기</h2> <br>

	<%
	PrintWriter script = response.getWriter();
	script.println("<script>");	
	script.println("location.reload();");
	script.println("</script>");
	
	while(rs.next()){ 
	
		//if(session.getAttribute("id")!=null){
		
			if(session.getAttribute("id").equals(rs.getString("writer"))){%>
			<form method="post" action = "board_change.jsp" name="form1" id="form1">
			<input type="hidden" name="pk" id = "pk" value="<%=rs.getString("pk")%>"></input><br>
			<h3>글 제목 </h3> <input type="text" name="title" id = "title" value="<%=rs.getString("title")%>"></input><br>
			<h3>글 내용 </h3><textarea name="content" id = "content" ><%=rs.getString("content")%></textarea><br>
			<h3>글쓴이 </h3><%= rs.getString("writer") %><br>
			<h3>작성일 </h3><%= rs.getString("reg_date") %><br>
			<h3>좋아요 수</h3><%= rs.getString("reg_date") %><br>
			 
			<input type="submit" value="수정">
			<input type="button" value="삭제" onclick="board_delete(<%=rs.getString("pk")%>);">
			<input type="button" value="글 목록으로 돌아가기" onclick="board_list();">
			</form>
			
		<%}//end if
			 //end if
		
		else{ %>
	
		<h3>글 제목 </h3><%= rs.getString("title") %><br>
		<h3>글 내용 </h3><%= rs.getString("content") %><br>
		<h3>글쓴이 </h3><%= rs.getString("writer") %><br>
		<h3>작성일 </h3><%= rs.getString("reg_date") %><br>
		<h3>좋아요 수 </h3><%= rs.getString("board_like") %><br> <i class="far fa-heart"></i>
		<input type="button" value="글 목록으로 돌아가" onclick="board_list()">
		
	<%} //end else
 
	 %>

    
    <h2>댓글</h2>
		<form action="reply_ok.jsp" method="post">
		<%= session.getAttribute("id") %>&nbsp; &nbsp;
		<input type="text" size="100%" name="replytext" id="replytext">
		<input type="hidden" name="board_pk" id="board_pk" value="<%=rs.getString("pk")%>">
		<input type="hidden" name="user_reply_pk" id="user_reply_pk" value="<%= session.getAttribute("id") %>">		
		<input type="submit" value="댓글 작성">
		</form>
		
	<%
	} //end rs.next
	conn.close();
    }catch(Exception e){
        out.println("데이터베이스에 문제가 있습니다.");
        out.println(e.getMessage());
        e.getStackTrace();
    }}	
    %>
    
    <%
	Connection conn = null;
	Statement stmt = null;
	int count=0;


	try{
	    Class.forName("com.mysql.jdbc.Driver");
	    String dbURL = "jdbc:mysql://localhost:3306/sandoll_board?useSSL=false";
		String dbID = "root";
		String dbPassword = "1234";
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
	    stmt = conn.createStatement();
	
	    String pk = request.getParameter("pk");
	    ResultSet countrs = stmt.executeQuery("select count(*) from board_reply where board_reply_delete = 0 AND board_pk = "+pk); 
        
        if(countrs.next()){
            count = countrs.getInt(1);
        }
        
        String sql = "select * from board_reply where board_pk ="+pk;
        ResultSet rs = stmt.executeQuery(sql);

	%>
	<br><br>
	글 목록 <br><br><br><br>
	<table>
	<tr>
	<td> 댓글 번호 </td>
	<td> 댓글 제목 </td>
	<td> 글쓴이 </td>
	<td> 날짜 </td>
	</tr>
	<tr>
	<%
	while(rs.next()){
		
		int board_reply_delete = Integer.parseInt(rs.getString("board_reply_delete"));
		
		if(board_reply_delete!=1){
			
			if(rs.getString("user_reply_pk").equals("admin")){
				out.print("<tr>");
				out.print("<td style='color:red'>"+ count + "</td>");
				out.print("<td style='color:red'>" + rs.getString("replytext") + "</td>");
				out.print("<td style='color:red'>" + rs.getString("user_reply_pk") + "</td>");
				out.print("<td style='color:red'>" + rs.getString("reg_date") + "</td>");
				out.print("</tr>");
			}
			
			else{
				out.print("<tr>");
				out.print("<td>"+ count + "</td>");
				out.print("<td>" + rs.getString("replytext") + "</td>");
				out.print("<td>" + rs.getString("user_reply_pk") + "</td>");
				out.print("<td>" + rs.getString("reg_date") + "</td>");
				out.print("</tr>");
			}
			
			count=count-1;
		}
		
		
	}
	%>
	</table>
	
	
	
	<%
	
		if(count > 0){
			
		}
	
	      conn.close();
	    }catch(Exception e){
	        out.println("데이터베이스에 문제가 있습니다.");
	        out.println(e.getMessage());
	        e.getStackTrace();
	    }
	%> 
    </body>
    </html>