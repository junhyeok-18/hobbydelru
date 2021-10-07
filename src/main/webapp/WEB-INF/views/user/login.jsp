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
	<form id="login_form" action="/user/login_action" method="post" enctype="multipart/form-data">
	<div class="login_div">
		<div class="login_logo_div">
			<img src="/resources/image/logo.png" style="width: 100%;">
		</div>
		<div class="login_id_pw_div">
			<table class="login_table">
				<tr>
					<td></td>
					<td colspan="2">
						<input type="checkbox" name="auto_login" id="auto_login" value="no_auto_login">
						<label for="auto_login">자동로그인</label>
					</td>
				</tr>
				<tr>
					<td class="login_id_pw">
						아이디
					</td>
					<td>
						<input class="login_input" type="text" name="kn_id" id="kn_id" onkeyup="enterkey(login_action)" tabindex="1">
					</td>
					<td rowspan="2">
						<button type="button" class="login_button" name="login_button" id="login_button" tabindex="3">로그인</button>
					</td>
				</tr>
				<tr>
					<td class="login_id_pw">
						비밀번호
					</td>
					<td>
						<input class="login_input" type="password" name="kn_pw" id="kn_pw" onkeyup="enterkey(login_action)" tabindex="2" maxlength="20">
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	<div class="login_find_pw_div">
		· 회원이아니신가요?<button type="button" class="bottom_button" name="join_button" id="join_button">회원가입</button>
		· 관리사용자이신가요?<button type="button" class="bottom_button" name="admin_login_button" id="admin_login_button">관리사용자 로그인</button>
	</div>
	</form>
	
<script type="text/javascript">
	$(document).ready(function() {
		//로그인 버튼 클릭 이벤트
		$("#login_button").on("click", function() {
			login_action();	
		});
		
		//회원가입 버튼 클릭 이벤트
		$("#join_button").on("click", function() {
			location.href = "/join";
		});
		
		//관리사용자 로그인 버튼 클릭 이벤트
		$("#admin_login_button").on("click", function() {
			location.href = "/admin";
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
				url : "/user/login_action",
				type : "post",
				enctype : "multipart/form-data",
				processData: false,
	            contentType: false,
				data :  data,
				success : function(data) {
					if($.trim(data) == 1) {
						location.href = "/main";
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