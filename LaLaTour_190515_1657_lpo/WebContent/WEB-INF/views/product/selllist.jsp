<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<h1>주문내역</h1>

<div id="totalDiv">

<div id="topDiv" style="width: 1500px;">
<!-- <form method="post" id="_orderForm"> -->

<div id="hcount">
</div>

<table border="1">
<colgroup>
	<col width="300px"><col width="100px"><col width="700px">
	<col width="100px"><col width="100px"><col width="100px">
</colgroup>

<thead>
<tr>
	<th>주문번호</th>
	<th>이미지</th>
	<th>상품명</th>
	<th>수량</th>
	<th>구매금액</th>
	<th>상품평</th>
</tr>
</thead>

<tbody>
<c:if test="${sellist.size() eq '0' or empty selllist}">
	<tr>
		<td colspan="6">주문내역이 없습니다.</td>
	</tr>
</c:if>

<c:if test="${selllist.size() > '0'}">
<c:forEach items="${selllist}" var="item">
<tr>
	<td><a href="getOrderSList.do?omid=${item.omid}">${item.omid}</a></td>
	<td><img src="<%=request.getContextPath()%>/upload/${item.thumbNail}" style="width: 95px; height: auto;"></td>
	<td><a href="productdetail.do?product_seq=${item.pseq}">${item.title}</a></td>
	<td>${item.myCount}</td>
	<td>
		<span class="total">
			<c:set var="tprice" value="${item.myCount * item.price}"/>
			${tprice}원
		</span><br>
	</td>
	<td>
		<c:if test="${item.gseq > '0'}">
			작성완료
		</c:if>
		<c:if test="${item.gseq eq '0'}">
			<button type="button" onclick="location.href='insertGoods.do?product_seq=${item.product_seq}&cart_seq=${item.cart_seq}'">상품평쓰기</button>
		</c:if>
	</td>
	<%-- <td>
		<button type="button" onclick="location.href='insertGoods.do?cart_seq=${item.cart_seq}&product_seq=${item.product_seq}'">상품평쓰기</button>
	</td> --%>
</tr>
</c:forEach>
</c:if>
</tbody>

</table>
<!-- </form> -->
</div> <!-- end topDiv -->



</div> <!-- end totalDiv -->
