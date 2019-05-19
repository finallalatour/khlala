<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/resources/css/layout_css.css">
<div class="_top_menu">
	<a href="mainpage.do">
		<img src="<%=request.getContextPath() %>/resources/images/logo.png"/ style="float: left">
	</a>
	
	<ul>
		<li><a href="bbslist.do" title="축제">축제</a></li>		
		<li><a href="calendar.do" title="지역명소">지역명소</a></li>
		<li><a href="meeting.do" title="커뮤니티">커뮤니티</a></li>
		<li><a href="hotellist.do" title="숙박">숙박</a></li>
		<li><a href="productlist.do" title="쇼핑">쇼핑</a></li>
		<c:if test="${login.auth eq '1'}">
			<li><a href="pollmake.do">고객센터 리스트</a></li>
		</c:if>
	</ul>	
</div>