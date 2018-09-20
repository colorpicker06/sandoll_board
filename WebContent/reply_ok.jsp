<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 	<%@ page import = "reply.ReplyDAO" %>
 	<%@ page import = "java.io.PrintWriter" %>
 	<% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id = "reply" class="reply.Reply" scope="page"/>
    <jsp:setProperty name = "reply" property="replytext"/>
    <jsp:setProperty name = "reply" property="board_pk"/>
	<jsp:setProperty name = "reply" property="user_reply_pk"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
    function goToDetail(pk){
        location.href="detail.jsp?pk="+pk; //페이지 이동
    }
</script>
<%
	ReplyDAO replyDAO = new ReplyDAO();
	int result = replyDAO.write(reply);
	if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('실패')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('작성되었습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	//out.print(request.getParameter("pk"));
%>
</body>
</html>