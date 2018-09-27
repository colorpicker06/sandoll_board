<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<title>Insert title here</title>
<style>
*{
	margin:0;
	padding:0;
}
img{
	margin-top:2%;
	margin-bottom:1%;
	margin-left: auto;
	margin-right: auto;
	display: block;
}

.header{
	background-color: #ff584f;
}

ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #f2f4f7;
}

li {
    float: left;
}

li a {
    display: block;
    color: black;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

li a:hover:not(.active) {
    background-color: #4286f4;
}

.active {
    background-color: #4286f4;
}
</style>
</head>
<body>
<div class="header" width="100%"><img src = "image/logo2.png" width="10%"></div>
<ul>
  <li><a href="write.jsp"><i class="fas fa-pen-fancy"></i></a></li>
  <li><a href="board_list.jsp"><i class="fas fa-clipboard-list"></i></a></li>
  
  <%
  if(session.getAttribute("id")==null){
  %>
  <li style="float:right"><a class="active" href="login.jsp"><i class="far fa-user-circle"></i></a></li>
  <li style="float:right"><a class="active" href="signin.jsp"><i class="fas fa-users"></i></a></li>
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