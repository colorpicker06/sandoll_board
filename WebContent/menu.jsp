<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/menu.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<title>Insert title here</title>
<style>
*{

	margin:0;
	padding:0;
}
img{
	padding-top:3%;
	margin-bottom:0;
	margin-left: auto;
	margin-right: auto;
	display: block;
}

.header{
	background-color: #06acff;
	height:180px;
	weight:100%;
}

body{
font-family: 'Nanum Gothic', sans-serif;
font-size: 15px;
}

a{
	font-size: 15px;
}
body {
  margin: 0;
  font-family: Arial, Helvetica, sans-serif;
}

.topnav {
  overflow: hidden;
  background-color: #333;
}

.topnav a {
  float: left;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 20px;
  text-decoration: none;
  font-size: 15px;
}

.topnav a:hover {
  background-color: #ddd;
  color: white;
}

.topnav-right {
  float: right;
  background-color: white;
}

span.menu{
float:left;
margin:0.3%;
}



</style>
</head>
<body>
<a href="board_list.jsp"><div class="header"><img src = "image/sandoll_cloud.png" width="15%"/></div></a>
		
        

<div class="topnav">
	<span class="menu" style= "color:white; font-size:30px; cursor:pointer" onclick="openNav()">&nbsp; &nbsp;&#9776;&nbsp; &nbsp;</span>
  <a href="write.jsp">글쓰기 </a>
  <a href="board_list.jsp">글목록</a>
</div>
       
        
        <div id="mySidenav" class="sidenav">
		  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		  
		  <%if(session.getAttribute("id")==null){ %>
  		  <a href="login.jsp"><i class="far fa-user-circle"></i>&nbsp;로그인</a>
		  <a href="signin.jsp"><i class="fas fa-users"></i>&nbsp;회원가입</a>
		  <%
		  }
  
		  else if(session.getAttribute("id").equals("admin")){%>
			  <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i>&nbsp;로그아웃</a>
			  <a href="admin_member.jsp"><i class="fas fa-users-cog"></i>&nbsp;회원관리</a>
			  <a href="admin_board.jsp"><i class="fas fa-clipboard-list"></i>&nbsp;글 목록 관리</a>
		  <%
		  }
		 
		  else{
		  %>
		  <i class="far fa-user-circle fa-2x" style="margin-left:30px"></i>
          <h5><%= session.getAttribute("id") %></h5><br>
		  <a href="info_change.jsp"><i class="fas fa-user-edit"></i>&nbsp;개인정보 수정</a>
		  <a href="mypage.jsp"><i class="fas fa-user-tag"></i>&nbsp;마이페이지</a>
		  <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i>&nbsp;로그아웃</a>
		  <%
		  }
		  %>
		  
		  
</div>

<script>
function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
    document.getElementById("main").style.marginLeft = "250px";
    document.body.style.backgroundColor = "rgba(0,0,0,0.4)";
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("main").style.marginLeft= "0";
    document.body.style.backgroundColor = "white";
}
</script>
</body>
</html>