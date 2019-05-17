<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>

<!-- local CSS -->
<link rel="stylesheet" href="../css/login.css">

<title>라라클리닉 역삼점 - 로그인</title>


</head>
<body style="margin:0px">


<%
String msg = request.getParameter("msg");
if( !(msg==null || msg.equals("")) ) {
   %>
   <script type="text/javascript">
   alert("<%=msg %>");
   location.href = "login.jsp";
   </script>
   <%
}
%>
<!-- <input type="checkbox" id="saveid">id저장 -->

<div id="login_container">
	<div id="login_box">
		<div id="uni_container">
			<p style="font-weight:bold; font-size:14pt;" class="login">라라투어 로그인</p>			
			<div style="margin:30px auto; width:200px;">
		   		<form action="loginaf.do" method="post" onsubmit="return check()">
					<div>
			   			<input type="text" name="id" id="id" style="border:1px solid #e8e8e8; width:320px; height:49px;" placeholder="아이디 입력">
					</div>
					<div>
			   			<input type="password" name="pwd" id="pwd" style="border:1px solid #e8e8e8; width:320px; height:49px; margin-top:5px;" placeholder="비밀번호 입력">
					</div>   
					<div>
			   			<!-- <input type="image" src="./images/main/login_btn.png" style="margin-top:20px;"> -->
			   			<button type="submit" id="_loginBtn">로그인</button>
					</div>   
					<div style="margin-top:20px;">
			   			<!-- <a href="../member/join.jsp" style="font-weight:bold; color:#626262;" class="joinbox">· 회원가입</a> -->
			   			<button type="button" id="_joinBtn">회원가입</button>
			   			<button type="button" id="findId">아이디찾기</button>
			   			<button type="button" id="findPwd">비밀번호찾기</button>
					</div>
		      	</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	// 쿠키생성 - 키값: user_id
	//var user_id = $.cookie("user_id");

	//지정된 쿠키가있을 때,
	//텍스트박스에 적어놓고, 체크박스도 체크해 놓는다.
	if($.cookie("user_id") != null) {
        alert("저장된 쿠키가 있음");
        $("#id").val( $.cookie("user_id") );
		$("#saveid").attr("checked", "checked");
	}

	//체크박스 눌렀을 때
	$("#saveid").click(function() {
        // 클릭을 했는데 체크박스에 체크가 됐을 때때
        //if($("input:checkbox[id='chk_save_id']").is(":checked"))
		if( $("#saveid").is(":checked") ) {
			// 아이디를 안썼으면, 체크해제
			if($("#id").val().trim()==""){
				alert("id를 입력하세요.");
				$("#saveid").prop("checked", false);
			}
         	// 아이디가 적혔으면 쿠키에 저장
         	else {
				// 7일동안 유지, 어느경로던 받아들이겠다.
              	// user_id로 id의 value를 받겠다.
              	$.cookie("user_id", $("#id").val().trim(), {expires:7, path:"/"});
         	}
		}
		// 클릭했는데 체크가 없어짐
		// 그렇다면 세션삭제
		else {
			$.removeCookie("user_id", {path:"/"});
		}
	});
	
/* 	$("#_loginBtn").click(function() {
		location.href="login.do";
	}); */
	$("#_joinBtn").click(function() {
		location.href="join.do";
	});
});

function check() {
   	if($("#id").val().trim()=="") {
		alert("ID를 입력해야 합니다.");
      	$("#id").focus();
      	return false;
   	}
   	if($("#pwd").val().trim()=="") {
      	alert("비밀번호를 입력해야 합니다.");
      	$("#pwd").focus();
      	return false;
   	}

   return true;
}
$("#findId").click(function () {
	
	location.href="findId.do";
	
	
});

$("#findPwd").click(function () {
	
	location.href="findPwd.do";
	
	
});
</script>

</body>
</html>


