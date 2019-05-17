<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<c:if test="${(empty login) or (login.id eq '') }">
<%
//세션이 보유한 모든 속성 제거
	session.invalidate();
%>
</c:if>

<script>
alert("로그인해주십시오.");
location.href = "login.do";
</script>