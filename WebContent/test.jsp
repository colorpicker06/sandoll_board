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
<%
Connection conn = null;
Statement stmt = null;


try{
    Class.forName("com.mysql.jdbc.Driver");
    String dbURL = "jdbc:mysql://localhost:3306/sandoll_board";
	String dbID = "root";
	String dbPassword = "1234";
	conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
    stmt = conn.createStatement();

    String sql = "select * from board order by pk desc;";
    ResultSet rs = stmt.executeQuery(sql);
    
    while(rs.next()){
    	out.print(rs.getString("title"));
    }
		
}catch(Exception e){
	e.printStackTrace();
}

%>
</body>
</html>