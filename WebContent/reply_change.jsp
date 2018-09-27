<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "reply.ReplyDAO" %>
	<%@ page import = "java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id = "reply" class="reply.Reply" scope="page"/>
    <jsp:setProperty name = "reply" property="pk"/>
    <jsp:setProperty name = "reply" property="replytext"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	String pk = request.getParameter("pk");
	String replytext = request.getParameter("replytext");
	
	ReplyDAO replyDAO = new ReplyDAO();
	int result = replyDAO.reply_change(reply);
	if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('실패 ')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('댓글이 수정되었습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}

%>

</body>
</html>