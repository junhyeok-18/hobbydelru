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
		<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
		<script type="text/JavaScript" src="/resources/js/javascript.js" ></script>
		<script type="text/JavaScript" src="/resources/js/jquery.alerts.js" ></script>
		<script type="text/JavaScript" src="/resources/js/html2canvas.js" ></script>
	</head>
	<body>
		<img alt="메인" src="/resources/image/main.png" style="width: 100%;">
		
		<!-- 하단 메뉴바 -->
		<div data-include-path="navigation"></div>
		
		<script>
	        window.addEventListener('load', function() {
	            var allElements = document.getElementsByTagName('*');
	            Array.prototype.forEach.call(allElements, function(el) {
	                var includePath = el.dataset.includePath;
	                if (includePath) {
	                    var xhttp = new XMLHttpRequest();
	                    xhttp.onreadystatechange = function () {
	                        if (this.readyState == 4 && this.status == 200) {
	                            el.outerHTML = this.responseText;
	                        }
	                    };
	                    xhttp.open('GET', includePath, true);
	                    xhttp.send();
	                }
	            });
	        });
		</script>
	</body>
</html>