<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script type="text/javascript">
    function goToDetail(pk){
        location.href="detail.jsp?pk="+pk; //페이지 이동
    }
</script>
<body>
<%@ include file="../menu.jsp" %>
<%
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
	
	    ResultSet countrs = stmt.executeQuery("select count(*) from board;"); 
        
        if(countrs.next()){
            count = countrs.getInt(1);
        }
        
        ResultSet rs = stmt.executeQuery("select * from board order by pk desc;");

%>
글 목록 <br><br><br><br>
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
while(rs.next()){
	out.print("<tr>");
	out.print("<td onClick='goToDetail("+rs.getString("pk")+")'>"+ count + "</td>");
	out.print("<td onClick='goToDetail("+rs.getString("pk")+")'>" + rs.getString("title") + "</td>");
	out.print("<td onClick='goToDetail("+rs.getString("pk")+")'>" + rs.getString("writer") + "</td>");
	out.print("<td onClick='goToDetail("+rs.getString("pk")+")'>" + rs.getString("reg_date") + "</td>");
	out.print("<td onClick='goToDetail("+rs.getString("pk")+")'>" + rs.getString("board_like") + "</td>");
	
	count=count-1;
}
%>
</tr>
</table>



<%
      conn.close();
    }catch(Exception e){
        out.println("데이터베이스에 문제가 있습니다.");
        out.println(e.getMessage());
        e.getStackTrace();
    }
%> 
</body>
</html>