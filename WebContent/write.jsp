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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<title>Insert title here</title>
</head>
<style>
h2{
	display:inline-block;
}

input { 
	display:
}

.col-xs-7{
	margin-left:18%;
}

label{
	display: inline-block;
}

body{
	font-family: 'Nanum Gothic', sans-serif;
}

</style>
<body>
<center>

<%@ include file="../menu.jsp" %>
<h1>글 쓰기</h1>
<% 

	if(session.getAttribute("id")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용해 주세요. ')");
		script.println("location.href = 'login.jsp'; ");
		script.println("</script>");
	}

	
		String userid = (String)session.getAttribute("id");
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
		    
		    ResultSet countrs = stmt.executeQuery("select count(*) from font_family"); 
	        
	        if(countrs.next()){
	            count = countrs.getInt(1);
	        }
	        
	        String sql = "select * from font_family";
	        ResultSet rs = stmt.executeQuery(sql);
	        
	        int num[] = new int[3];
	        int pk[] = new int[3];
	        
	        for(int i=0; i<num.length; i++){
	        	num[i]=(int)(Math.random()*count)+1;
	        	
	        	for(int j=0; j<i; j++){
	        		if(num[i]==num[j]){
	        			i--;
	        			break;
	        		}
	        	}
	        } //랜덤 숫자 뽑기        
	    	
	        while(rs.next()){ 
	       	
	        	for(int i=0; i<num.length; i++){
		    		if(num[i]==rs.getInt("pk")){
		    			out.print("<h2>"+rs.getString("font_family_name")+"</h2> &nbsp; &nbsp; &nbsp;");
		    			//out.print("<h2>"+rs.getString("pk")+"</h2> &nbsp; &nbsp; &nbsp;");
		    			pk[i]=rs.getInt("pk");
		    		}
		    	}
	        } // end of rs.next
		%>
			<div id="write">
				<form method="post" action="write_okk.jsp">
					<div class="col-xs-7">
						<label>제목 :</label><input type="text" class="form-control" placeholder="제목" id="title" name="title"><br>
						<label>내용 : </label> <textarea class="form-control" rows="5" id="content" name="content"></textarea><br>
						<input type="hidden" name="writer" id="writer" value="<%= userid %>">
						<input type="hidden" name="pk1" id="pk1" value="<%= pk[0] %>">
						<input type="hidden" name="pk2" id="pk2" value="<%= pk[1] %>">
						<input type="hidden" name="pk3" id="pk3" value="<%= pk[2] %>">
						<input type="submit" class="form-control" value="작성완료">
					</div>
				</form>
			</div>
			
	    	<%conn.close();
	        }catch(Exception e){
	            out.println("데이터베이스에 문제가 있습니다.");
	            out.println(e.getMessage());
	            e.getStackTrace();
	        }
%>
</center>
</body>
</html>