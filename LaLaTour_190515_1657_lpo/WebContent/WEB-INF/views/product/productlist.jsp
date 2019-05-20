<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<%
String str = request.getServletContext().getRealPath("/upload");
%>

<h1>제품목록</h1>

테스트용
<c:if test="${not empty login and login.id ne '' and login.auth eq '0'}">
<button type="button" onclick="location.href='sellList.do'">주문내역</button>
</c:if>

<c:if test="${not empty login and login.id ne '' and login.auth eq '0'}">
	<button type="button" onclick="location.href='cartlist.do?id=${login.id}'">장바구니</button>
</c:if>
<c:if test="${not empty login and login.id ne '' and login.auth eq '1'}">
	<button type="button" id="_addBtn">제품등록</button>
</c:if>

<table border="1">
<colgroup>
	<col width="300px"><col width="300px"><col width="300px"><col width="300px">
</colgroup>

<c:set var="count" value="1"/>
<c:forEach items="${list}" var="product">

<c:if test="${count == '5'}"><c:set var="count" value="1"/></c:if>
<c:if test="${count == '1'}"><tr></c:if>
	<td>
		<div onclick="moveDetail(${product.product_seq})">
		<table>
		<tr>
			<td>
				<img alt="이미지없음" src="<%=request.getContextPath()%>/upload/${product.thumbNail}" style="width: 150px; height: 150px;">
			</td>
		</tr>	
		<tr>
			<td>
				<c:if test="${product.pcount eq '0'}"><font style="color: red;">[일시품절]</font></c:if>
				[${product.product_seq}] ${product.title}
			</td>
		</tr>
		</table>
		</div>
	</td>
<c:if test="${count == '4'}"></tr></c:if>
<c:set var="count" value="${count+1}"/>

</c:forEach>

</table><br>

<!-- 페이징 ////////////////////// -->
<div class="pgdiv" id="pgdiv">
<span class="pgspan">
	<jsp:include page="paging.jsp">
		<jsp:param name="actionPath" value="productlist.do"/>
		<jsp:param name="nowPage" value="${paging.nowPage}" />
		<jsp:param name="totalCount" value="${paging.totalCount}" />
		<jsp:param name="countPerPage" value="${paging.countPerPage}" />
		<jsp:param name="blockCount" value="${paging.blockCount}" />
		
		<jsp:param name="findWord" value="${paging.findWord}" />
		<jsp:param name="choice" value="${paging.choice}" />
	</jsp:include>
</span>
</div> <!-- end pgdiv -->

<!-- 검색창 ////////////////////// -->
<!-- <div class="clear"></div> -->
<div id="searchDiv">
<form action="productlist.do" method="get" id="_searchForm">
	<select name="choice" id="_choice">
		<option value="title" selected="selected">상품명</option>
	</select>
	<input type="text" name="findWord" id="_findWord" value="">
	<input type="button" value="검색" onclick="searchBtnClick()">
</form>
</div> <!-- end searchDiv -->

<!-- 다운로드는 무조건 post만. get은 안된다. -->
<!-- <form name="file_Down" action="thumbNailDownload.do" method="post">
<input type="hidden" name="thumbNail">
<input type="hidden" name="seq">
</form> -->


<script type="text/javascript">
$(document).ready(function() {
	$("#_addBtn").click(function() {
		location.href = "productwrite.do";
	});
});

function searchBtnClick() {
	//alert("검색버튼 누름");
	$("#_searchForm").submit();
}

/* function filedowns(thumbNail, seq) {
	var doc = document.file_Down;
	doc.thumbNail.value = thumbNail;
	doc.seq.value = seq;
	doc.submit();
} */
function moveDetail( num ) {
	var product_seq = Number(num);
	location.href="productdetail.do?product_seq="+product_seq;
}

</script>

</body>
</html>