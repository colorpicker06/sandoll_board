<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "reply.ReplyDAO" %>
    <%@ page import = "java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
	<jsp:useBean id = "reply" class="reply.Reply" scope="page"/>
    <jsp:setProperty name = "reply" property="pk"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	

	//out.print(request.getParameter("pk"));
	ReplyDAO replyDAO = new ReplyDAO();
	int result = replyDAO.reply_delete(reply);
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
		script.println("alert('삭제 되었습니다.')");
		script.println("location.href='board_list.jsp'");
		script.println("</script>");
	}
%>
</body>
</html>