<%@page import="java.util.List"%>
<%@page import="lala.com.a.model.ReplyDto"%>
<%@page import="lala.com.a.model.MemberDto"%>
<%@page import="lala.com.a.model.MeetingDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


</style>
</head>

<%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto member = null;
if(ologin != null) {
	  member = (MemberDto)ologin;
}else{
	
	member.setId("guest");
}

%>
 <%
MeetingDto dto = (MeetingDto)request.getAttribute("meetdetail");
 String joinID = (String)request.getAttribute("joinID");
 List<ReplyDto> reply = (List<ReplyDto>)request.getAttribute("reply");
%> 

<body>

<form action="meetUpdate.do">
<table>
<tr>
	<td>작성자</td>
	<td>
		<input type="text" id="writerId" value="<%=dto.getId() %>" readonly="readonly">
	</td>
</tr>

<tr>
	<td>축제</td>
	<td>
		<input type="text" value="<%=dto.getFtitle() %>" readonly="readonly">
	</td>
</tr>

<tr>
	<td>제목</td>
	<td>
		<input type="text" value="<%=dto.getTitle() %>" readonly="readonly" id="title" name="title">  
	</td>
</tr>

<tr>
	<td>내용</td>
	<td>
	<textarea rows="10" cols="20" readonly="readonly" id="content" name="content"><%=dto.getContent() %></textarea>
	</td>
</tr>

<tr>
	<td>모집인원</td>
	<td>
		<input type="text" value="<%=dto.getUsercnt() %>/<%=dto.getMaxcnt() %>" readonly="readonly">
	</td>
</tr>

<tr>
	<td>모집일</td>
	<td>
		<input type="text" value="<%=dto.getEdate() %>" readonly="readonly">
	</td>
</tr>


</table>

<%if(dto.getProgress() == 0 && member.getAuth() == 0 && dto.getId().equals(member.getId())) {%>
<input type="button" value="글수정하기" id="updateContent">
<input type="hidden" value="<%=dto.getSeq() %>" name="seq"> 
<input type="hidden" value="<%=dto.getId() %>" name="id"> 
<input type="submit" value="글수정완료" id="updateContentAf" style="display: none;">
<%} %>
</form>

<%if(dto.getProgress() == 0 && member.getAuth() == 0) {

if(!joinID.equals(member.getId()) && !dto.getId().equals(member.getId()) )  {%>
<form action="meetJoinAf.do">
<input type="hidden" id="memberId" value="<%=member.getId() %>" name="id">
<input type="hidden" value="<%=dto.getSeq() %>" name="seq">
<input type="submit" value="참가하기" onclick="return guestChk(<%=member.getId() %>)">
</form>
<%}else if(dto.getId().equals(member.getId())){%>
<form action="meetEnd.do">
<input type="hidden" value="<%=dto.getSeq() %>" name="seq">
<input type="hidden" value="<%=member.getId() %>" name="id">
<input type="submit" value="마감하기">
</form>

<form action="meetDelete.do">
<input type="hidden" value="<%=dto.getSeq() %>" name="seq">
<input type="submit" value="글 삭제">
</form>

<%}else{ %>
<form action="meetJoinDel.do">
<input type="hidden" value="<%=member.getId() %>" name="id">
<input type="hidden" value="<%=dto.getSeq() %>" name="seq">
<input type="submit" value="참가취소">
<%} %>
</form>
<%}else if(member.getAuth() == 0){%>
<input type="text" readonly="readonly" value="마감">
<%} %>

<script type="text/javascript">

//로그인 안한 사람이 참가하기 버튼누르면
function guestChk( id ){
	
	if(id == 'guest'){
	alert("로그인 후 이용해 주십시오.");
	return false;
	}
	
}

</script>

<form action="meetReply.do" method="get">
<input type="hidden" value="<%=dto.getSeq() %>" name="pseq">
<input type="text" readonly="readonly" value="<%=member.getId() %>" name="id">
<textarea rows="10" cols="20" name="content">
</textarea>
<input type="checkbox" id="secretChk" >비밀댓글
<input type="hidden"  name="lock_" id="lock_" value="0"> 
<input type="submit" value="댓글달기" id="ttest">
</form>
<script type="text/javascript">


//비밀댓글 value 바꾸기 1==> 비밀댓글on
$("#secretChk").change(function () {
	if($("#secretChk").is(":checked")){
		$("#lock_").val("1");
		
	}
});
		

$("#ttest").click(function () {
	
	 alert($("#lock_").val()); 
	 
});
 

</script>

<table>
<%for(int i =0; i<reply.size(); i++){ 
	ReplyDto rlist = reply.get(i);
	//lock이 0이거나 댓글을 단사람과 로그인사람 같거나 작성자 본인이면 글 볼수있게함
	if(rlist.getLock_() == 0   || rlist.getId().equals(member.getId()) || dto.getId().equals(member.getId()) ){ 
	if(rlist.getDel() == 1){
	%>
<tr>
	<td>
	삭제된 댓글입니다.
	</td>
	</tr>
<%}else{ %>
<tr>
	<form action="meetReplyUpdate.do">
	<td>
		<input type="text" value="<%=rlist.getId() %>" readonly="readonly" name="id">
	</td>
	<td>
		<input type="text" value="<%=rlist.getContent() %>" readonly="readonly" id="upcontent<%=i %>" name="content">
	</td>
	<td>
		<input type="text" value="<%=rlist.getWdate() %>" readonly="readonly" name="wdate">
	</td>
	<%if(rlist.getDel() == 2) {%>
	<td>
	(수정됨)
	</td>
	<%}
	
	if(rlist.getId().equals(member.getId()) && rlist.getDel() != 1){ %>	
		<td >
			<input type="button" value="수정하기" onclick="updateReply(<%=i %>)" id="upReply<%=i %>">
			<input type="hidden" name="seq" value="<%=rlist.getSeq() %>">
			<input type="hidden" value="<%=dto.getSeq() %>" name="pseq">
			<input style="display: none;" type="submit" value="수정완료" id="upReplyAf<%=i %>">
			</td>
		</form>	
		<form action="meetReplyDelete.do">
		<td>
			<input type="hidden" value="<%=dto.getSeq() %>" name="pseq">
			<input type="hidden" name="seq" value="<%=rlist.getSeq() %>">
			<input type="hidden" name="id" value="<%=member.getId() %>">
			<input type="submit" value="삭제">
		</td>
		</form>
		
	
	
	<td>
		<a onclick="answerChk(<%=rlist.getSeq() %>)">답글달기</a>
	</td>
</tr>
<%}} %>
<form action="answer.do">
<tr style="display: none;" id="answer<%=rlist.getSeq() %>">
	<td><%=member.getId() %></td>
	<td>
		<textarea rows="10" cols="10" name="content"></textarea>
	</td>
	<td>
		<input type="submit" value="답글달기" >
	</td>
</tr>
<input type="hidden" name="id" value="<%=member.getId() %>">
<input type="hidden" name="pseq" value="<%=dto.getSeq() %>">
<input type="hidden" name="ref" value="<%=rlist.getSeq() %>">
<input type="hidden" name="seq" value="<%=dto.getSeq() %>">
<input type="hidden" name="lock_" value="<%=rlist.getLock_() %>">
</form>
<%}else{%>
<tr>
	<td>비밀댓글입니다.</td>
</tr>	
<%
}
	} %>

</table>
 

<script type="text/javascript">

function answerChk( num ){
	
//	alert("클릭함");
	$("#answer"+num).show();
	
};

function updateReply( num ){
	alert("수정클릭");
	$("#upReplyAf"+num).show();
	$("#upReply"+num).hide();
	
	$("#upcontent"+num).attr("readonly",false); 
	$("#upcontent"+num).focus();

	
};

$("#updateContent").click(function () {
	alert("글수정 클릭됨");
	$("#updateContent").hide();

	$("#content").attr("readonly",false); 
	$("#title").attr("readonly",false); 
	$("#title").focus();
	
	$("#updateContentAf").show();
});


</script>

</body>
</html>