<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>하비델루</title>
	
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
	
	<!-- css --> <!-- 
	<link rel="stylesheet" href="/resources/css/style.css" type="text/css"> -->
	<link rel="stylesheet" href="/resources/css/jquery.alerts.css" type="text/css">
	
	<!-- javascript -->
	<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
	<script type="text/JavaScript" src="/resources/js/javascript.js" ></script>
	<script type="text/JavaScript" src="/resources/js/jquery.alerts.js" ></script>
	<script type="text/JavaScript" src="/resources/js/html2canvas.js" ></script>
	
	<style type="text/css">
		@charset "UTF-8";
		@font-face {
		   font-family: 'neodgm';
		   src: local('neodgm'),
		      url('/resources/font/neodgm_pro.ttf') format('truetype');
		}
	</style>
</head>
<body style="width: 100%; min-height: 100%; margin: 0; padding: 0;">
	<select name="time" onchange="div1_change(this.value)">
		<option value="1" selected="selected">오전</option>
		<option value="2">오후</option>
	</select>
	
	<input type="text" onkeyup="date_change(this.value)">
	
	<select name="time" onchange="div3_change(this.value)">
		<option value="0" selected="selected">선택하셈</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5">5</option>
		<option value="6">6</option>
	</select>
	
	<select id="cos_click" onchange="cos_image_add(this)">
		<option value="default" selected="selected">선택해</option>
		<option value="물세안">물세안</option>
		<option value="허블룸 콤부차 플랜트바이옴 세럼">허블룸 콤부차 플랜트바이옴 세럼</option>
		<option value="이니스프리 그린티  세럼">이니스프리 그린티  세럼</option>
		<option value="이니스프리 레티놀 시카 흔적 앰플">이니스프리 레티놀 시카 흔적 앰플</option>
		<option value="스킨앤랩 베리어덤 인텐시브 크림">스킨앤랩 베리어덤 인텐시브 크림</option>
		<option value="닥터자르트 바이탈 하이드라 솔루션 바이옴 에센스">닥터자르트 바이탈 하이드라 솔루션 바이옴 에센스</option>
		<option value="듀이트리 어반쉐이드 안티폴루션 선">듀이트리 어반쉐이드 안티폴루션 선</option>
		<option value="리얼베리어 익스트림 크림">리얼베리어 익스트림 크림</option>
	</select>
	
	<input type="text" id="cos_price">
	
	<button type="button" id="img_down">다운로드</button>
	
	<div id="div1" style="width: 1080px; height: 1080px; background-color: #EF7D29; display: flex; justify-content: center; align-items: center; font-family: neodgm">
		<div id="div2" style="width: 1035px; height: 1035px; background-color: #FFFFFF; margin: auto; position: relative;">
			<table style="margin: 24px 0px 0px 24px;">
				<tr>
					<td>
						<img id="time_img" alt="morning" src="/resources/image/morning.png" style="width: 94px; margin-right: 24px;">
					</td>
					<td id="date" style="color: #EA5514; font-size: 70px;"></td>
				</tr>
			</table>
			<div id="div3" style="width: 100%; text-align: center; margin-top:173px;">
				<table style="height: 300px; margin: auto;">
					<tr id="cosmetic">
					</tr>
				</table>
			</div>
			<div id="div4" style="width: 100%; position: absolute; bottom: 10px;"></div>	
		</div>
	</div>
	
<script type="text/javascript">
	var cos_image_address = "";
	var cos_image_order = "";

	function div1_change(obj) {
		if(obj == 1) {
			$("#div1").css("background-color", "#EF7D29");
			$("#date").css("color", "#EA5514");
			$("#time_img").attr("src", "/resources/image/morning.png");
		} else {
			$("#div1").css("background-color", "#036EB8");	
			$("#date").css("color", "#005AA6");
			$("#time_img").attr("src", "/resources/image/evening.png");
		}
	}
	
	function date_change(obj) {
		$("#date").html(obj);
	}
	
	function div3_change(obj) {
		var cos_image = "";
		
		$("#cosmetic").empty();
		$("#div4").empty();
		
		if(obj != 0) {
			for(var i=1; i<obj; i++) {
				cos_image += "<td><img id='cos_image_" + i + "' src='/resources/image/question.png' style='width: 95px; cursor: pointer;' onclick='cos_image_change(" + i + ")'></td>";
				cos_image += "<td><img src='/resources/image/next.png' style='margin: 0px 22px 0px 22px;'></td>";
			}
			
			cos_image += "<td><img id='cos_image_" + obj + "' src='/resources/image/question.png' style='width: 95px; cursor: pointer;' onclick='cos_image_change(" + obj + ")'></td>";
			
			$("#cosmetic").append(cos_image);
		} else {
			$("#cosmetic").empty();
			$("#div4").empty();
		}
	}
	
	function cos_image_change(obj) {
		cos_image_order = obj;
		$("#cos_click option:eq(0)").prop("selected", true);
		$("#cos_info_div" + obj).remove();
	}
	
	function cos_image_add(obj) {
		cos_image_address = obj.value;
		$("#cos_image_" + cos_image_order).attr("src", "/resources/image/cosmetic/" + cos_image_address + ".png");
		
		var cos_info = "";
		
		cos_info += "<div id='cos_info_div" + cos_image_order + "' style='width: 100%; display: inline-block;'>";
		cos_info += "<div id='order_div" + cos_image_order + "' style='margin: 0px 20px 10px 47px; float: left;'>";
		cos_info += "<img alt='" + cos_image_order + "' src='/resources/image/" + cos_image_order + ".png' style='width: 44px;'>";
		cos_info += "</div>";
		cos_info += "<div id='add_div" + cos_image_order + "' style='font-size: 34px; line-height: 45px; float: left;'>" + cos_image_address + "</div>";
		cos_info += "<div id='bash_div" + cos_image_order + "' style='font-size: 20px; line-height: 45px; float: left;'>";
		cos_info += "</div>";
		cos_info += "<div id='price_div" + cos_image_order + "' style='font-size: 34px; line-height: 45px; float: right; margin-right: 47px;'>" + $("#cos_price").val() + "</div>";
		cos_info += "</div>";

		$("#div4").append(cos_info);
		
		var bash_info = "";
		var bash_img = (1035-($("#order_div" + cos_image_order).outerWidth(true) + $("#add_div" + cos_image_order).outerWidth(true) + $("#price_div" + cos_image_order).outerWidth(true))) / 16;
		
		for(var i=1; i<bash_img; i++) {
			bash_info += "<img alt='bash' src='/resources/image/bash.png' style='width: 16px; vertical-align: middle;'>";	
		}
		
		if(cos_image_address != "물세안") {
			$("#bash_div" + cos_image_order).append(bash_info);	
		} else {
			
		}
	}
	
	$(document).ready(function(){
		$("#img_down").on("click",function(){
			html2canvas($('#div1')[0]).then(function(canvas){
				var img = document.createElement("a");
				img.download = "test.png";
				img.href=canvas.toDataURL();
				document.body.appendChild(img);
				img.click();
			});
		});
	});
</script>
</body>
</html>