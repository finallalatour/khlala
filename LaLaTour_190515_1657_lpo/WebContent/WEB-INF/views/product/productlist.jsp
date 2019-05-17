<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<%
String str = request.getServletContext().getRealPath("/upload");
%>

<h1>제품목록</h1>
<c:if test="${not empty login and login.id ne '' }">
<button type="button" onclick="location.href='cartlist.do?id=${login.id}'">장바구니</button>
</c:if>
<table border="1">
<colgroup>
	<col width="33.3333%"><col width="33.3333%"><col width="33.3334%">
</colgroup>

<c:set var="count" value="1"/>
<c:forEach items="${list}" var="product">

<c:if test="${count == '4'}"><c:set var="count" value="1"/></c:if>
<c:if test="${count == '1'}"><tr></c:if>
	<td>
		<div onclick="location.href='productdetail.do?seq=${product.seq}'">
		<table>
		<tr>
			<td>
				<%-- <img alt="이미지없음" src="thumbNailDownload.do?thumbNail=${product.thumbNail}&seq=${product.seq}" style="width: 200px; height: 150px;"> --%>
				<img alt="이미지없음" src="<%=request.getContextPath()%>/upload/${product.thumbNail}" style="width: 200px; height: 150px;">
			</td>
		</tr>	
		<tr>
			<td>${product.title}</td>
		</tr>
		</table>
		</div>
	</td>
<c:if test="${count == '3'}"></tr></c:if>
<c:set var="count" value="${count+1}"/>

</c:forEach>





<%-- <tr>
	<c:forEach items="${list}" var="product">
	<td>
		<img alt="이미지없음" src="thumbNailDownload.do?thumbNail=${product.thumbNail}&seq=${product.seq}" style="width: 200px; height: 150px;"><br>
		${product.title}
	</td>
	</c:forEach>
</tr> --%>

</table>

<!-- 다운로드는 무조건 post만. get은 안된다. -->
<form name="file_Down" action="thumbNailDownload.do" method="post">
<input type="hidden" name="thumbNail">
<input type="hidden" name="seq">
</form>



<button type="button" id="_addBtn">제품등록</button>

<script type="text/javascript">
$(document).ready(function() {
	$("#_addBtn").click(function() {
		location.href = "productwrite.do";
	});
});

function filedowns(thumbNail, seq) {
	alert("111");
	var doc = document.file_Down;
	doc.thumbNail.value = thumbNail;
	doc.seq.value = seq;
	doc.submit();
}

</script>

</body>
</html>