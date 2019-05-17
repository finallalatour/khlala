<%@page import="lala.com.a.model.ReplyDto"%>
<%@page import="lala.com.a.util.HotelUtil"%>
<%@page import="lala.com.a.util.Singleton"%>
<%@page import="lala.com.a.model.HotelDto"%>
<%@page import="lala.com.a.util.CalendarUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%-- 
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/jquery-ui-1.12.1.custom/jquery-ui.min.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="./jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script>
 --%>
 
<!-- 아임포트 (결제창) -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- 데이트피커 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>




<style type="text/css">

.layout{
display:none;
}
.inputReply{
display:none;
}
.rightExplain{
	text-align: right;
	display: inline-block;
	width: 100%;
	margin: 20px 0 20px 0;
}
h4{
  font-size: 13px;
}
div.wrap > div{
  font-size: 12px;
  position: relative;
  float: left;
  margin-right: 5px;
  height: 30px;
  line-height: 30px;
  vertical-align: middle;
  input{
    line-height: 30px;
    margin: 0;
    padding: 0;
    padding-left: 5px;
    padding-right: 5px;
    width: 100px;
  }  
}
button{
  clear: both;
  display: block;  
  line-height: 40px;
  margin-top: 80px;
  background-color: #eee;  
  color: #333;
  border: 1px solid #666;
  padding-left: 20px;
  padding-right: 20px;
  border-radius: 4px;
}
#ui-datepicker-div{
 top:-999px; 
 border: 0;
 font-size: 14px;
}
.ui-datepicker-header{
  font-size: 13px;
}
.ui-datepicker-calendar{
  background-color: #fff;
  border: 1px solid #ddd;
  
  tr{
    font-size: 11px;
  }
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	

	String strDate = "";
	Singleton s = Singleton.getInstance();
      
	System.out.println("s.Size : " + s.disDate.size());
	if(s.disDate.size() >= 1 && s.disDate != null){
		for(int i = 0; i < s.disDate.size(); i++){
			strDate += "'" + s.disDate.get(i) + "',";
		}
	strDate = strDate.substring(0,strDate.lastIndexOf(","));
	}	
%>
<%
Calendar cal = Calendar.getInstance();
int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH) +1;
int tday = cal.get(Calendar.DATE);
int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
int thour = cal.get(Calendar.HOUR_OF_DAY);
%>

<%
cal.set(Calendar.DATE, 1);			// 1일
HotelDto hotel = (HotelDto)request.getAttribute("hotel");
String syear = request.getParameter("year");
String smonth = request.getParameter("month");
System.out.println("JSP syear : " + syear);
System.out.println("JSP smonth : " + smonth);
int year = cal.get(Calendar.YEAR);
if(CalendarUtil.nvl(syear) == false){	// 파라미터가 넘어 온 경우
	year = Integer.parseInt(syear);
}

int month = cal.get(Calendar.MONTH) + 1;
if(CalendarUtil.nvl(smonth) == false){	// 파라미터가 넘어 온 경우
	month = Integer.parseInt(smonth);
}

if(month < 1){
	month = 12;
	year--;
}
if(month > 12){
	month = 1;
	year++;
}

cal.set(year, month - 1, 1);	// 연월일을 설정

// 요일
int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
System.out.println("dayOfWeek:" + dayOfWeek);

// <<
String pp = String.format("<a href='%s?year=%d&month=%d&seq=%d'>"
							+ "<<</a>", 
							"hoteldetail.do", year-1, month ,hotel.getSeq());
// <
String p = String.format("<a href='%s?year=%d&month=%d&seq=%d'>"
							+ "<</a>", 
							"hoteldetail.do", year, month-1 ,hotel.getSeq());
// >
String n = String.format("<a href='%s?year=%d&month=%d&seq=%d'>"
							+ "></a>", 
							"hoteldetail.do", year, month+1 ,hotel.getSeq());

// >>
String nn = String.format("<a href='%s?year=%d&month=%d&seq=%d'>"
							+ ">></a>", 
							"hoteldetail.do", year+1, month ,hotel.getSeq());
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>
<form action="reserveAf.do" method="post" id="reserveFrm">
<div style="width:1100px; margin:0 100px 0 100px; padding:auto; "align="left">
	<div style="width:526px; float :left">
	     <div class="mainPicture" style="width:100%; height:300px" >
	     	<img src="" id="pictureDetail" style="width:526px; height:300px;">
	     </div>
	
	     <div class="subPicture" style="width:100%; height:90px; margin:20px 0 20px 0;">
	    
	     	<c:forEach items="${pdsList }" var="pds" varStatus="vs">
	     		<img src="<%=request.getContextPath() %>/upload/${pds.fileName_Af }" id="pds${vs.count }" 
	     			style="width: 100px; height:90px" 
	     				class="pdsImg">
	     	</c:forEach>
	     </div>
	</div>
	<div style="float :right; height:430px">
		<div>
			<span class="rightExplain">
				1일 숙박비 : ${hotel.price }
				<input type="hidden" value="${hotel.price }" name="price">
			</span>
			<span class="rightExplain">
				상세 주소 : ${hotel.place }
				<input type="hidden" value="${hotel.place }" name="place">
			</span>
			<h4>기간 선택</h4>
			<div class="wrap">
				
			    <div>
				        시작일
				</div>
			  	<div>
				   	<input type="text" id="from" name="sdate" readonly>
				 	</div>
			  	<div>
			      	~ 종료일
			  	</div>
			  	<div>
			     	<input type="text" id="to" name="edate" readonly>
				 </div>  
			</div>
			<div class="rightExplain">
				결제 금액 : <span id="totalPrice"></span>
				<input type="hidden" id="re_price" name="re_price" value="">
						
			</div>
			<input  type="button" onclick="imp()" value="예약하기">
			<input type="hidden" name="pseq"  value="${hotel.seq }">
			<input type="hidden" name="merchant" id="merchant" value="">
		</div>
	</div>
	
<div align="center" style="float: left">

<table border="1" id="calendar">
<col width="100"><col width="100"><col width="100"><col width="100">
<col width="100"><col width="100"><col width="100">
<tr height="70">
	<td colspan="7" align="center">
		<%=pp %>&nbsp;<%=p %>
		<font color="black" style="font-size: 50px">
			<%=String.format("%d년&nbsp;&nbsp;%2d월", year, month) %>
		</font>
		<%=n %>&nbsp;<%=nn %>	
	</td>
</tr>
<tr height="70">
	<td align="center">일</td>
	<td align="center">월</td>
	<td align="center">화</td>
	<td align="center">수</td>
	<td align="center">목</td>
	<td align="center">금</td>
	<td align="center">토</td>
</tr>

<tr height="70" align="left" valign="top">
<%
// 윗쪽의 빈칸
for(int i = 1;i < dayOfWeek; i++){
	%>	
	<td>&nbsp;</td>	
	<%
}

// 날짜
for(int i = 1;i <= lastDay; i++){
	if(i == 1 ){
		System.out.println("들어옴?");
		s.disDate.clear();
	}
	%>
	<td><%=CalendarUtil.callist(year, month, i) %>
	<%=CalendarUtil.makeTable(year, month, i,hotel.getMaxcount() ) %>
	</td>
	<%
	if((i + dayOfWeek - 1) % 7 == 0 && i != lastDay){
		%>	
		</tr>
		<tr height="70" align="left" valign="top">
		<%
	}	
}

// 밑의 빈칸
for(int i = 0; i < (7 - (dayOfWeek + lastDay - 1) % 7 ) % 7; i++){
	%>	
	<td>&nbsp;</td>	
	<%
}

%>
</tr>
</table>
</div>
</div>
</form>
<div style="width: 1000px;">
<table class="replyTb" style="width: 1000px">

   <c:if test="${empty reply }">
   <tr>
         <td colspan="2" style="text-align: center;">작성된 댓글이 없습니다.</td>
   </tr>
   </c:if>
   <c:if test="${not empty reply }">
   		<c:forEach items="${reply }" var="r" varStatus="vs">
   			<c:if test="${r.del eq '1' }">
   			<%ReplyDto re = (ReplyDto)pageContext.getAttribute("r"); %>
   				<tr>
            		<td></td><td colspan="2"><font color="red"><%=HotelUtil.arrow(re.getStep()) %><b>작성자에 의해 삭제된 댓글입니다.</b></font>
         		</tr>
   			</c:if>
   			
   			<c:if test="${r.del eq'0' }">
   			<tr>
            	<td></td>
               	<td>
               	<%ReplyDto re = (ReplyDto)pageContext.getAttribute("r"); %>
                  <%=HotelUtil.arrow(re.getStep()) %><sapn>${r.name } (${r.wdate }) </sapn>
                  <span class="aRight">
                  <a class="btnReply txtEvent" val1 ="${r.seq }">댓글달기</a>
                  <c:if test="${r.id eq 'ktra0' }">
                  		<a id="delReply" href="rereply.do?seq=${r.seq }&pseq=${r.pseq}" class="txtEvent">삭제</a>
                  </c:if>
                  </span>
             	</td>
         	</tr>
   			</c:if>
   			<tr>
            	<td></td>
            	<td>
            	<%ReplyDto re = (ReplyDto)pageContext.getAttribute("r"); %>
               <%=HotelUtil.arrow(re.getStep()) %>
               <textarea id="showContent"readonly="readonly" rows="5" cols="140" style="border:none;height:auto;resize: none;">${r.content }</textarea>
	            </td>
	         </tr>
	         
	         <tr>
         <td colspan="2">
            <div id="${r.seq }" Class="inputReply" style="display:none" >
            
               <form action="addRereply.do" method="get" id="addRep" onsubmit="return reNullchk02('${r.seq}')" class="replyFrm02">
                  <input type="hidden" name="ref" id="ref" value="${r.ref }" >
                  <input type="hidden" name="step" id="step" value="${r.step }">
                  <input type="hidden" name="pseq" id="pseq" value="${Hotel.seq }">
                  <input type="hidden" name="id" id="id" value="ktra0">
                  <table class="inputReplyTb"> 
                  <col width="20%"><col width="50%"><col width="15%"><col width="15%">
                     <tr>
                        <td colspan="4"style="border-bottom:1px solid #e9e9e9"></td>
                     </tr>
                     <tr>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;ktra0</td>
                        <td><textarea rows="3" cols="110" name="content" id="content" style="resize:none;height:auto"></textarea></td>
                           <td style="padding-left:30px;"><input type="submit" value="댓글달기" class="btn btn-outline-primary btn-sm ver_bottm"></td>
                           <td><input type="button" value="취소" class="btn btn-outline-warning btn-sm ver_bottom" onclick="cancelReply('${r.seq}')"></td>
                      </tr>
                  </table>
               </form>
               
            </div>
            <hr style="border: 1px solid #e8e8e8;">
         </td>
      </tr>
   		</c:forEach>
   </c:if>
</table>
</div>
<form action="addReply.do" method="post" class="replyFrm01">
    <input type="hidden" name="pseq" id="pseq" value="${hotel.seq }">  
    <input type="hidden" name="id" value="ktra0" > 
   <table class="inputReplyTb">
   <col width="20%"><col width="60%"><col width="20%">
 
   <tr>
      <td>라경태</td>
      <td><textarea rows="5" cols="100" name="content" id="content" style="resize:none;height:auto"></textarea></td>
      <td><input type="submit" value="댓글달기" class="btn btn-outline-primary"></td>
   </tr>
   </table>
</form>
<script type="text/javascript">


var IMP = window.IMP;


/* 작은이미지 hover시 메인이미지띄우기 */
$(".pdsImg").hover(function () {
	var _path = $(this).attr("src");
	
	$("#pictureDetail").attr("src",_path);
});
var disableDays;
$(document).ready(function () {
	
	IMP.init('imp00843069');
	
	/* 최초 로딩시 첫 이미지 메인이미지칸에 띄워주기 */
	var _path = $("#pds1").attr("src");
	$("#pictureDetail").attr("src",_path);
	
});



/* 데이트피커 */
var rangeDate = 31; // set limit day
var setSdate, setEdate;
$("#from").datepicker({
    dateFormat: 'yy-mm-dd',
    minDate: 0,
    beforeShowDay: disableAllTheseDays,
    onSelect: function(selectDate){
        var stxt = selectDate.split("-");
            stxt[1] = stxt[1] - 1;
        var sdate = new Date(stxt[0], stxt[1], stxt[2]);
        var edate = new Date(stxt[0], stxt[1], stxt[2]);
            edate.setDate(sdate.getDate() + rangeDate);
        
        $('#to').datepicker('option', {
            minDate: selectDate,
            beforeShow : function () {
            setSdate = selectDate;
        }});
        //to 설정
    }
    //from 선택되었을 때
});

$("#to").datepicker({ 
    dateFormat: 'yy-mm-dd',
    minDate: 0,
    beforeShowDay: disableAllTheseDays,
    onSelect : function(selectDate){
        setEdate = selectDate;
        /* 시작~ 종료 일 사이에 선택불가능한값이 포함되어있으면 막아주기 */
        var sDate = $("#from").val();
		sDate.replace('/', '-');
		
		var listDate = [];
		var disableDays = [<%=strDate%>];
		/* 시작날짜,끝날짜 를 listDate에 담아줌 */
	    getDateRange(sDate, selectDate, listDate);
	    for(i = 0 ; i <listDate.length; i ++){
	    	for ( j = 0 ; j<disableDays.length; j ++){
	    		console.log(listDate[i] +" == " + disableDays[j] + " : " + listDate[i] == disableDays[j] );
	    		if(listDate[i] == disableDays[j]){
	    			/* 시작날 ~ 끝날 중에 방이없는날 포함되어있으면 못하게함 */
	    			alert("예약이 불가능한 날짜가 포함되어 있습니다.");
	    			$("#to").val("");
	    			return;
	    		}
	    	}
	    }
	    var tPrice = ( listDate.length - 1 ) * ${hotel.price};
	    $("#totalPrice").text(tPrice);
	    $("#re_price").val(tPrice);
    }
});
/* 두날짜 사이값 가져오기 */
function getDateRange(startDate, endDate, listDate){
    var dateMove = new Date(startDate);
    var strDate = startDate;

    if (startDate == endDate){
        var strDate = dateMove.toISOString().slice(0,10);
        listDate.push(strDate);
    }else{
        while (strDate < endDate){
        	var strDate = dateMove.toISOString().slice(0, 10);
            listDate.push(strDate);
            dateMove.setDate(dateMove.getDate() + 1);
        }
    }
    return listDate;
};

//특정일 선택막기
function disableAllTheseDays(date) {
	var disableDays = [<%=strDate%>];
    var m = date.getMonth() +1;
    var d = date.getDate();
    var y = date.getFullYear();
    m = String(m)
    d = String(d)
    if(m.length<2){
 	   m = "0" + m;
    }
    if(d.length<2){
 	   d = "0" + d;
    }
    var toDate = y + '-' + m + '-' + d;
    for (i = 0; i < disableDays.length; i++) {
        if($.inArray(toDate,disableDays) != -1) {
            return [false];
        }
    }
    return [true];
}

/* 결제창 */
function imp(){
	var sDate = $("#from").val();
	var eDate = $("#to").val();
	
	if(sDate == "" || sDate == null || eDate =="" || eDate == null){
		alert("날짜를 선택해 주세요");
		return false;
	}
	
	if(!confirm("해당 날짜로 예약하시겠습니까?")){
		return false;
	}
	/* 아임포트 응답 */
	IMP.request_pay({
	    pg : 'html5_inicis',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '${hotel.title}',
	    amount : $("#totalPrice").text(),
	    language: "ko",
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '라경태',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456'
	    /* imp_uid(가맹점번호), merchant_uid(상품고유번호) imp_success(결제성공여부)*/
	}, function(rsp) {
	    if ( rsp.success ) {
	    	$("#merchant").val(rsp.merchant_uid);
			$("#reserveFrm").submit();
	    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
	    	//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
	   		var msg = '결제가 완료되었습니다.';
	   		msg += '\n고유ID : ' + rsp.imp_uid;
	   		msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	   		msg += '\결제 금액 : ' + rsp.paid_amount;
    		msg += '카드 승인번호 : ' + rsp.apply_num;				
	    	
    		alert(msg);
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	        alert(msg);
	    }
	});
}
/* 온서브밋 */
function _reserve(){

	
	
	return true;
}

//대댓글입력창
$(".btnReply").click(function() {
    $("#"+$(this).attr("val1")).show();
 });

//대댓글입력창 숨기기
function cancelReply( divid ){
   $($("#" + divid)).hide();
}

/* 댓글 널체크검사 */
function reNullchk01() {
	   if( $.trim($(".replyFrm01 #content").val())=="" || $.trim($(".replyFrm01 #content").val())==null){
	      alert("내용을 입력해 주세요");
	      return false;
	   }
	   return true;
}
function reNullchk02( id ) {
	   if( $.trim($("#" + id + " #content").val())=="" || $.trim($("#" + id + " #content").val())==null){
	      alert("내용을 입력해 주세요");
	      return false;
	   }
	   return true;
}

</script>
</body>
</html>