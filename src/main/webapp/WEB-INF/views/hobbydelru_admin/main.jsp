<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>HOBBYDELRU ADMIN</title>
		
		<!-- favicon -->
		<link rel="shortcut icon" type="image/x-icon" href="/resources/favicon/favicon.ico">
		
		<!-- css -->
		<link rel="stylesheet" type="text/css" href="/resources/css/hobbydelru_admin_style.css">
		
		<!-- javascript -->
		<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
		<script type="text/JavaScript" src="/resources/js/javascript.js" ></script>
		<script type="text/JavaScript" src="/resources/js/jquery.alerts.js" ></script>
	</head>
	<body>
		<div style="margin: auto;">
			<span style="font-size: 50px;">하비델루 관리자 메인</span>
		</div>
	
		<script type="text/javascript">
			$(document).ready(function() {
				//로그인 버튼 클릭 이벤트
				$("#admin_login_button").on("click", function() {
					admin_logincheck();
				});
			});
		</script>
	</body>
</html>