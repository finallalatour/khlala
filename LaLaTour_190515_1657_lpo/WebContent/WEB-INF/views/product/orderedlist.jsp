<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<script type="text/javascript" src="//cdn.poesis.kr/post/popup.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<h1>장바구니</h1>
<div>

<div style="width: 1500px;">
<form method="post" id="_finalForm">
<input type="hidden" name="inseq" id="_inseq" value="3">
<table border="1">
<colgroup>
	<col width="300px"><col width="600px">
	<col width="300px"><col width="300px">
</colgroup>

<thead>
<tr>
	<th>상품</th>
	<th>상품명</th>
	<th>수량</th>
	<th>금액</th>
</tr>
</thead>

<tbody>
<c:forEach items="${olist}" var="item">
<tr>
	<td>
		<img src="<%=request.getContextPath()%>/upload/${item.thumbNail}" style="width: 100px; height: 100px;">
	</td>
	<td>
		<a href="productdetail.do?seq=${item.pseq}">${item.title}</a>
		<input type="hidden" name="seq" value="${item.seq}">
	</td>
	<td>
		<input type="text" id="_myCount" name="myCount" price="${item.price}" value="${item.myCount}" readonly="readonly" style="width:50px; float:left;">
	</td>
	<td>
		<span class="total">
			<c:set var="tprice" value="${item.myCount * item.price}"/>
			${tprice}원
		</span>
	</td>
</tr>
</c:forEach>
<tr>
	<td colspan="5" style="text-align: right;">
		결제금액: 
		<input type="text" id="_otprice" name="otprice" style="border: 0px none; text-align: right;">원
		<button type="button" id="_finalBtn" onclick="pay()">결제하기</button>
	</td>
</tr>
</tbody>
</table>
</form> <!-- end _finalForm -->
<br><br>

<input type="radio" name="customer" value="0" checked="checked">주문자와 동일
<input type="radio" name="customer" value="1">수취인 정보 입력

<div style="width: 1500px;">
<div id="customer1">
<form method="post" name="frmCustomer1" id="_frmCustomer1">
<table border="1">
<colgroup>
	<col width="20%"><col width="80%">
</colgroup>

<tbody>
<tr>
	<th>주문자 ID</th>
	<td>
		${login.id}
		<input type="hidden" name="oid1" id="oid1" value="${login.id}">
	</td>
</tr>
<tr>
	<th>받는 분 이름</th>
	<td>
		${login.name}
		<input type="hidden" name="oname1" id="oname1" value="${login.name}">
	</td>
</tr>
<tr>
	<th>받는 분 전화번호</th>
	<td>
		${login.phone}
		<input type="hidden" name="ophone1" id="ophone1" value="${login.phone}">
	</td>
</tr>
<tr>
	<th>받는 분 주소</th>
	<td>
		${login.address}
		<input type="hidden" name="oaddress1" id="oaddress1" value="${login.address}">
	</td>
</tr>
</tbody>
</table>
</form>
</div> <!-- end customer1 -->

<div id="customer2" style="display: none;">
<form method="post" name="frmCustomer2" id="_frmCustomer2">
<table border="1">
<colgroup>
	<col width="20%"><col width="80%">
</colgroup>

<tbody>
<tr>
	<th>주문자 ID</th>
	<td>
		${login.id}
		<input type="hidden" name="oid2" id="oid2" value="${login.id}">
	</td>
</tr>
<tr>
	<th>받는 분 이름</th>
	<td>
		<input type="text" name="oname2" id="oname2">
	</td>
</tr>
<tr>
	<th>받는 분 전화번호</th>
	<td>
		<select id="phone1">
			<option value="010" selected="selected">010</option>
		   	<option value="011">011</option>
		</select>-
		<input type="text" id="phone2" size="10">-
		<input type="text" id="phone3" size="10">
		<input type="hidden" name="ophone2" id="ophone2" size="20" value="">
   </td>
</tr>
<tr>
	<th>받는 분 주소</th>
	<td>
		<div>
		    <p>
		        <label>우편번호&nbsp;</label><input type="text" size="4" class="postcodify_postcode6_1" id="post1" readonly="readonly" /> &ndash;
		        <label></label><input type="text" size="4" class="postcodify_postcode6_2" id="post2" readonly="readonly" /> &nbsp;
		        <input type="button" value="검색" id="postcodify_search_button">
		    </p>
		    <p><label style="padding-left:30px">주소&nbsp;</label><input type="text" class="postcodify_address" id="address1" readonly="readonly" style="width:450px;"/></p>
		    <p><label>상세주소&nbsp;</label><input type="text" class="postcodify_details" id="address2" style="width:450px;"></p>
		</div>
		<input type="hidden" name="oaddress2" id="oaddress2" size="20" value="">
   </td>
</tr>
</tbody>
</table>
</form>
</div> <!-- end customer2 -->
</div>

</div>
</div>

<form id="_frmFinal" method="post">
	<input type="hidden" name="oid" id="oid">
	<input type="hidden" name="oname" id="oname">
	<input type="hidden" name="ophone" id="ophone">
	<input type="hidden" name="oaddress" id="oaddress">
	<input type="hidden" name="otprice" id="otprice">
</form>

<script>
$(document).on("change", "input[name=customer]", function() {
	if($(this).val()==0) {
		$("#customer2").hide();
		$("#customer1").show();
	}
	else {
		$("#customer1").hide();
		$("#customer2").show();
	}
});

//$("#search_button").postcodifyPopUp();

var idck = false;
var wid = "";

$(document).ready(function() {
   $("#postcodify_search_button").postcodifyPopUp();
   
   	//var obj = $("#_myCount");
	var money = 0;
	var obj = document.getElementsByName("myCount");

	for(var i=0; i<obj.length; i++) {
		money += Number(obj[i].getAttribute("price")) * Number(obj[i].value);
	}
	
	$("#_otprice").val( money );
});

function check() {
	alert("check in!!!");
   if($("#oname2").val().trim()=="") {
      alert("이름을 입력해야 합니다.");
      $("#oname2").focus();
      return false;
   }
   if($("#phone2").val().trim()=="" || $("#phone3").val().trim()=="") {
      alert("연락처를 입력해야 합니다.");
      return false;
   }
   if($("#address1").val().trim()=="" || $("#address2").val().trim()=="") {
      alert("주소를 입력해야 합니다.");
      return false;
   }
   
   $("#ophone2").val( $("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val() );
   var adrs = "["+$("#post1").val()+"-"+$("#post2").val()+"] " + $("#address1").val() + " " + $("#address2").val();
   $("#oaddress2").val(adrs);
   
   if(valcName()==false || valcPhone()==false) {
      return false;
   }
   return true;
}

function valcPhone() {
   var regPhone = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
   if( regPhone.test($("#ophone2").val())==false ) {
      alert("잘못된 연락처입니다");
      return false;
   }
   return true;
}

function valcName() {
   var regSpace = /\s/g;
   if( regSpace.test($("#oname2").val().trim())==true ) {
      alert("이름에 공백이 있습니다");
      return false;
   }
   return true;
}



//////////////////////////////////
function pay() {
	var frms;
	
	var checkedValue = Number($("input[name=customer]:checked").val());
	
	if( checkedValue==0 ) {
		$("#oid").val( $("#oid1").val() );
		$("#oname").val( $("#oname1").val() );
		$("#ophone").val( $("#ophone1").val() );
		$("#oaddress").val( $("#oaddress1").val() );
		//frms = $("#_frmFinal").serialize();
	}
	else {
		if(check()==false) {
			alert("다시 확인하세요");
			return;
		}
		$("#oid").val( $("#oid2").val() );
		$("#oname").val( $("#oname2").val() );
		$("#ophone").val( $("#ophone2").val() );
		$("#oaddress").val( $("#oaddress2").val() );
	}
	$("#otprice").val( $("#_otprice").val() );
	frms = $("#_frmFinal").serialize();
	
	/////////////////////////////////////////////////////////////

   	jQuery.ajax({
   		type: "POST",
   		url: "orderedinsert.do",
   		data: frms,
   		
   		//url: "/payments/complete", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
   		//type: 'POST',
   		//dataType: 'json',
   		/* data: {
    		imp_uid : rsp.imp_uid
    		//기타 필요한 데이터가 있으면 추가 전달
   		} */
   		success: function( seq ) {
   			//alert("success");
   			alert("ajax send seq: " + seq);
   			$("#_inseq").val(seq);
   			alert("before finalForm submit()");
   			$("#_finalForm").attr("action", "changecart.do").submit();
   		},
   		error: function(x, s, e) {
   			alert("error");
   		}
   	}).done(function(data) {
   		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
   		if ( everythings_fine ) {
   			var msg = '결제가 완료되었습니다.';
   			msg += '\n고유ID : ' + rsp.imp_uid;
   			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
   			msg += '\결제 금액 : ' + rsp.paid_amount;
   			msg += '카드 승인번호 : ' + rsp.apply_num;

   			alert(msg);
   		} else {
   			//[3] 아직 제대로 결제가 되지 않았습니다.
   			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
   		}
   	});
}















//////////////////////////////////
function pay2() {
	var frms;
	
	var checkedValue = Number($("input[name=customer]:checked").val());
	
	if( checkedValue==0 ) {
		$("#oid").val( $("#oid1").val() );
		$("#oname").val( $("#oname1").val() );
		$("#ophone").val( $("#ophone1").val() );
		$("#oaddress").val( $("#oaddress1").val() );
		//frms = $("#_frmFinal").serialize();
	}
	else {
		if(check()==false) {
			alert("다시 확인하세요");
			return;
		}
		$("#oid").val( $("#oid2").val() );
		$("#oname").val( $("#oname2").val() );
		$("#ophone").val( $("#ophone2").val() );
		$("#oaddress").val( $("#oaddress2").val() );
	}
	$("#otprice").val( $("#_otprice").val() );
	frms = $("#_frmFinal").serialize();
	
	/////////////////////////////////////////////////////////////
	
	var IMP = window.IMP; // 생략가능
	IMP.init('imp92805508'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

	IMP.request_pay({
	    pg : 'inicis', // version 1.1.0부터 지원.
	    //pay_method : 'trans',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '주문명:결제테스트',
	    amount : Number($("#_otprice").val()),
	    buyer_name : "'" + $("#oname").val() + "'",
	    buyer_tel : "'" + $("#ophone").val() + "'",
	    buyer_addr : "'" + $("#oaddress").val() + "'"//,
	    //buyer_postcode : '123-456'//,
	    //m_redirect_url : 'https://www.yourdomain.com/payments/complete'
	}, function(rsp) {
	    if ( rsp.success ) {
	    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
	    	jQuery.ajax({
	    		type: "POST",
	    		url: "orderedinsert.do",
	    		data: frms,
	    		
	    		//url: "/payments/complete", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
	    		//type: 'POST',
	    		//dataType: 'json',
	    		/* data: {
		    		imp_uid : rsp.imp_uid
		    		//기타 필요한 데이터가 있으면 추가 전달
	    		} */
	    		success: function( seq ) {
	    			//alert("success");
	    			alert("ajax send seq: " + seq);
	    			$("#_inseq").val(seq);
	    			alert("before finalForm submit()");
	    			$("#_finalForm").attr("action", "changecart.do").submit();
	    		},
	    		error: function(x, s, e) {
	    			alert("error");
	    		}
	    	}).done(function(data) {
	    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
	    		if ( everythings_fine ) {
	    			var msg = '결제가 완료되었습니다.';
	    			msg += '\n고유ID : ' + rsp.imp_uid;
	    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	    			msg += '\결제 금액 : ' + rsp.paid_amount;
	    			msg += '카드 승인번호 : ' + rsp.apply_num;

	    			alert(msg);
	    		} else {
	    			//[3] 아직 제대로 결제가 되지 않았습니다.
	    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
	    		}
	    	});
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;

	        alert(msg);
	    }
	});
}

function paytest() {
	//alert("결제가 완료되었습니다.");
	
	var frms;
	
	var checkedValue = Number($("input[name=customer]:checked").val());
	
	if( checkedValue==0 ) {
		$("#oid").val( $("#oid1").val() );
		$("#oname").val( $("#oname1").val() );
		$("#ophone").val( $("#ophone1").val() );
		$("#oaddress").val( $("#oaddress1").val() );
		//frms = $("#_frmFinal").serialize();
	}
	else {
		if(check()==false) {
			alert("다시 확인하세요");
			return;
		}
		$("#oid").val( $("#oid2").val() );
		$("#oname").val( $("#oname2").val() );
		$("#ophone").val( $("#ophone2").val() );
		$("#oaddress").val( $("#oaddress2").val() );
	}
	$("#otprice").val( $("#_otprice").val() );
	frms = $("#_frmFinal").serialize();
	
	$.ajax({
		type: "POST",
		url: "orderedinsert.do",
		data: frms,
		
		success: function( seq ) {
			//alert("success");
			alert("ajax send seq: " + seq);
			$("#_inseq").val(seq);
			alert("before finalForm submit()");
			$("#_finalForm").attr("action", "changecart.do").submit();
		},
		error: function(x, s, e) {
			alert("error");
		}
	});
	
	//location.href="orderedok.do";
}


</script>






















