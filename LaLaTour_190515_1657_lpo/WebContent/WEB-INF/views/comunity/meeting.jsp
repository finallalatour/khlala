<%@page import="lala.com.a.util.pagingBean"%>
<%@page import="lala.com.a.model.MemberDto"%>
<%@page import="lala.com.a.model.MeetingDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>meeting.jsp</title>
</head>
<body>

<%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto member = null;
if(ologin != null) {
	  member = (MemberDto)ologin;
}else{
	
	member = (MemberDto)ologin;
}

%>
<%
List<MeetingDto> meetlist = (List<MeetingDto>)request.getAttribute("meetlist");
pagingBean paging = (pagingBean)request.getAttribute("paging");

//검색항목, 검색어
String searchWord = request.getParameter("searchWord");
String choice = request.getParameter("choice");

System.out.println("검색항목:" + choice);
System.out.println("검색어:" + searchWord);

if(choice == null || choice.equals("")){
	choice = "sel";
}

//검색어를 지정하지 않고 choice가 넘어 왔을때
if(choice.equals("sel")){
	searchWord = "";
}
if(searchWord == null){
	searchWord = "";
	choice = "sel";
}
System.out.print("되나");


%>

<a href="bbsList.do">자유게시판</a>

<br>
<table>
<tr>
	<th>번호</th><th>참가축제</th><th>제목</th><th>모집현황</th><th>ID</th><th>작성일</th><th>마감여부</th>
</tr>
<%
if(meetlist.size() == 0 || meetlist == null){
%>
<tr>
	<td colspan="6">작성된 글이 없습니다.</td>
</tr>
<%}else{
		int no = meetlist.size();
		for(int i =0; i<meetlist.size(); i++){
			MeetingDto mlist = meetlist.get(i);
			if(mlist.getDel() == 0){
	%>
	<tr>
	<td><%=no %></td><td><%=mlist.getFtitle() %></td><td><a href="meetDetail.do?seq=<%=mlist.getSeq() %>&id=<%=member.getId() %>"><%=mlist.getTitle() %></a></td>
	<td><%=mlist.getUsercnt() %>/<%=mlist.getMaxcnt() %></td><td><%=mlist.getId() %></td><td><%=mlist.getWdate() %></td>
	<td>
	
	<%if(mlist.getProgress() == 1) {%>
	마감완료
	<%}else {%>
	모집중
	<%} %>
	
	</td>
</tr>
<% no--;}} 
}%>

</table>



<jsp:include page="paging.jsp">
	<jsp:param name="actionPath" value="meeting.do" />
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
	
	location.href = "meeting.do?findWord=" + word + "&choice=" + choice;
}



</script>
<a href="meetWrite.do">글쓰기</a>



</body>
</html>