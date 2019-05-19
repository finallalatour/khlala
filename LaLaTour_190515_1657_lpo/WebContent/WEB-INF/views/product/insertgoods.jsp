<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"> -->
<script src="https://unpkg.com/ionicons@4.5.5/dist/ionicons.js"></script>



<!-- <style>
.star-rating {
	unicode-bidi: bidi-override;
	direction: rtl;
}
.star-rating > span {
	display: inline-block;
	position: relative;
	width: 1em;
	font-size: 3em;
	/* float: left; */
}
.star-rating > span:hover:before,
.star-rating > span:hover ~ span:before {
	content: "\2605";
	position: absolute;
	color: #e87474;
}
</style> -->

<style>
#starRight{
	position: static;
	top: 50%;
	left: 50%;
	direction: rtl;
	/* float: left; */
	transform: translate(-60%);
}
#starRight ion-icon {
	font-size: 90px;
	/* color: black; */
	/* transiton: 0.3s all; */
}
/* #starRight > ion-icon:hover{
	color: #c0392b;
}
.b1:hover{
	color: #c0392b;
}
.b2:hover ~ ion-icon{
	color: #c0392b;
}
.b3:hover ~ ion-icon{
	color: #c0392b;
}
.b4:hover ~ ion-icon{
	color: #c0392b;
}
.b5:hover ~ ion-icon{
	color: #c0392b;
} */
/* .b4:hover ~ #starRight > ion-icon{
	color: #c0392b;
} */
/* #starRight ion-icon:hover{
	color: #c0392b;
} */
/* #starRight ion-icon:hover:after, */
/* #starRight ion-icon:hover ~ ion-icon{
	color: #c0392b;
} */
</style>

<h1>상품평 작성</h1>

<div id="totalDiv">

<div id="topDiv" style="width: 1500px;">
<table border="1">
<colgroup>
	<col width="200px"><col width="1300px">
</colgroup>
<tr>
	<td>
		<img alt="" src="<%=request.getContextPath()%>/upload/${product.thumbNail}" style="width: 190px; height: auto; max-height: 190px;">
	</td>
	<td>
		${product.title} - ${product.subtitle}
	</td>
</tr>
</table>
</div> <!-- end topDiv -->

<form id="_goodsForm" method="post">
<input type="hidden" name="gpseq" value="${product.product_seq}">
<input type="hidden" name="gid" value="${login.id}">
<input type="hidden" name="gcseq" value="${cart_seq}">
<div id="pointDiv" style="width: 1500px; height: 150px;">
	<div id="starleft" style="width: 200px; height: 100%; background-color: gray; float: left;">
		별점선택
	</div>
	<div id="starRight" style="width: 1200px; height: 100%; float: left;">
		<input type="hidden" name="gpoint" id="_gpoint" value="0">
		<ion-icon name="star" value="5" class="b1"></ion-icon>
		<ion-icon name="star" value="4" class="b2"></ion-icon>
		<ion-icon name="star" value="3" class="b3"></ion-icon>
		<ion-icon name="star" value="2" class="b4"></ion-icon>
		<ion-icon name="star" value="1" class="b5"></ion-icon>
	</div>
</div> <!-- end pointDiv -->

<div id="contentDiv" style="width: 1500px; height: 200px;">
	<div id="contentleft" style="width: 200px; float: left;">
		상품평
	</div>
	<div id="contentRight" style="width: 1300px;">
		<textarea name="gcontent" id="_gcontent" rows="10" cols="100" ></textarea>
	</div>
</div> <!-- end contentDiv -->

<div id="btnDiv" style="width: 1500px; height: 150px;">
	<button type="button" onclick="addBtnClick()">등록</button>
	<button type="button">취소</button>
</div> <!-- end btnDiv -->
</form>

</div> <!-- end totalDiv -->

<script>
var msgArr = new Array("아쉽네요", "그냥그래요", "보통이에요", "좋아요", "최고예요");

function addBtnClick() {
	if($("#_gcontent").val().trim()=='') {
		alert("상품평을 입력해 주세요");
		return;
	}
	if($("#_gpoint").val()=='0') {
		alert("별점을 선택해 주세요(최소 1점)");
		return;
	}
	
	$("#_goodsForm").attr("action", "insertGoodsAf.do").submit();
}

/* $(document).on("ready", function(){
	alert("11111111111");
	var stars = document.getElementsByName("star");
	
	for(var i=4; i>=0; i--) {
		stars[i].style.color="#c0392b";
	}
}); */

$("ion-icon[name=star]").hover(function(onmouseover) {
	var index = Number($(this).attr("value"))-1;
	
	var stars = document.getElementsByName("star");
	
	//색깔 까맣게 바꿔놓고
	for(var i=4; i>=0; i--) {
		stars[i].style.color="black";
	}
	//호버하기
	for(var i=4; i>=4-index; i--) {
		stars[i].style.color="#c0392b";
	}
}, function(onmousedown) {
	var index = Number($("#_gpoint").val())-1;
	
	var stars = document.getElementsByName("star");
	
	//색깔 까맣게 바꿔놓고
	for(var i=4; i>=0; i--) {
		stars[i].style.color="black";
	}
	//호버하기
	for(var i=4; i>=4-index; i--) {
		stars[i].style.color="#c0392b";
	}
})

$(document).on("click", "ion-icon[name=star]", function() {
	var index = Number($(this).attr("value"))-1;
	
	var stars = document.getElementsByName("star");
	
	alert("value: " + $(this).attr("value"));
	
	for(var i=4; i>=0; i--) {
		stars[i].style.color="black";
	}
	for(var i=4; i>=4-index; i--) {
		stars[i].style.color="#c0392b";
	}
	
	$("#_gpoint").val($(this).attr("value"));
	alert($("#_gpoint").val());
	
	$("#msgs").remove();
	var pmsg = 
		"<p id='msgs'><font style='font-size: 20px; color: #c0392b;'>"
		+ Number($("#_gpoint").val()) + "점 "
		+ msgArr[Number($("#_gpoint").val())-1]
		+ "</font></p>";
	$("#starRight").append(pmsg);
	
});
</script>




























