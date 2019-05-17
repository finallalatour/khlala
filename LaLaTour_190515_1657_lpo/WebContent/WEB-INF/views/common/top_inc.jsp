<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<%-- request.setCharacterEncoding("utf-8"); --%>

<jsp:useBean id="nows" class="java.util.Date"/>
<!-- Date nows = new Date(); -->
<div class="_top_inc">
<ul>
	<li><a href="bbslist.do" title="HOME">공지사항</a></li>
	<li><a href="notice.do" title="공지사항">공지사항</a></li>
	<c:if test="${login.id eq '' or empty login}">
		<li><a href="join.do" title="회원가입">회원가입</a></li>
		<li><a href="login.do" title="로그인">로그인</a></li>
	</c:if>
	<c:if test="${login.auth eq '0'}">
		<li><a href="mypage.do" title="마이페이지">마이페이지</a></li>
		<li><a href="logout.do" title="로그아웃">로그아웃</a></li>
	</c:if>
	<c:if test="${login.auth eq '1'}">
		<li><a href="admin.do" title="관리페이지">관리페이지</a></li>
		<li><a href="logout.do" title="로그아웃">로그아웃</a></li>
	</c:if>
	<c:if test="${login.id ne '' and not empty login}">
		<li>[${login.id}]</li>
	</c:if>
</ul>
</div>







