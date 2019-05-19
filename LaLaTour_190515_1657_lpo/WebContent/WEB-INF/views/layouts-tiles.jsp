<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>
     
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<tiles:insertAttribute name="header"/>

<link rel="stylesheet" type="text/css"
   href="<%=request.getContextPath() %>/resources/css/layout_css.css">
</head>
<body>
<div>
   <div class="_top" >
      <tiles:insertAttribute name="top_inc"/>
      <tiles:insertAttribute name="top_menu"/>
   </div>
   <div>
      <tiles:insertAttribute name="main"/>
   </div>
   <div>
      <tiles:insertAttribute name="footer"/>
   </div>
</div>
</body>
</html>


