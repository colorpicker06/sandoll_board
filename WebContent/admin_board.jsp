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
<title>Insert title here</title>
</head>
<body>
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
<%@ include file="../menu.jsp" %>
<%
//3232235997L
	String userIP = InetAddress.getLocalHost().getHostAddress();
	out.print(userIP);
	if(!InetAddress.getLocalHost().getHostAddress().equals("192.168.1.221")){ //192.168.0.22 sandollguest 192.168.1.221
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자페이지에 접속 할 수 있는 ip가 아닙니다.')");
		script.println("location.href=('index.jsp')");
		script.println("</script>");
	}
	//out.print(.getAttribute("id"));

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
        
        ResultSet rs = stmt.executeQuery("select * from board order by pk desc;");

%>
회원 관리 <br><br><br><br>
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
while(rs.next()){ %>
	<tr>
	<form action='admin_board_change.jsp' method='post'>
	<td><%=rs.getString("pk") %></td>
	<td><input type="text" name="title" id = "title" value="<%=rs.getString("title")%>"></input></td>
	<td><input type="text" name="writer" id = "writer" value="<%=rs.getString("writer")%>"></input></td>
	<td><input type="text" name="reg_date" id = "reg_date" value="<%=rs.getString("reg_date")%>"></input></td>
	<td><input type="number" name="board_like" id = "board_like" value="<%=rs.getString("board_like")%>"></input></td>
	<td>
	<input type="hidden" name="pk" id="pk" value="<%=rs.getString("pk") %>">	
	<select name="board_delete" id="board_delete">
		<option value=0 <% if(rs.getInt("board_delete")==0){%>selected<% } %>>일반 게시물</option>
		<option value=1 <% if(rs.getInt("board_delete")==1){%>selected<% } %>>삭제 게시물</option>
	</select>
	<input type="submit" value="수정">	
	</td>
	</form>	
	</tr>
<%}
%>
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