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
	사번 : ${help.kn_code} <br>
	아이디 : ${help.kn_id} <br>
	이름 : ${help.kn_name} <br>
	<button type="button" name="logout_button" id="logout_button">로그아웃</button>
	
	파일 총 개수 : ${kn_file_all_count} <br>
	
	<table border="1">
		<tr>
			<td>사번</td>
			<td>아이디</td>
			<td>이름</td>
			<td>주소</td>
			<td>입사일</td>
			<td>생년월일</td>
			<td>통신사</td>
			<td>전화번호</td>
			<td>부서</td>
			<td>직급</td>
			<td>직책</td>
		</tr>
	<c:forEach var="kn_employee_select" items="${kn_employee_select}">
		<tr>
			<td>${kn_employee_select.kn_code}</td>
			<td>${kn_employee_select.kn_id}</td>
			<td>${kn_employee_select.kn_name}</td>
			<td>${kn_employee_select.kn_address}</td>
			<td>${kn_employee_select.kn_join_date}</td>
			<td>${kn_employee_select.kn_birthday}</td>
			<td>
				<c:if test="${kn_employee_select.kn_carrier == 0}">SKT</c:if>
				<c:if test="${kn_employee_select.kn_carrier == 1}">KT</c:if>
				<c:if test="${kn_employee_select.kn_carrier == 2}">LG</c:if>
				<c:if test="${kn_employee_select.kn_carrier == 3}">별점</c:if>
			</td>
			<td>${kn_employee_select.kn_phone1}-${kn_employee_select.kn_phone2}-${kn_employee_select.kn_phone3}</td>
			<td>${kn_employee_select.kn_department}</td>
			<td>${kn_employee_select.kn_rank}</td>
			<td>${kn_employee_select.kn_position}</td>
		</tr>
	</c:forEach>
	</table>
	<div>
	  <ul>
	    <c:if test="${pageMaker.prev}">
	    	<li><a href="/help/main${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
	    </c:if> 
	
	    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
	    	<li><a href="/help/main${pageMaker.makeQuery(idx)}">${idx}</a></li>
	    </c:forEach>
	
	    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
	    	<li><a href="/help/main${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
	    </c:if> 
	  </ul>
	</div>
	
<script type="text/javascript">
	$(document).ready(function() {
		//로그아웃 버튼 클릭 이벤트
		$("#logout_button").on("click", function() {
			location.href = "/help/logout"
		});
		
		//업로드 버튼 클릭 이벤트
		$("#upload_button").on("click", function() {
			file_upload_action();
		});
	});
	
	//파일업로드 액션
	function file_upload_action() {
		if($.trim($("#kn_file").val()).length < 1) {
			alert("업로드할 파일을 올려주세요.");
			return false;
		} else {
			var form = $('#upload_form')[0];
	        var data = new FormData(form);
			$.ajax({
				url : "/user/upload_action",
				type : "post",
				enctype : "multipart/form-data",
				processData: false,
	            contentType: false,
				data :  data,
				success : function(data) {
					if($.trim(data) == 1) {
						location.href = "/main";
					} else {
						alert("다시 시도해주시기 바랍니다.");
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