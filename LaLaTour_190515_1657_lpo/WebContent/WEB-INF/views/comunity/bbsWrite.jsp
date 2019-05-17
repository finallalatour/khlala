<%@page import="lala.com.a.model.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto member = null;
if(ologin != null) {
	  member = (MemberDto)ologin;
}

%>
</head>
<body>
<table>
<tr>
	<td>작성자</td>
	<td>
		<input type="text" name="id" readonly="readonly" value="<%=member.getId() %>">
	</td>
</tr>

<tr>
	<td>제목</td>
	<td>
		<input type="text" name="title">
	</td>
</tr>

<tr>
	<td>내용</td>
	<td>
		<textarea rows="10" cols="20" name="content"></textarea>
	</td>
</tr>


</table>

</body>
</html>