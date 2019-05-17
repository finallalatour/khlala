<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>
<table>
<colgroup>
<col width="33%"><col width="33%"><col width="33%">
</colgroup>
<thead>
</thead>
<tbody>
	<c:if test="${empty hotelList }">
		작성된 글이없습니다.
	</c:if>
	<c:if test="${not empty hotelList }">
		<tr>
			<c:forEach items="${hotelList }" var="hotel" varStatus="vs">
<%-- 				<c:set var="count" value="1"/> --%>
				
					<td>
						<a href="hoteldetail.do?seq=${hotel.seq }">
							<table>
								<tr>
									<td>
										<img alt="이미지없음" src="<%=request.getContextPath() %>/upload/${hotel.thumbnail }" style="width:150px;height: 150px">
									</td>				
								</tr>
								<tr>
									<td>
										${hotel.title }
									</td>
								</tr>
							</table>
						</a>
					</td>
				<c:if test="${vs.count%3 == 0}">
					</tr>
					<tr>
				</c:if>
			</c:forEach>
	</c:if>
</tbody>
</table>
<input type="button" value="글쓰기" onclick="location.href='hotelwrite.do'">