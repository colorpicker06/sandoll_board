<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../menu.jsp" %>
마이페이지 
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
		
		
		
		
		
		
		
		
		
	}




%>
</body>
</html>