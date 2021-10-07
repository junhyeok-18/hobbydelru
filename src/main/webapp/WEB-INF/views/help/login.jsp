<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>(주)나이츠넷 문서 중앙화 시스템</title>
	
	<!-- favicon -->
	<link rel="icon" href="/resources/favicon/favicon.ico" type="image/x-icon">
	
	<!-- css -->
	<link rel="stylesheet" href="/resources/css/style.css" type="text/css">
	<link rel="stylesheet" href="/resources/css/jquery.alerts.css" type="text/css">
	
	<!-- javascript -->
	<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
	<script type="text/JavaScript" src="/resources/js/javascript.js" ></script>
	<script type="text/JavaScript" src="/resources/js/jquery.alerts.js" ></script>
</head>
<body>
	관리자 로그인
	<form id="login_form">
		<table>
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
				url : "/help/login_action",
				type : "post",
				enctype : "multipart/form-data",
				processData: false,
	            contentType: false,
				data :  data,
				success : function(data) {
					if($.trim(data) == 1) {
						location.href = "/help/main";
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