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
	사번 : ${user.kn_code} <br>
	아이디 : ${user.kn_id} <br>
	이름 : ${user.kn_name} <br>
	<h2>
	파일의 용량은 10MB이하로만 가능하며, 확장자는 hwp/xls/xlsx/ppt/pptx/doc/docx/txt/jpg/jpeg/png만 가능합니다.<br>
	파일 수정은 업로드 한 당일에만 수정이 가능합니다. (삭제 후 재업로드) <br>
	확장자까지 같은 동일파일명을 재업로드시 당일에 올린 파일에 한하여 덮어씌우기가 됩니다.
	</h2>
	<button type="button" name="logout_button" id="logout_button">로그아웃</button>
	<form id="upload_form">
		<input type="file" name="kn_file" id="kn_file" onchange="file_size_change()">
		<span id="file_size" style="color:blue; font-size:18px;"></span>
		<button type="button" name="upload_button" id="upload_button">업로드</button>
	</form>
	
	<table border="1" style="width: 80%;">
		<tr>
			<td style="width: 800px;">파일명</td>
			<td>파일크기</td>
			<td>등록일</td>
			<td>삭제유무</td>
		</tr>
	<c:forEach var="file" items="${file}">
		<tr>
			<td>${file.kn_org_file_name}</td>
			<td>${file.kn_file_size}KB</td>
			<td>
				<fmt:formatDate pattern="yyyy-MM-dd a hh:mm" value="${file.kn_reg_date}"/>
   			</td>
			<td>
				<fmt:formatDate value="${file.kn_reg_date}" pattern="yyyyMMdd" var="filedate" />
				<c:if test="${today eq filedate}">
					<button type="button" name="${filedate}" id="${file.kn_file_code}" onclick="file_delete_action(this)">삭제</button>
				</c:if>
				<c:if test="${today ne filedate}">
					삭제불가능
				</c:if>
			</td>
		</tr>
	</c:forEach>
	</table>
	<div>
	  <ul>
	    <c:if test="${pageMaker.prev}">
	    	<li><a href="/main${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
	    </c:if> 
	
	    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
	    	<li><a href="/main${pageMaker.makeQuery(idx)}">${idx}</a></li>
	    </c:forEach>
	
	    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
	    	<li><a href="/main${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
	    </c:if> 
	  </ul>
	</div>
	
<script type="text/javascript">
	$(document).ready(function() {
		//로그아웃 버튼 클릭 이벤트
		$("#logout_button").on("click", function() {
			location.href = "/logout"
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
			var fileSize = document.getElementById("kn_file").files[0].size;
		    var maxSize = 10 * 1024 * 1024; //10MB
		    if(fileSize > maxSize) {
		       alert("파일 사이즈는 10MB 이내로 등록 가능합니다. ");
		       return;
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
							alert("파일 업로드가 완료되었습니다.");
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
	}
	
	//파일삭제 액션
	function file_delete_action(obj) {
		if(confirm("정말로 삭제하시겠습니까?") == true) {
			$.ajax({
				url : "/user/delete_action",
				type : "post",
				data :  {kn_file_code : $(obj).attr("id"), kn_reg_date : $(obj).attr("name")},
				success : function(data) {
					if($.trim(data) == 1) {
						alert("파일 삭제가 완료되었습니다.");
						location.href = "/main";
					} else {
						alert("파일 삭제는 업로드 당일만 가능합니다.");
					}
				},
				error : function(data) {
					alert("다시 시도해주시기 바랍니다.");
				}
			});
		} else {
			return;
	    }
	}
	
	//파일 사이즈 출력
	function file_size_change() { 
		if(document.getElementById("kn_file").files[0] != null) {
			var fileSize = document.getElementById("kn_file").files[0].size;
			$("#file_size").text((fileSize/1048576).toFixed(1) + "MB");
		} else {
			$("#file_size").text("");
		}
	}
</script>
</body>
</html>