<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<h1>상세주문내역</h1>

<div id="totalDiv">

<div id="topDiv" style="width: 1500px;">

<div id="detailDiv" style="width: 1500px;">
<table border="1">
<colgroup>
	<col width="300px"><col width="1200px">
</colgroup>

<tbody>
<tr>
	<td>주문번호</td>
	<td>${oslist[0].omid}</td>
</tr>
<tr>
	<td>주문날짜</td>
	<td>${oslist[0].odate}</td>
</tr>
<tr>
	<td>주문자 정보</td>
	<td>${oslist[0].oid}</td>
</tr>
<tr>
	<td>받으시는 분</td>
	<td>${oslist[0].oname}</td>
</tr>
<tr>
	<td>전화번호</td>
	<td>${oslist[0].ophone}</td>
</tr>
<tr>
	<td>받으시는 주소</td>
	<td>${oslist[0].oaddress}</td>
</tr>
</tbody>

</table>
</div> <!-- end detailDiv -->

<div id="listDiv" style="width: 1500px;">
<table border="1">
<colgroup>
	<col width="300px"><col width="700px"><col width="200px"><col width="300px">
</colgroup>

<tbody>
<c:if test="${oslist.size() > '0'}">
<c:forEach items="${oslist}" var="item">
<tr>
	<td><a href="productdetail.do?product_seq=${item.pseq}">
		<img src="<%=request.getContextPath()%>/upload/${item.thumbNail}" style="width: 95px; height: auto;"></a></td>
	<td><a href="productdetail.do?product_seq=${item.pseq}">${item.title}</a></td>
	<td>
		<span class="total">
			<c:set var="tprice" value="${item.myCount * item.price}"/>
			${tprice}원
		</span><br>
		수량 : ${item.myCount}
	</td>
	<td>
		<c:if test="${item.gseq > '0'}">
			작성완료
		</c:if>
		<c:if test="${item.gseq eq '0'}">
			<button type="button" onclick="location.href='insertGoods.do?product_seq=${item.product_seq}&cart_seq=${item.cart_seq}'">상품평쓰기</button>
		</c:if>
	</td>
</tr>
</c:forEach>
</c:if>
</tbody>

</table>
</div>
<!-- </form> -->
</div> <!-- end topDiv -->



</div> <!-- end totalDiv -->
