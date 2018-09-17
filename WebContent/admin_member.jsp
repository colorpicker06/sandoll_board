<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
        
        ResultSet rs = stmt.executeQuery("select * from user order by pk desc;");

%>
회원 관리 <br><br><br><br>
<table>
<tr>
<td> 번호 </td>
<td> 아이디 </td>
<td> 비밀번호 </td>
<td> 이름 </td>
<td> 닉네임 </td>
<td> 가입일 </td>
<td> 현재상태 </td>
</tr>
<tr>
<%
while(rs.next()){
	
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