<%@page import="lala.com.a.model.QuestionDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.q_title{

	display: none;

}
.email{

	display: none;

}


</style>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<%
List<QuestionDto> qlist = (List<QuestionDto>)request.getAttribute("qlist");

%>
</head>
<body>

아이디:<input type="text" id="id"><br>
<input type="radio" value="질문으로찾기" name="way" id="question">질문으로찾기
<input type="radio" value="이메일전송" name="way" id="send_email">이메일전송

<br>
<form action="findPwdAf1.do" method="post">
<select class="q_title" style="display: none;" name="question">
	<%for(int i =0; i<qlist.size(); i++){ %>
		<option value="<%=qlist.get(i).getSeq() %>"><%=qlist.get(i).getTitle() %></option>
	<%} %>
</select>
<input type="text" name="answer" class="q_title"><br>
<input type="hidden" name="id" id="qId">
<input type="submit" value="확인" class="q_title" id="qok">
 </form> 
 
 
 <form action="findPwdAf2.do" method="post">
<input type="text" value="이메일을 입력하세요." name="email" class="email" id="email">
<input type="hidden" name="id" id="emailId">
<input type="submit" value="전송" class="email" id="email_ok">
 </form>
 
 
<script type="text/javascript">

//질문누르면 이메일 안보임
$("#question").click(function name() {
	
	$(".email").hide();
	$(".q_title").show();
	
});


$("#qok").click(function name() {
	$("#qId").val($("#id").val());
});



//이메일누르면 질문 안보임
$("#send_email").click(function name() {
	
	$(".q_title").hide();
	$(".email").show();
	
	$("#email").click(function name() {
		$("#email").val("");
	});	
	
});

//이메일전송시 id값가져옴
$("#email_ok").click(function name() {
	$("#emailId").val($("#id").val());
});



</script>



</body>
</html>