<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js" type="text/javascript"></script>
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/foundation/5.0.3/css/foundation.min.css'>
  <link rel="stylesheet" href="css/style.css">
<title>Insert title here</title>
<style>
body{
font-family: 'Nanum Gothic', sans-serif;
}
</style>
</head>
<body>
<%@ include file="../menu.jsp" %>

<div id ="main">
 <ul class="orbit-ul" data-orbit data-options="pause_on_hover:false; timer_speed:2000;">
  <li class="orbit-item orbit-item-1"><div></div></li>
  <li class="orbit-item orbit-item-2"><div></div></li>
  <li class="orbit-item orbit-item-3"><div></div></li>
</ul>


<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='http://cdnjs.cloudflare.com/ajax/libs/foundation/5.0.3/js/foundation.min.js'></script>  

<script  src="js/index.js"></script>
</div>
</body>
</html>