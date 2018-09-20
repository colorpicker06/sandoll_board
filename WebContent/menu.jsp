<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
img{
	margin-top:2%;
	margin-bottom:1%;
}

ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #333;
}

li {
    float: left;
}

li a {
    display: block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

li a:hover:not(.active) {
    background-color: #111;
}

.active {
    background-color: #4CAF50;
}
</style>
</head>
<body>
<img src = "image/sandoll.png" width="10%">
<ul>
  <li><a href="write.jsp">글쓰기</a></li>
  <li><a href="board_list.jsp">글목록</a></li>
  
  <%
  if(session.getAttribute("id")==null){
  %>
  <li style="float:right"><a class="active" href="login.jsp">로그인</a></li>
  <li style="float:right"><a class="active" href="signin.jsp">회원가입</a></li>
  <%
  }
  
  else if(session.getAttribute("id").equals("admin")){
	  %>
	  <li style="float:right"><a class="active" href="logout.jsp">로그아웃</a></li>
	  <li style="float:right"><a class="active" href="admin_member.jsp">회원관리</a></li>
	  <li style="float:right"><a class="active" href="admin_board.jsp">글 목록 관리</a></li>
  <%
  }
 
  else{
  %>
  <li style="float:right"><a class="active" href="info_change.jsp">개인정보 수정</a></li>
  <li style="float:right"><a class="active" href="mypage.jsp">마이페이지</a></li>
  <li style="float:right"><a class="active" href="logout.jsp">로그아웃</a></li>
  <%
  }
  %>
</ul>
</body>
</html>