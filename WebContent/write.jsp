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
<script>
function chk_word(){
	var myform = document.forms['write'];
	
	var content = myform['content'].value;
	var pk1 = myform['pk1'].value;
	var pk2 = myform['pk2'].value;
	var pk3 = myform['pk3'].value;
	 
	 //alert(content+"pk1"+pk1+"pk2"+pk2+"pk3"+pk3);
	 
	 if (content.indexOf(pk1) != -1 && content.indexOf(pk2)!= -1 && content.indexOf(pk3)!= -1) {
		  return true;
	}
	 
	 else {
		 alert("모든 제시어가 포함되지 않았습니다. 다시 작성해보세요 :)");
		 return false;
	 }
}

</script>
<style>
h1, h2{
	display:inline-block;
}

input { 
	display: inline-block;
}

label{
	display: inline-block;
}

body{
	font-family: 'Nanum Gothic', sans-serif;
	display: inline-block;
}

img{
display: inline-block;
}

img.cha{
	display: inline-block;
	margin-top:-4%;
	margin-left:2%;
	margin-right:2%;
}

</style>
<body>
<%@ include file="../menu.jsp" %>
<center>
<img  src="image/img_6.png" style="width:100%;"/><br><br><br>

<img class="cha" src="image/doll.png" style="width:5%;"><h2>제시어</h2><img class="cha" src="image/doll.png" style="width:5%;"/><br><br>
<hr>
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
	        String word[] = new String[3];
	        
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
		    			out.print("<h1>"+rs.getString("font_family_name")+"</h1> &nbsp; &nbsp; &nbsp;");
		    			//out.print("<h2>"+rs.getString("pk")+"</h2> &nbsp; &nbsp; &nbsp;");
		    			word[i]=rs.getString("font_family_name").trim();
		    			//pk[i]=num[i];
		    		}
		    	}
	        } // end of rs.next
		%>
		<hr><br><br>
  				
				<form id = "write" class="form-inline" method="post" action="write_ok.jsp" onsubmit="return chk_word()">
				<div class="form-group">
						제목 :&nbsp;&nbsp;<input size="70" type="text" class="form-control" placeholder="제목" id="title" name="title"><br><br>
						내용 :&nbsp;&nbsp;<textarea class="form-control" rows="15" cols="100" id="content" name="content"></textarea><br><br>
						<input type="hidden" name="writer" id="writer" value="<%= userid %>">
						<input type="hidden" name="pk1" id="pk1" value="<%= word[0] %>">
						<input type="hidden" name="pk2" id="pk2" value="<%= word[1] %>">
						<input type="hidden" name="pk3" id="pk3" value="<%= word[2] %>">
						<input type="submit" class="form-control" value="작성완료">
					</div>
				</form>			
				<br><br><br>
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