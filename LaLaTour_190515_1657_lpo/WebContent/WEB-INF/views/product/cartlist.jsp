<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    
<h1>장바구니</h1>

<div id="totalDiv">

<div id="topDiv" style="width: 1500px;">
<form method="post" id="_orderForm">

<div id="hcount">
</div>

<table border="1">
<colgroup>
	<col width="100px"><col width="300px"><col width="500px">
	<col width="300px"><col width="300px">
</colgroup>

<thead>
<tr>
	<th>선택<input type="checkbox" name="allChk" id="_allChk"></th>
	<th>상품</th>
	<th>상품명</th>
	<th>수량</th>
	<th>지우기<button type="button" id="_checkDels">선택항목 삭제</button></th>
</tr>
</thead>

<tbody>
<c:if test="${clist.size() eq '0' or empty clist}">
	<tr>
		<td colspan="5">장바구니에 제품이 없습니다.</td>
	</tr>
</c:if>

<c:if test="${clist.size() > '0'}">
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
			<button type="button" id="pBtn" pcount="${item.pcount}" style="float: left;">+</button>
		</span>
	</td>
	<td><button type="button" onclick="location.href='cartDelete.do?seq=${item.seq}'">지우기</button></td>
</tr>
</c:forEach>
<tr>
	<td colspan="5" style="text-align: right;">
		결제예정금액: 
		<span id="_totalprice">0</span>원
		<button type="button" id="_orderBtn">주문하기</button>
	</td>
</tr>
</c:if>
</tbody>

</table>
</form>
</div> <!-- end topDiv -->



</div> <!-- end totalDiv -->


<script>
function chk(obj){
	var totalPrice = obj.getAttribute("data-xea");
	alert(totalPrice);
	var nowPrice = $("#_totalprice").text();
	alert(nowPrice);
	
	totalPrice = Number(totalPrice);
	nowPrice = Number(nowPrice);
	
	var qq = totalPrice + nowPrice;
	$("#_totalprice").empty();
	$("#_totalprice").append(qq);
} 

//결제하기 했을 때 선택되어 있는지 검사하고 서브밋
$(document).on("click", "#_orderBtn", function() {
	if( $("input:checkbox[name=chk_order]:checked").length==0 ) {
		alert("구매할 제품을 선택해 주세요");
		return;
	}
	else {
		$("#_orderForm").attr("action", "orderedlist.do").submit();
	}
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
	var pcount = Number( $(this).attr("pcount") );
	
	var obj = $(this).parent().children("input");

	var val = Number( obj.val() );
	
	if(val==pcount) {
		alert("현재 재고를 초과할 수 없습니다");
		return;
	}
	else if(val==10) {
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
	
	tpCal();
}

function tpCal() {
	//var obj_cb = document.getElementsByName("chk_order");
	var obj_cb = $("input[name=chk_order]");
	
	var totalPrice = 0;
	var tags = "";
	
	for(var i=0; i<obj_cb.length; i++) {
		if(obj_cb[i].checked==true) {
			var oobj = obj_cb[i].parentNode.parentNode.childNodes[7].childNodes[4].childNodes[3];
			
			var price = Number(oobj.getAttribute("price"));
			var pcount = Number(oobj.value);
			
			totalPrice += price * pcount;
			
			tags += "<input type='hidden' name='hcount' value='" + pcount + "'>";
		}
		//alert(i);
		//alert(obj_cb.parent().children("input[name=myCount]").val());
		//alert(obj_cb[i].val());
		//alert(obj_cb[i].parentNode.parentNode.childNodes.length);
		//alert(obj_cb[i].parentNode.parentNode.childNodes[7].childNodes.length);
		//alert(obj_cb[i].parentNode.parentNode.childNodes[7].childNodes[4].childNodes.length);
		//alert(obj_cb[i].parentNode.parentNode.childNodes[7].childNodes[4].childNodes[3].childNodes);
		
		//alert("value: " + oobj.value);
		//alert("price: " + oobj.getAttribute("price"));
		
		
		/* for(var j=0; j<obj_cb[i].parentNode.parentNode.childNodes[7].childNodes[4].childNodes.length; j++) {
			//alert(obj_cb[i].parentNode.parentNode.childNodes[7].childNodes[4].childNodes[j].nodeName);
		} */
	}
	
	$("#_totalprice").empty();
	$("#_totalprice").append( totalPrice );
	
	
	$("#hcount").empty();
	$("#hcount").append(tags);
	//calTotalPrice(obj_cb);
}

$(document).on("change", "input[name=chk_order]", function() {
	$("#_allChk").prop("checked", false);
	tpCal();
	//var obj_cb = document.getElementsByName("chk_order");
	/* var obj_cb = $("input[name=chk_order]");
	
	var totalPrice = 0;
	
	for(var i=0; i<obj_cb.length; i++) {
		if(obj_cb[i].checked==true) {
			var oobj = obj_cb[i].parentNode.parentNode.childNodes[7].childNodes[4].childNodes[3];
			
			var price = Number(oobj.getAttribute("price"));
			var pcount = Number(oobj.value);
			
			totalPrice += price * pcount;
		}
		//alert(i);
		//alert(obj_cb.parent().children("input[name=myCount]").val());
		//alert(obj_cb[i].val());
		//alert(obj_cb[i].parentNode.parentNode.childNodes.length);
		//alert(obj_cb[i].parentNode.parentNode.childNodes[7].childNodes.length);
		//alert(obj_cb[i].parentNode.parentNode.childNodes[7].childNodes[4].childNodes.length);
		//alert(obj_cb[i].parentNode.parentNode.childNodes[7].childNodes[4].childNodes[3].childNodes);
		
		//alert("value: " + oobj.value);
		//alert("price: " + oobj.getAttribute("price"));
	}
	
	$("#_totalprice").empty();
	$("#_totalprice").append( totalPrice );
	 */
	//calTotalPrice(obj_cb);
});

//전체선택 체크박스 변동시,
$(document).on("change", "#_allChk", function() {
	//체크가 됐으면,
	if( $("#_allChk").is(":checked") ) {
		$("input:checkbox[name=chk_order]").prop("checked", true);
	}
	//체크가 해제됐으면,
	else {
		$("input:checkbox[name=chk_order]").prop("checked", false);
	}
	tpCal();
});

//선택항목 삭제 버튼 클릭시
$(document).on("click", "#_checkDels", function() {
	if( $("input:checkbox[name=chk_order]:checked").length==0 ) {
		alert("선택된 항목이 없습니다");
		return;
	}
	$("#_orderForm").attr("action", "deleteCart.do").submit();
});




</script>






















