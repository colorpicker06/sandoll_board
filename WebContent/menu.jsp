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
	margin-top:2%;
	margin-bottom:0;
	margin-left: auto;
	margin-right: auto;
	display: block;
}

.header{
	background-color: #ff584f;
}

body{
font-family: 'Nanum Gothic', sans-serif;
font-size: 15px;
}

a{
	font-size: 15px;
}


</style>
</head>
<body>
<a href="index.jsp"><div class="header" width="100%" height="50px"><img src = "image/logo2.png" width="10%" height="30%"></div></a>
		<span onclick="openNav()">
        <div class="ham-btn">
            <span class="item-1 ham-dash"></span>
            <span class="item-2 ham-dash"></span>
            <span class="item-3 ham-dash"></span>
        </div>
        </span>
        
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
		  <a href="write.jsp"><i class="fas fa-edit"></i>&nbsp;글쓰기 </a>
		  <a href="board_list.jsp"><i class="fas fa-clipboard-list"></i>&nbsp;글목록</a>
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