<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>(주)나이츠넷 문서 중앙화 시스템템템템템템템</title>
	
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
	<form id="join_form">
	<div class="join_div">
		<table class="join_table" border="1">
			<tr>
				<td>사번</td>
				<td>
					<input type="text" name="kn_code" id="kn_code" maxlength="5" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
				</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="kn_id" id="kn_id" maxlength="15" autocomplete="off" onkeyup="id_check_var()" oninput="this.value = this.value.replace(/[^a-z0-9.]/g, '').replace(/(\..*)\./g, '$1');">
					<button type="button" name="id_check_button" id="id_check_button">중복확인</button>
				</td>
			</tr>
			<tr>  
				<td>비밀번호</td>
				<td>
					<input type="password" name="kn_pw" id="kn_pw" maxlength="25" autocomplete="off" oninput="this.value = this.value.replace(/ /g, '').replace(/(\..*)\./g, '$1');">
				</td>
			</tr>
			<tr>
				<td>성명</td>
				<td>
					<input type="text" name="kn_name" id="kn_name" maxlength="30" autocomplete="off" oninput="this.value = this.value.replace(/[a-z0-9]|[ \[\]{}()?|`~!@#$%^&*-_+=,.;:\x27\x22]/g, '').replace(/(\..*)\./g, '$1');">
				</td>
			</tr>
			<tr>
				<td>주소지</td>
				<td>
					<input type="text" name="kn_address" id="kn_address" autocomplete="off" style="width: 80%;">
				</td>
			</tr>
			<tr>
				<td>입사일</td>
				<td>
					<input type="text" name="kn_join_date" id="kn_join_date" maxlength="8" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
				</td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td>
					<input type="text" name="kn_birthday" id="kn_birthday" maxlength="8" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
				</td>
			</tr>
			<tr>
				<td>통신사</td>
				<td>
					<select name="kn_carrier" id="kn_carrier">
						<option value="0" selected="selected">SKT</option>
						<option value="1">KT</option>
						<option value="2">LG</option>
						<option value="3">별점</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>휴대폰번호</td>
				<td>
					<input type="text" name="kn_phone1" id="kn_phone1" maxlength="3" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
					<input type="text" name="kn_phone2" id="kn_phone2" maxlength="4" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
					<input type="text" name="kn_phone3" id="kn_phone3" maxlength="4" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
				</td>
			</tr>
			<tr>
				<td>부서</td>
				<td>
					<select name="kn_department" id="kn_department">
						<c:forEach var="kn_department" items="${kn_department}">
							<option value="${kn_department.kn_department_code}">${kn_department.kn_department_name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>직급</td>
				<td>
					<select name="kn_rank" id="kn_rank">
						<c:forEach var="kn_rank" items="${kn_rank}">
							<option value="${kn_rank.kn_rank_code}">${kn_rank.kn_rank_name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>직책</td>
				<td>
					<select name="kn_position" id="kn_position">
						<c:forEach var="kn_position" items="${kn_position}">
							<option value="${kn_position.kn_position_code}">${kn_position.kn_position_name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" name="back_button" id="back_button">취소</button>
					<button type="button" name="join_button" id="join_button">회원가입</button>
				</td>
			</tr>
		</table>
	</div>
	</form>
	
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