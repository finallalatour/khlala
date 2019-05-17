<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>
    
<h1>장바구니</h1>
<div>

<div style="width: 1500px;">
<table border="1">
<colgroup>
	<col width="100px"><col width="300px"><col width="500px">
	<col width="300px"><col width="300px">
</colgroup>

<thead>
<tr>
	<th>선택</th>
	<th>상품</th>
	<th>상품명</th>
	<th>수량</th>
	<th>지우기</th>
</tr>
</thead>

<tbody>
<c:forEach items="${clist}" var="item">
<tr>
	<td><input type="checkbox" name="chk_order" value="${item.seq}"></td>
	<td><img src="<%=request.getContextPath()%>/upload/${item.thumbNail}" style="width: 100px; height: 100px;"></td>
	<td><a href="productdetail.do?seq=${item.pseq}">${item.title}</a></td>
	<td>
		<span class="total">
			<c:set var="tprice" value="${item.myCount * item.price}"/>
			${tprice}원
		</span><br>
		<span>
			<button type="button" id="mBtn" style="float: left;">-</button>
			<input type="text" id="_myCount" name="myCount" price="${item.price}" value="${item.myCount}" readonly="readonly" style="width:50px; float:left;">
			<button type="button" id="pBtn" style="float: left;">+</button>
		</span>
	</td>
	<td><button type="button">지우기</button></td>
</tr>
</c:forEach>
<tr>
	<td colspan="5" style="text-align: right;">
		결제예정금액: 
		<span id="_totalprice"></span>
		<button type="button">주문하기</button>
	</td>
</tr>
</tbody>

</table>
</div>

</div>

<script>
$(document).ready(function() {
	calTotalPrice();
});

$(document).on("click", "#mBtn", function() {
	var obj = $(this).parent().children("input");
	
	var val = Number( obj.val() );
	
	if(val>1) {
		val = val-1;
	}
	
	obj.val( val );
	showTotal(obj);
});

$(document).on("click", "#pBtn", function() {
	var obj = $(this).parent().children("input");
	
	var val = Number( obj.val() );
	
	if(val==10) {
		alert("최대 주문수량은 10입니다");
		return;
	}
	else {
		val = val+1;
	}
	
	obj.val( val );
	showTotal(obj);
});

function showTotal(obj) {
	var total = Number(obj.attr("price")) * Number(obj.val());

	obj.parent().parent().children("span.total").empty();
	obj.parent().parent().children("span.total").append( (total+"원") );
	
	calTotalPrice();
}

function calTotalPrice() {
var totalprice = 0;
	
	var obj = document.getElementsByName("myCount");
	
	for(var i=0; i<obj.length; i++) {
		var t1 = Number(obj[i].value);
		var t2 = Number(obj[i].getAttribute("price"));
		totalprice += t1 * t2; 
	}
	
	$("#_totalprice").empty();
	$("#_totalprice").append( (totalprice+"원") );
}

$(document).on("change", "input[name=chk_order]", function() {
	var obj = $(this).parent().children("input");
	var price = Number( obj.val() );
	alert(price);
});
</script>






















