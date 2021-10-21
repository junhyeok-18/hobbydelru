<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no">
		<title>HOBBYDELRU</title>
		
		<!-- favicon -->
		<link rel="shortcut icon" type="image/x-icon" href="/resources/favicon/favicon.ico">
		
		<!-- css -->
		<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
		
		<!-- javascript -->
		<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
		<script type="text/JavaScript" src="/resources/js/javascript.js" ></script>
		<script type="text/JavaScript" src="/resources/js/jquery.alerts.js" ></script>
		<script type="text/JavaScript" src="/resources/js/html2canvas.js" ></script>
	</head>
	<body>
		<!-- 메인 화면 시작 (default home) -->
		<div id="main_div">
			<div data-include-path="home"></div>
		</div>
		<!-- 메인 화면 끝 (default home) -->
		
		<!-- 네비게이션 시작 -->
		<div class="nav_div">
			<div class="nav_item">
				<div class="nav_link" data-nav-address="home">
					<img class="nav_image" alt="HOME" src="/resources/image/navigation/nav_home_select.png" data-img-src="nav_home">
					<span class="nav_name">홈</span>
				</div>
			</div>
			<div class="nav_item">
				<div class="nav_link" data-nav-address="ranking">
					<img class="nav_image" alt="RANKING" src="/resources/image/navigation/nav_ranking.png" data-img-src="nav_ranking">
					<span class="nav_name">랭킹</span>
				</div>
			</div>
			<div class="nav_item">
				<div class="nav_link" data-nav-address="hobbydelru">
					<img class="nav_image" alt="HOBBYDELRU" src="/resources/image/navigation/nav_hobbydelru.png" data-img-src="nav_hobbydelru">
				</div>
			</div>
			<div class="nav_item">
				<div class="nav_link" data-nav-address="productrequest">
					<img class="nav_image" alt="PRODUCT-REQUEST" src="/resources/image/navigation/nav_productrequest.png" data-img-src="nav_productrequest">
					<span class="nav_name">요청</span>
				</div>
			</div>
			<div class="nav_item">
				<div class="nav_link" data-nav-address="myinfo">
					<img class="nav_image" alt="MY-INFO" src="/resources/image/navigation/nav_myinfo.png" data-img-src="nav_myinfo">
					<span class="nav_name">내정보</span>
				</div>
			</div>
		</div>
		<!-- 네비게이션 끝 -->
		
		<script type="text/javascript">
	        window.addEventListener("DOMContentLoaded", function() {
	        	//메인 화면 불러오기
	            var allElements = document.getElementsByTagName("*");
	            Array.prototype.forEach.call(allElements, function(el) {
	                var includePath = el.dataset.includePath;
	                if (includePath) {
	                    var xhttp = new XMLHttpRequest();
	                    xhttp.onreadystatechange = function() {
	                        if (this.readyState == 4 && this.status == 200) {
	                            el.outerHTML = this.responseText;
	                        }
	                    };
	                    xhttp.open("GET", includePath, true);
	                    xhttp.send();
	                }
	            });
	            
	            //네비게이션 클릭 이벤트
	            var navElements = document.getElementsByClassName("nav_link"); 
	            Array.prototype.forEach.call(navElements, function(el) {
					el.addEventListener("click", function() {
						//클릭한 메뉴 이미지 변경
						$(el).children("img").attr("src", "/resources/image/navigation/" + $(el).children("img").data("imgSrc") + "_select.png");
						
						//클릭한 메뉴를 제외한 나머지 메뉴들 이미지 변경
						var navImage = document.getElementsByClassName("nav_image");
						Array.prototype.forEach.call(navImage, function(ck) {
							if($(el).children("img").data("imgSrc") != ck.dataset.imgSrc) { 
								ck.src = "/resources/image/navigation/" + ck.dataset.imgSrc + ".png";
							}
						});
						
						//클릭한 메뉴에 따라 메인 화면 변경
						var includePath = el.dataset.navAddress;
						if (includePath) {
				        	var xhttp = new XMLHttpRequest();
							xhttp.onreadystatechange = function() {
								if(xhttp.readyState == 4 && xhttp.status == 200) {
									document.getElementById("main_div").innerHTML = xhttp.responseText;
								}	
							};
							xhttp.open("GET", includePath, true);
							xhttp.send();
			        	}
					});
				});
	            
	        });
		</script>
	</body>
</html>