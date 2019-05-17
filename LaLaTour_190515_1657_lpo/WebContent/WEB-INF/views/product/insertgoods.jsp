<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

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
<div id="pointDiv" style="width: 1500px; height: 150px;">
	<select name="gpoint" id="_gpoint">
		<option value="5" selected="selected">5점: 최고예요!</option>
		<option value="4">4점: 좋아요!</option>
		<option value="3">3점: 보통이에요!</option>
		<option value="2">2점: 그냥그래요!</option>
		<option value="1">1점: 아쉽네요!</option>
	</select>
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
function addBtnClick() {
	if($($("#_gcontent").val().trim()=='') {
		alert("상품평을 입력해 주세요");
		return;
	}
	
	$("#_goodsForm").attr("action", "insertGoodsAf.do").submit();
}
</script>































