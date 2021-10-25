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
			<span style="font-size: 50px;">하비델루 관리자 로그인 화면</span> <br>
			아이디<input type="text" name="admin_id" id="admin_id" onkeypress="if(event.keyCode == 13) admin_logincheck()"><br>
			비밀번호<input type="password" name="admin_pw" id="admin_pw" onkeypress="if(event.keyCode == 13) admin_logincheck()"><br>
			<label for="id_save">아이디 저장</label><input type="checkbox" id="id_save"/>
			<button type="button" name="admin_login_button" id="admin_login_button">로그인</button>
		</div>
	
		<script type="text/javascript">
			$(document).ready(function() {
				//로그인 버튼 클릭 이벤트
				$("#admin_login_button").on("click", function() {
					admin_logincheck();
				});
			});
			
			//하비델루 관리자 로그인 액션
			function admin_logincheck() {
				var admin_id = $.trim($("#admin_id").val());
				var admin_pw = $.trim($("#admin_pw").val()); 
				var id_save = $("#id_save:checked").val();
				
				if(admin_id.length < 1) {
					alert("아이디를 입력해주세요.");
					$("#admin_id").focus();
					return false;
				} else if(admin_pw.length < 1) {
					alert("비밀번호를 입력해주세요.");
					$("#admin_pw").focus();
					return false;
				} else {
					/*
				    * 아래는 localStorage를 활용한 아이디 기억을 사용하기 위함입니다.
				    * 아이디 저장 checkbox가 선택된 상태로 로그인 버튼을 클릭하면 
				    * 다음 login 페이지로 접속할 시 document.ready시점에 localStorage.getItem("id_save")
				    * 값이 '', null, 'N' 중에 없을 시에만 id input란에 값을 넣어주면 됩니다.
				    */
					if(id_save == "on") {
						localStorage.setItem("id_save", admin_id);
					} else {
						localStorage.setItem("id_save", "N");
					}
			        var data = {
			        		"admin_id": admin_id,
			        		"admin_pw": admin_pw
			        };
					$.ajax({
						type : "post",
						url : "/hobbydelru_admin/logincheck",
						contentType : "application/json",
						data :  JSON.stringify(data),
						success : function(result) {
							if($.trim(result) == 0) {
								alert("아이디 및 비밀번호를 다시 한번 확인해 주시기 바랍니다.");
								return false;
							} else if($.trim(result) == 9){
								alert("현재 통신이 불안정합니다.\n잠시후 다시 시도해 주시기 바랍니다.");
								return false;
							} else {
								location.href = "/hobbydelru_admin/main";
							}
						},
						error : function(jqXHR, status, error) {
							alert("알 수 없는 에러 [ " + error + " ]");
						}
					});
				}
			}
		</script>
	</body>
</html>