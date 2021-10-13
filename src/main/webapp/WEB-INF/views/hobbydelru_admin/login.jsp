<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hobbydelru 서비스 관리자</title>
	
	<!-- favicon -->
	<link rel="apple-touch-icon" sizes="57x57" href="/resources/favicon/apple-icon-57x57.png">
	<link rel="apple-touch-icon" sizes="60x60" href="/resources/favicon/apple-icon-60x60.png">
	<link rel="apple-touch-icon" sizes="72x72" href="/resources/favicon/apple-icon-72x72.png">
	<link rel="apple-touch-icon" sizes="76x76" href="/resources/favicon/apple-icon-76x76.png">
	<link rel="apple-touch-icon" sizes="114x114" href="/resources/favicon/apple-icon-114x114.png">
	<link rel="apple-touch-icon" sizes="120x120" href="/resources/favicon/apple-icon-120x120.png">
	<link rel="apple-touch-icon" sizes="144x144" href="/resources/favicon/apple-icon-144x144.png">
	<link rel="apple-touch-icon" sizes="152x152" href="/resources/favicon/apple-icon-152x152.png">
	<link rel="apple-touch-icon" sizes="180x180" href="/resources/favicon/apple-icon-180x180.png">
	<link rel="icon" type="image/png" sizes="192x192"  href="/resources/favicon/android-icon-192x192.png">
	<link rel="icon" type="image/png" sizes="32x32" href="/resources/favicon/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="96x96" href="/resources/favicon/favicon-96x96.png">
	<link rel="icon" type="image/png" sizes="16x16" href="/resources/favicon/favicon-16x16.png">
	<link rel="manifest" href="/resources/favicon/manifest.json">
	<meta name="msapplication-TileColor" content="#ffffff">
	<meta name="msapplication-TileImage" content="/resources/favicon/ms-icon-144x144.png">
	<meta name="theme-color" content="#ffffff">
	
	<!-- css -->
	<link rel="stylesheet" href="/resources/css/style.css" type="text/css">
	<link rel="stylesheet" href="/resources/css/jquery.alerts.css" type="text/css">
	
	<!-- javascript -->
	<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
	<script type="text/JavaScript" src="/resources/js/javascript.js"></script>
	<script type="text/JavaScript" src="/resources/js/jquery.alerts.js"></script>
</head>
<body>
	관리사용자 로그인
	<form id="login_form">
		<table>
			<tr>
				<td colspan="2">
					<input type="checkbox" name="auto_login" id="auto_login" value="no_auto_login">
					<label for="auto_login">자동로그인</label>
				</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="kn_id" id="kn_id">
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" name="kn_pw" id="kn_pw">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" name="login_button" id="login_button">로그인</button>
				</td>
			</tr>
		</table>
	</form>
	
<script type="text/javascript">
	$(document).ready(function() {
		//로그인 버튼 클릭 이벤트
		$("#login_button").on("click", function() {
			login_action();	
		});
	});
	
	//로그인 액션
	function login_action() {
		if($.trim($("#kn_id").val()).length < 1) {
			alert("아이디를 입력해주세요.");
			$("#kn_id").focus();
			return false;
		} else if($.trim($("#kn_pw").val()).length < 1) {
			alert("비밀번호를 입력해주세요.");
			$("#kn_pw").focus();
			return false;
		} else {
			if($("input:checkbox[name='auto_login']").is(":checked")) {
				document.getElementById("auto_login").value = "auto_login";
			} else {}
			var form = $('#login_form')[0];
	        var data = new FormData(form);
			$.ajax({
				url : "/admin/login_action",
				type : "post",
				enctype : "multipart/form-data",
				processData: false,
	            contentType: false,
				data :  data,
				success : function(data) {
					if($.trim(data) == 1) {
						location.href = "/admin/main";
					} else {
						alert("아이디 및 비밀번호를 다시 한번 확인해주시기 바랍니다.");
					}
				},
				error : function(data) {
					alert("다시 시도해주시기 바랍니다.");
				}
			});
		}
	}
</script>
</body>
</html>