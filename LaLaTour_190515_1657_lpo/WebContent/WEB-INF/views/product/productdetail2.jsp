<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>
 
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./css/pslide.css">
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="div_root">

<div id="div_detail_top" style="width: 1500px; display: inline-block;">
<div id="div_pic_wrap" style="width: 600px; height: 750px; float:left; /* background-color: red; */">
	<div id="div_pic">
		<img alt="" src="<%=request.getContextPath()%>/upload/${fileList[0].fileNameAf}"
			style="width: 600px; height: 600px;">
	</div><br>
	<div class="als-container" id="demo1" style="text-align: center;">
	
		
	
	
		<div class="als-viewport">
		<span class="als-prev"><button type="button"> < </button></span>
		<!-- <button type="button"> < </button> -->
		<ul class="als-wrapper">
			<c:forEach items="${fileList}" var="flist">
				<li class="als-item">
					<img alt="" src="<%=request.getContextPath()%>/upload/${flist.fileNameAf}" style="width: 84px; height: 84px;">
				</li>
			</c:forEach>
	    </ul>
	    <div class="als-next"><button type="button"> > </button></div>
		<!-- <button type="button"> > </button> -->
		</div>
		
		<%-- <c:set var="i" value="1"/>
		<c:forEach items="${fileList}" var="flist">
			<c:if test="${i < '4'}">
				<img alt="" src="<%=request.getContextPath()%>/upload/${flist.fileNameAf}"
					style="width: 84px; height: 84px;">
			</c:if>
			<c:set var="i" value="${i+1}"/>
		</c:forEach> --%>
	</div>
</div> <!-- end div_pic_wrap -->

<div id="div_detail_wrap" style="width: 800px; height: 750px; float:right; background-color: green;">
	<div id="div_detail_top">
		<div><h2>${product.title}</h2></div>
		<table border="1">
		<colgroup>
			<col width="180px"><col width="580px">
		</colgroup>
		
		<tr>
			<th>판매가</th>
			<td>${product.price}원</td>
		</tr>
		<tr>
			<th>원산지</th>
			<td>${product.place}</td>
		</tr>
		<tr>
			<th>판매수량</th>
			<td>${product.pcount}</td>
		</tr>
		<tr>
			<th>등록일</th>
			<td>${product.wdate}</td>
		</tr>
		<tr>
			<th>배송정보</th>
			<td>택배배송 - 평균 2일 이내 배송 (토,일,공휴일 제외)</td>
		</tr>
		<tr>
			<th>배송비</th>
			<td>무료</td>
		</tr>				
		</table>
	</div> <!-- end div_detail_top -->
	<div id="div_detail_cart">
		<div id="div_detail_cart_count">
			<div style="display: inline-block;">
				${product.title}<br>
				<span>
					<button type="button" id="mBtn" style="float: left;">-</button>
					<input type="text" id="_myCount" name="myCount" value="1" style="width:50px; float:left;">
					<button type="button" id="pBtn" style="float: left;">+</button>
				</span>
				<span class="total" style="float: right;"></span>
			</div><br>
			<div style="display: inline-block;">
				합계 <span class="total" style="font-size: 25px; color: orange;"></span>
			</div>
			<div>
				<!-- <button type="button" id="_cartinsertBtn">장바구니</button> -->
				<button type="button" class="btn btn-primary btn-lg" id="_cartinsertBtn">장바구니</button>
			</div>			
		</div>
	</div>
</div> <!-- end div_detail_wrap -->
</div> <!-- end div_detail_top -->

<div id="div_content_wrap" style="display: block;">
<h2>상품상세정보</h2>
<textarea rows="10" cols="30">${product.content}</textarea>
</div> <!-- end div_content_wrap -->

</div> <!-- end div_root -->

<form id="cartForm" action="cartinsert.do" method="post">
	<input type="hidden" name="pseq" value="${product.seq}">
	<input type="hidden" id="myCount" name="myCount">
	<input type="hidden" name="id" value="aaa">
</form>


<script>
var total = '${product.price}' * Number( $("#_myCount").val() );
$(".total").append( (total+"원") );

$(document).on("click", "#mBtn", function() {
	var val = Number( $("#_myCount").val() );
	
	if(val>1) {
		val = val-1;
	}
	
	$("#_myCount").val( val );
	showTotal();
});

$(document).on("click", "#pBtn", function() {
	var val = Number( $("#_myCount").val() );
	
	if(val==10) {
		alert("최대 주문수량은 10입니다");
		return;
	}
	else {
		val = val+1;
	}
	
	$("#_myCount").val( val );
	showTotal();
});

$(document).on("change", "#_myCount", function() {
	alert($("#_myCount").val());
});

function showTotal() {
	var total = '${product.price}' * Number( $("#_myCount").val() );
	$(".total").empty();
	$(".total").append( (total+"원") );
}

$(document).on("click", "#_cartinsertBtn", function() {
	
	alert("cclliicckk");
/* 	var cartForm = document.cartForm;
	
	cartForm.myCount.value = $("#_myCount").val();
	cartForm.submit(); */
	
	$("#myCount").val( $("#_myCount").val() );
	$("#cartForm").submit();
});

/* $("#demo1").als({
	visible_items: 3,
	scrolling_items: 2,
	orientation: "horizontal",
	circular: "no",
	autoscroll: "no"
}); */
</script>

</body>
</html>



































