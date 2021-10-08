<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>하비델루</title>
	
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
	<input type="text"/>
	
<script type="text/javascript">
	var id_check = 1;
	
	$(document).ready(function() {
		//취소 버튼 클릭 이벤트
		$("#back_button").on("click", function() {
			location.href = "/";
		});
		
		//아이디 중복확인 버튼 클릭 이벤트
		$("#id_check_button").on("click", function() {
			id_check_action();
		});
		
		//회원가입 버튼 클릭 이벤트
		$("#join_button").on("click", function() {
			join_action();
		});
	});
	
	//아이디 중복확인
	function id_check_action() {
		if($.trim($("#kn_id").val()).length < 1) {
			alert("아이디를 입력해주세요.");
			$("#kn_id").focus();
			return false;
		} else {
			$.ajax({
				url : "/user/id_check_action",
				type : "post",
				enctype : "multipart/form-data",
				data :  {kn_id : $("#kn_id").val()},
				success : function(data) {
					if($.trim(data) == 0) {
						alert("사용이 가능한 아이디 입니다.")
						id_check = 0;
						$("#kn_pw").focus();
					} else {
						alert("사용이 불가능한 아이디 입니다.");
						id_check = 0;
						$("#kn_id").focus();
						return false;
					}
				},
				error : function(data) {
					alert("다시 시도해주시기 바랍니다.");
				}
			});
		}
	}	
	
	//아이디 텍스트 창 입력 시 변수 변경
	function id_check_var() {
		id_check = 1;
	}
	
	//회원가입 액션
	function join_action() {
		if($.trim($("#kn_code").val()).length < 5) {
			alert("사번을 입력해주세요.");
			$("#kn_code").focus();
			return false;
		} else if($.trim($("#kn_id").val()).length < 1) {
			alert("아이디를 입력해주세요.");
			$("#kn_id").focus();
			return false;
		} else if(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{12,}$/.test($.trim($("#kn_pw").val())) == false) {
			alert("영문 숫자 특수문자(!, @, $, %, &, * 만 허용)를 혼용하여 12자 이상을 입력해주세요");
			$("#kn_pw").focus();
			return false;
		} else if($.trim($("#kn_name").val()).length < 1) {
			alert("이름을 입력해주세요.");
			$("#kn_name").focus();
			return false;
		} else if($.trim($("#kn_address").val()).length < 1) {
			alert("주소지를 입력해주세요.");
			$("#kn_address").focus();
			return false;
		} else if($.trim($("#kn_join_date").val()).length < 8) {
			alert("입사일을 입력해주세요.");
			$("#kn_join_date").focus();
			return false;
		} else if($.trim($("#kn_birthday").val()).length < 8) {
			alert("생년월일을 입력해주세요.");
			$("#kn_birthday").focus();
			return false;
		} else if($.trim($("#kn_phone1").val()).length < 3) {
			alert("전화번호를 입력해주세요.");
			$("#kn_phone1").focus();
			return false;
		} else if($.trim($("#kn_phone2").val()).length < 4) {
			alert("전화번호를 입력해주세요.");
			$("#kn_phone2").focus();
			return false;
		} else if($.trim($("#kn_phone3").val()).length < 4) {
			alert("전화번호를 입력해주세요.");
			$("#kn_phone3").focus();
			return false;
		} else if(id_check == 1) {
			alert("아이디 중복확인을 해주세요.");
			$("#kn_id").focus();
			return false;
		} else {
			var form = $('#join_form')[0];
	        var data = new FormData(form);
			$.ajax({
				url : "/user/join_action",
				type : "post",
				enctype : "multipart/form-data",
				processData: false,
	            contentType: false,
				data :  data,
				success : function(data) {
					alert("회원가입에 성공하셨습니다.");
					location.href = "/";
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