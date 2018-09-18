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



<%@ include file="../menu.jsp" %>
<%
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

글 상세보기 <br><br><br><br>

	<%
	while(rs.next()){ 
	
		//if(session.getAttribute("id")!=null){
		
			if(session.getAttribute("id").equals(rs.getString("writer"))){%>
			<form method="post" action = "board_change.jsp" name="form1" id="form1">
			<input type="hidden" name="pk" id = "pk" value="<%=rs.getString("pk")%>"></input><br>
			<h3>글 제목 </h3> <input type="text" name="title" id = "title" value="<%=rs.getString("title")%>"></input><br>
			<h3>글 내용 </h3><textarea name="content" id = "content" ><%=rs.getString("content")%></textarea><br>
			<h3>글쓴이 </h3><%= rs.getString("writer") %><br>
			<h3>작성일 </h3><%= rs.getString("reg_date") %><br>
			<h3>좋아요 수 </h3><%= rs.getString("board_like") %><br>
			 
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
		<h3>좋아요 수 </h3><%= rs.getString("board_like") %><br> 
		<input type="button" value="글 목록으로 돌아가" onclick="board_list()">
		
	<%} //end else
 
	} //end rs.next

	
	
   conn.close();
    }catch(Exception e){
        out.println("데이터베이스에 문제가 있습니다.");
        out.println(e.getMessage());
        e.getStackTrace();
    }
%> 
</body>
</html>