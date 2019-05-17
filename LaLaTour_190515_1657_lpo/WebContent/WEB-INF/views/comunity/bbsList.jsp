<%@page import="lala.com.a.util.pagingBean"%>
<%@page import="lala.com.a.model.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
pagingBean paging = (pagingBean)request.getAttribute("paging");

%>

</head>
<body>


<table>
<c:if test="${bbslist.size() eq '0' or empty bbslist}">
<tr>
	<td>작성된 글이 없습니다</td>
</tr>
</c:if>
<c:if test="${bbslist.size()>0}">
<c:forEach items="${bbslist}" var="item">
<tr>
	<td></td>


</tr>
</c:forEach>
</c:if>


</table>







<jsp:include page="paging.jsp">
	<jsp:param name="actionPath" value="bbsList.do" />
	<jsp:param name="nowPage" value="<%=paging.getNowPage() %>" />
	<jsp:param name="totalCount" value="<%=paging.getTotalCount() %>" />
	<jsp:param name="countPerPage" value="<%=paging.getCountPerPage() %>" />
	<jsp:param name="blockCount" value="<%=paging.getBlockCount() %>" />
	
	<jsp:param name="findWord" value="<%=paging.getFindWord() %>" />
	<jsp:param name="choice" value="<%=paging.getChoice() %>" />
</jsp:include>

<div align="center">



<select id="choice">
<option value="sel">선택</option>
<option value="title">제목</option>
<option value="writer">작성자</option>
<option value="content">내용</option>
</select>

<input type="text" id="search" value="">
<button onclick="searchMeet()">검색</button>
</div>

<hr>

<script type="text/javascript">
function searchMeet() {
	var choice = document.getElementById("choice").value;
	var word = $("#search").val();
//	alert(choice);
//	alert(word);
	
	if(word == ""){
		document.getElementById("choice").value = 'sel';		
	}
	
	location.href = "bbsList.do?findWord=" + word + "&choice=" + choice;
}



</script>




</body>
</html>