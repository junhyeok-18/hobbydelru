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
	<link rel="stylesheet" href="/resources/css/*" type="text/css">
	
	<!-- javascript -->
	<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
	<script type="text/JavaScript" src="/resources/js/*" ></script>
</head>
<body>
	사번 : ${admin.kn_code} <br>
	아이디 : ${admin.kn_id} <br>
	이름 : ${admin.kn_name} <br>
	<button type="button" name="logout_button" id="logout_button">로그아웃</button>
	
	<button type="button" name="reset_button" id="reset_button">초기화</button>
	
	<select name="searchType" id="searchType" onchange="searchtype_click(this.value)">
		<option value="kn_name" <c:out value="${scri.searchType eq 'kn_name' ? 'selected' : 'selected'}"/>>이름</option>
		<option value="kn_id" <c:out value="${scri.searchType eq 'kn_id' ? 'selected' : ''}"/>>아이디</option>
		<option value="kn_department" <c:out value="${scri.searchType eq 'kn_department' ? 'selected' : ''}"/>>부서</option>
		<option value="kn_rank" <c:out value="${scri.searchType eq 'kn_rank' ? 'selected' : ''}"/>>직급</option>
		<option value="kn_position" <c:out value="${scri.searchType eq 'kn_position' ? 'selected' : ''}"/>>직책</option>
		<option value="kn_file_extension" <c:out value="${scri.searchType eq 'kn_file_extension' ? 'selected' : ''}"/>>확장자</option>
	</select>
	
	<select name="kn_department" id="kn_department" onchange="keyword_click(this.value)" 
	<c:out value="${scri.searchType eq 'kn_department' ? '' : 'style=display:none; disabled=disabled'}"/>>
		<c:forEach var="kn_department" items="${kn_department}">
			<option value="${kn_department.kn_department_code}"
			<c:out value="${scri.keyword eq kn_department.kn_department_code ? 'selected' : ''}"/>>${kn_department.kn_department_name}</option>
		</c:forEach>
	</select>
	
	<select name="kn_rank" id="kn_rank" onchange="keyword_click(this.value)"
	<c:out value="${scri.searchType eq 'kn_rank' ? '' : 'style=display:none; disabled=disabled'}"/>>
		<c:forEach var="kn_rank" items="${kn_rank}">
			<option value="${kn_rank.kn_rank_code}"
			<c:out value="${scri.keyword eq kn_rank.kn_rank_code ? 'selected' : ''}"/>>${kn_rank.kn_rank_name}</option>
		</c:forEach>
	</select>
	
	<select name="kn_position" id="kn_position" onchange="keyword_click(this.value)"
	<c:out value="${scri.searchType eq 'kn_position' ? '' : 'style=display:none; disabled=disabled'}"/>>
		<c:forEach var="kn_position" items="${kn_position}">
			<option value="${kn_position.kn_position_code}"
			<c:out value="${scri.keyword eq kn_position.kn_position_code ? 'selected' : ''}"/>>${kn_position.kn_position_name}</option>
		</c:forEach>
	</select>
	
	<select name="kn_file_extension" id="kn_file_extension" onchange="keyword_click(this.value)"
	<c:out value="${scri.searchType eq 'kn_file_extension' ? '' : 'style=display:none; disabled=disabled'}"/>>
		<option value="hwp" <c:out value="${scri.keyword eq 'hwp' ? 'selected' : 'selected'}"/>>hwp</option>
		<option value="xls" <c:out value="${scri.keyword eq 'xls' ? 'selected' : ''}"/>>xls</option>
		<option value="xlsx" <c:out value="${scri.keyword eq 'xlsx' ? 'selected' : ''}"/>>xlsx</option>
		<option value="ppt" <c:out value="${scri.keyword eq 'ppt' ? 'selected' : ''}"/>>ppt</option>
		<option value="pptx" <c:out value="${scri.keyword eq 'pptx' ? 'selected' : ''}"/>>pptx</option>
		<option value="doc" <c:out value="${scri.keyword eq 'doc' ? 'selected' : ''}"/>>doc</option>
		<option value="docx" <c:out value="${scri.keyword eq 'docx' ? 'selected' : ''}"/>>docx</option>
		<option value="txt" <c:out value="${scri.keyword eq 'txt' ? 'selected' : ''}"/>>txt</option>
		<option value="jpg" <c:out value="${scri.keyword eq 'jpg' ? 'selected' : ''}"/>>jpg</option>
		<option value="jpeg" <c:out value="${scri.keyword eq 'jpeg' ? 'selected' : ''}"/>>jpeg</option>
		<option value="png" <c:out value="${scri.keyword eq 'png' ? 'selected' : ''}"/>>png</option>
	</select>
	
	<input type="text" name="search_text" id="search_text" value="${scri.keyword}"
	<c:out value="${scri.searchType eq 'kn_name' || scri.searchType eq 'kn_id' || empty scri.searchType ? '' : 'style=display:none; disabled=disabled'}"/>>
	<button type="button" name="search_button" id="search_button">검색</button>
	
	<input type="hidden" name="keyword" id="keyword" value="${scri.keyword}">
	
	<table border="1" style="width: 80%;">
		<tr>
			<td>파일번호</td>
			<td>부서</td>
			<td>직급</td>
			<td>직책</td>
			<td>이름</td>
			<td style="width: 800px;">파일명</td>
			<td>파일크기</td>
			<td>등록일</td>
		</tr>
	<c:forEach var="admin_kn_file_select" items="${admin_kn_file_select}">
		<tr>
			<td>${admin_kn_file_select.kn_file_code}</td>
			<td>${admin_kn_file_select.kn_department}</td>
			<td>${admin_kn_file_select.kn_rank}</td>
			<td>${admin_kn_file_select.kn_position}</td>
			<td>${admin_kn_file_select.kn_name}</td>
			<td>
				<a onclick="kn_file_down('${admin_kn_file_select.kn_file_code}'); return false;" style="cursor: pointer; color: blue;">
					${admin_kn_file_select.kn_org_file_name}
				</a>
			</td>
			<td>${admin_kn_file_select.kn_file_size}KB</td>
			<td>
				<fmt:formatDate pattern="yyyy-MM-dd a hh:mm" value="${admin_kn_file_select.kn_reg_date}"/>
			</td>
		</tr>
	</c:forEach>
	</table>
	<div>
	  <ul>
	    <c:if test="${pageMaker.prev}">
	    	<li><a href="/admin/main${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
	    </c:if> 
	
	    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
	    	<li><a href="/admin/main${pageMaker.makeSearch(idx)}">${idx}</a></li>
	    </c:forEach>
	
	    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
	    	<li><a href="/admin/main${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
	    </c:if> 
	  </ul>
	</div>
	
	<form name="file_down_form" id="file_down_form" method="post">
		<input type="hidden" name="kn_file_code" id="kn_file_code">
	</form>
	
<script type="text/javascript">
	$(document).ready(function() {
		//로그아웃 버튼 클릭 이벤트
		$("#logout_button").on("click", function() {
			location.href = "/admin/logout";
		});
		
		//초기화 버튼 클릭 이벤트
		$("#reset_button").on("click", function() {
			location.href = "/admin/main";
		});
		
		//검색 버튼 클릭 이벤트
		$("#search_button").on("click", function() {
			file_search();
		});
	});
	
	//검색 액션
	function file_search() {
		if($("select[name=searchType]").val() == "kn_name" || $("select[name=searchType]").val() == "kn_id") {
			if($.trim($("#search_text").val()).length < 1) {
				alert("검색어를 입력해주세요.");
				$("#search_text").focus();
				return false;
			} else {
				$('#keyword').val($("#search_text").val());
				location.href = "/admin/main" + '${pageMaker.makeQuery(1)}' + 
								"&searchType=" + $("select[name=searchType]").val() + 
								"&keyword=" + encodeURIComponent($('#keyword').val());
			}
		} else {
			location.href = "/admin/main" + '${pageMaker.makeQuery(1)}' + 
							"&searchType=" + $("select[name=searchType]").val() + 
							"&keyword=" + encodeURIComponent($('#keyword').val());
		}
	}
	
	//파일 다운
	function kn_file_down(kn_file_code){
		var formObj = $("form[name='file_down_form']");
		$("#kn_file_code").attr("value", kn_file_code);
		formObj.attr("action", "/admin/file_down_action");
		formObj.submit();
	}
	
	//검색 조건 클릭
	function searchtype_click(obj) {
		if(obj == "kn_department" || obj == "kn_rank" || obj == "kn_position" || obj == "kn_file_extension") {
			$("#kn_department").attr("disabled", true);
			$("#kn_rank").attr("disabled", true);
			$("#kn_position").attr("disabled", true);
			$("#kn_file_extension").attr("disabled", true);
			$("#search_text").attr("disabled", true);
			
			$('#kn_department').css("display", "none");
			$('#kn_rank').css("display", "none");
			$('#kn_position').css("display", "none");
			$('#kn_file_extension').css("display", "none");
			$('#search_text').css("display", "none");
			
			$("#" + obj).attr("disabled", false);
			$("#" + obj).css("display", "");
			$('#keyword').val($("select[name=" + obj + "]").val());
		} else {
			$("#kn_department").attr("disabled", true);
			$("#kn_rank").attr("disabled", true);
			$("#kn_position").attr("disabled", true);
			$("#kn_file_extension").attr("disabled", true);
			$("#search_text").attr("disabled", false);
			
			$('#kn_department').css("display", "none");
			$('#kn_rank').css("display", "none");
			$('#kn_position').css("display", "none");
			$('#kn_file_extension').css("display", "none");
			$('#search_text').css("display", "");
			$('#search_text').val("");
		}
	}
	
	//키워드 타입 클릭
	function keyword_click(obj) {
		$('#keyword').val(obj);
	}
	
</script>
</body>
</html>