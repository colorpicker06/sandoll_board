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
<title>Insert title here</title>
</head>
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
<body>
<script type="text/javascript">
    function goToDetail(pk){
        location.href="detail.jsp?pk="+pk; //페이지 이동
    }
</script>
<%@ include file="../menu.jsp" %>
<h1>마이페이지 </h1>
<% 

	if(session.getAttribute("id")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("out.println('반갑습니다.')");
		script.println("</script>");
	}

	else{
		String userid = (String)session.getAttribute("id");
		out.println(userid+"님 반갑습니다.");
		
		Connection conn = null;
		Statement stmt = null;
		int count=0;


		try{
		    Class.forName("com.mysql.jdbc.Driver");
		    String dbURL = "jdbc:mysql://localhost:3306/sandoll_board";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		    stmt = conn.createStatement();
	        
	        String sql = "select * from board where writer ="+"'"+userid+"'";
	        ResultSet rs = stmt.executeQuery(sql);

	%>
	<br><br>
	<h2>내 글 목록</h2> <br><br>
	<table>
	<tr>
	<td> 글 번호 </td>
	<td> 글 제목 </td>
	<td> 글 내 </td>
	<td> 날짜 </td>
	<td> 좋아요 </td>
	</tr>
	<tr>
	<%
	while(rs.next()){
		
		int board_delete = Integer.parseInt(rs.getString("board_delete"));
		
		if(board_delete!=1){
			out.print("<tr>");
			out.print("<td onClick='goToDetail("+rs.getString("pk")+")'>"+ count + "</td>");
			out.print("<td onClick='goToDetail("+rs.getString("pk")+")'>" + rs.getString("title") + "</td>");
			out.print("<td onClick='goToDetail("+rs.getString("pk")+")'>" + rs.getString("content") + "</td>");
			out.print("<td onClick='goToDetail("+rs.getString("pk")+")'>" + rs.getString("reg_date") + "</td>");
			out.print("<td onClick='goToDetail("+rs.getString("pk")+")'>" + rs.getString("board_like") + "</td>");
			out.print("</tr>");
		}	
	}
	%>
	</table>
	
	<%
	      conn.close();
	    }catch(Exception e){
	        out.println("데이터베이스에 문제가 있습니다.");
	        out.println(e.getMessage());
	        e.getStackTrace();
	    }
	}
	%> 

</body>
</html>