<%@page import="lala.com.a.model.FestivalDto"%>
<%@page import="java.util.List"%>
<%@page import="lala.com.a.model.MeetingDto"%>
<%@page import="lala.com.a.model.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
//사용자 세션
Object ologin = session.getAttribute("login");
MemberDto member = null;
if(ologin==null) {
   %>
 <script type="text/javascript">
   alert("로그인을 해주세요.");
   location.href="login.do";
  </script>
   <%
}
else {
   member = (MemberDto)ologin;
   
}
List<FestivalDto> meetwrite = (List<FestivalDto>)request.getAttribute("meetwrite");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

 <!-- jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
 <!-- jQuery 기본 js파일 -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
 <!-- jQuery UI 라이브러리 js파일 -->
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  
</head>
<body>

<form action="meetWriteAf.do" method="post">
<table border="1">
<col width="30%">
<tr>
	<td>축제선택</td>
	<td>
		<select name="meet_loc" id="meet_loc">
			<%for(int i =0; i<meetwrite.size(); i++){
				%>	
				<option value="<%=meetwrite.get(i).getSeq() %>"><%=meetwrite.get(i).getTitle() %></option>
				<% 
			}
			%>
			
		</select> 
	</td>
</tr>

<tr>
	<td>제목</td>
	<td>
		<input type="text" name="title" id="title">
	</td>
</tr>

<tr>
	<td>내용</td>
	<td>
		<textarea rows="10" cols="20" name="content" id="content"></textarea>
	</td>
</tr>

<tr>
	<td>모집인원</td>
	<td>
		<input type="text" name="maxcnt" id="maxcnt" onblur="return numChk( this.value )">
	</td>
</tr>

<tr>
	<td>모집일</td>
	<td>
		<input type="text" id="edate" name="edate">
	</td>
</tr>


</table>
<input type="hidden" name="id" value="<%=member.getId() %>">
<input type="submit" value="확인" id="ok">

</form>

<script type="text/javascript">


 function numChk( num ) {
	
	//alert(num);
	
	if( !isNaN(num) && num>0){
		
		return true;
	}
	else{
		alert("숫자를입력해주세요");
		$("#maxcnt").val("");
		return false;
	}
	
} 
$("#ok").click(function () {

	if($("#title").val().trim() == null || $("#title").val().trim() == ""){
		
		alert("제목을 입력하세요");
		$("#title").focus();
		return false;
	}
	
	 if($("#content").val().trim() == null || $("#content").val().trim() == ""){
		
		alert("내용을 입력하세요");
		$("#content").focus();
		return false;
	} 
	
	if($("#maxcnt").val().trim() == null || $("#maxcnt").val().trim() == ""){
		
		alert("모집인원을 입력하세요");
		//$("#maxcnt").focus();
		return false;
	}
	 
	
	//현재날짜 이후만 설정가능
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	
	if(month < 10){
		
		month = "0"+month;
	}
	if(day < 10){
		
		day = "0"+day;
	}
	var today = year+month+day;
	//alert(today);
	
	if($( "#edate" ).val() < today){
		alert("날짜를 다시 선택하세요");
		
		return false;
		
	}else{
		
		
		return true;
	}
	
	
	
	
	
});
$(function() {
	
    $( "#edate" ).datepicker({
       showButtonPanel: true,  
        currentText: '오늘 날짜', 
        closeText: '닫기', 
        dateFormat: "yymmdd",
        dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
             dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
             monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
             monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
             changeMonth: true, 
             changeYear: true,
             nextText: '다음 달',
             prevText: '이전 달'
              
    });
   
    
   
}); 

</script>

</body>
</html>