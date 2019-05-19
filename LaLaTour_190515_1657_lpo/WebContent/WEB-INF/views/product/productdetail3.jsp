<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>
 
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<!-- <link rel="stylesheet" type="text/css" href="./css/pslide.css"> -->
 
<style>
.jbMenu {
	text-align: center;
	width: 1500px;
	font-size: 40px;
	color: white;
	background-color: black;
}
.jbFixed {
	position: fixed;
	top: 0px;
}
table, tr, td, th {
	border: 1px solid black;
}
</style> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="div_root" style="width: 100%;">
<div class="div1500" style="width: 1500px;">

<div id="div_detail_top" style="width: 1500px; display: inline-block;">
<div id="div_pic_wrap" style="width: 600px; height: 550px; float:left; /* background-color: red; */">
	<div id="div_pic" style="padding-bottom: 20px;">
		<img alt="" src="<%=request.getContextPath()%>/upload/${fileList[0].fileNameAf}"
			style="width: 600px; height: 400px;">
	</div>
	<div id="div_tn" style="text-align: center;">
		<input type="hidden" id="slide_index" value="0">
		<div id="div_tn1" style="width: 130px; float: left;">
			<button type="button" class="btn btn-primary btn-lg" id="_leftBtn" style="float: right;"><</button>
		</div>
		<div id="div_tn2"  style="width: 340px; float: left;">
			<ul class="als-wrapper">
				<c:forEach items="${fileList}" var="flist">
					<li class="als-item" style="display: none;">
						<img alt="" src="<%=request.getContextPath()%>/upload/${flist.fileNameAf}" 
							style="width: 84px; height: 84px;">
					</li>
				</c:forEach>
		    </ul>
		</div>
		<div id="div_tn3" style="width: 130px; float: left;">
		    <button type="button" class="btn btn-primary btn-lg" id="_rightBtn" style="float: left;">></button>
		</div>
	</div>
</div> <!-- end div_pic_wrap -->

<div id="div_detail_wrap" style="width: 800px; height: 550px; float:right;">
	<div id="div_detail_top">
		<div><h2>${product.title}</h2></div>
		<table>
		<colgroup>
			<col width="180px"><col width="580px">
		</colgroup>
		
		<tr>
			<th>단위수량</th>
			<td>${product.subtitle}</td>
		</tr>
		<tr>
			<th>판매가</th>
			<td>${product.price}원</td>
		</tr>
		<tr>
			<th>원산지</th>
			<td>${product.place}</td>
		</tr>
		<tr>
			<th>판매수량</th>
			<td>${product.pcount}</td>
		</tr>
		<tr>
			<th>등록일</th>
			<td>${product.wdate}</td>
		</tr>
		<tr>
			<th>배송정보</th>
			<td>택배배송 - 평균 2일 이내 배송 (토,일,공휴일 제외)</td>
		</tr>
		<tr>
			<th>배송비</th>
			<td>무료</td>
		</tr>				
		</table>
	</div> <!-- end div_detail_top -->
	
	<div id="div_detail_cart">
		<div id="div_detail_cart_count">
			<div style="display: inline-block;">
				${product.title}<br>
				<span>
					<button type="button" id="mBtn" style="float: left;">-</button>
					<input type="text" id="_myCount" name="myCount" value="1" readonly="readonly" style="width:50px; float:left;">
					<button type="button" id="pBtn" style="float: left;">+</button>
				</span>
				<span class="total" style="float: right;"></span>
			</div><br>
			<div style="display: inline-block;">
				합계 <span class="total" style="font-size: 25px; color: orange;"></span>
			</div>
			<div>
				<c:if test="${login.auth eq '1'}">
					<button type="button" class="btn btn-primary btn-lg" id="_productUpdateBtn" onclick="location.href='productUpdate.do?product_seq=${product.product_seq}'">수정하기</button>
					<button type="button" class="btn btn-secondary btn-lg" id="_productListBtn" onclick="location.href='productlist.do'">목록으로</button>
				</c:if>
				<c:if test="${login.id ne '' and not empty login and login.auth eq '0'}">
					<c:if test="${product.pcount eq '0'}">
						<button type="button" class="btn btn-danger btn-lg" id="_cartinsertBtn" disabled="disabled">일시품절</button>
					</c:if>
					<c:if test="${product.pcount > '0'}">
						<button type="button" class="btn btn-primary btn-lg" id="_cartinsertBtn">장바구니 담기</button>
					</c:if>
					<button type="button" class="btn btn-secondary btn-lg" id="_cartlistBtn">장바구니 이동</button>
				</c:if>
				<c:if test="${login.id eq '' or empty login}">
					<span>구입 하시려면 로그인을 해야 합니다.</span>
				</c:if>
			</div>			
		</div>
	</div>
</div> <!-- end div_detail_wrap -->
</div> <!-- end div_detail_top -->

<!-- 고정메뉴 바 /////////////////////////////////////////////// -->
<div id="div_middleMenu_wrap" class="jbMenu" style="width: 1500px; display:block;">
	<div style="width: 33%; float: left;">
		<a href="#detail">상품상세정보</a>
	</div>
	<div style="width: 34%; float: left;">
		<a href="#goods">고객상품평</a>
	</div>
	<div style="width: 33%; float: left;">
		<a href="#refund">교환 및 반품 안내</a>
	</div>
</div> <!-- end div_middleMenu_wrap -->

<!-- 상품상세정보 /////////////////////////////////////////////// -->
<div class="div_content_wrap" id="detail" style="width: 1500px; display: inline-block; padding: 50px;">
	<div class="subtitle">
		<font style="font-size: 40px;">상품상세정보</font>&nbsp;&nbsp;&nbsp;
	</div> <!-- end subtitle -->
	<br>
	<pre style="width: 100%; height: auto; white-space: pre-wrap;">${product.content}</pre>
</div> <!-- end div_content_wrap -->

<!-- 고객상품평 /////////////////////////////////////////////// -->
<div class="div_goods_wrap" id="goods" style="width: 1500px; display: inline-block; padding: 50px;">
<div class="subtitle">
	<font style="font-size: 40px;">고객상품평<fmt:formatNumber value="${product.ppoint/product.hcount}" pattern=".00"/>(${product.hcount})</font>&nbsp;&nbsp;&nbsp;
	<c:if test="${login.auth eq '0'}">
		<button type="button" class="btn btn-outline-primary btn-lg" onclick="goodsWriteClick()">상품평쓰기</button>
	</c:if>
</div> <!-- end subtitle -->
<br>
<c:if test="${goodsList.size() eq '0'}">
	등록된 상품평이 없습니다
</c:if>
<c:if test="${goodsList.size() > '1' }">
	<table border="1">
	<colgroup>
		<col width="300px"><col width="600px"><col width="300px"><col width="300px">
	</colgroup>
	<c:forEach items="${goodsList}" var="goods">
	<tr>
		<td>
			<c:forEach var="i" begin="1" end="${goods.gpoint}" step="1">
				★
			</c:forEach>
			<c:forEach var="i" begin="${goods.gpoint+1}" end="5" step="1">
				☆
			</c:forEach>
			(${goods.gpoint})
		</td>
		<td>${goods.gcontent}</td>
		<td>${goods.gid}</td>
		<td>${fn:substring(goods.gdate,0,10)}</td>
	</tr>
	</c:forEach>
	</table>
</c:if>
</div> <!-- end div_goods_wrap -->

<!-- 교환 및 반품안내 /////////////////////////////////////////////// -->
<div class="div_refund_wrap" id="refund" style="width: 1500px; display: inline-block; padding: 50px;">
	<div class="subtitle">
		<font style="font-size: 40px;">교환 및 반품 안내</font>
	</div> <!-- end subtitle -->
	<div>
		<table>
		<colgroup>
			<col width="300px"><col width="1200px">
		</colgroup>
		
		<tbody>
		<tr>
			<th>교환/반품/신청기간</th>
			<td>
<pre style="width: 100%; white-space: pre-wrap;">
교환/취소/반품/교환/환불은 배송 완료 후 7일 이내에 가능합니다.
고객님이 받으신 상품의 내용이 표시 광고 및 계약 내용과 다른 경우 상품을 수령하신 날로부터 3개월 이내, 그 사실을 안 날(알 수 있었던 날)부터 30일 이내에 신청이 가능합니다.
</pre>
			</td>
		</tr>
		<tr>
			<th>교환/반품 회수(배송) 비용</th>
			<td>
<pre style="width: 100%; white-space: pre-wrap;">			
상품의 불량/하자 및 표시광고 및 계약 내용과 다른 경우 해당 상품 회수(배송)비용은 무료이나,
고객님의 단순변심 및 색상/사이즈 불만에 관련된 교환/반품의 경우 택배비는 고객님 부담입니다.
</pre>
			</td>
		</tr>
		<tr>
			<th>교환/반품 불가안내</th>
			<td>
<pre style="width: 100%; white-space: pre-wrap;">			
고객님이 상품 포장을 개봉하여 사용 또는 설치 완료되어 상품의 가치가 훼손된 경우 (단, 내용 확인을 위한 포장 개봉의 경우는 예외)
고객님의 단순변심으로 인한 교환/반품 신청이 상품 수령한 날로부터 7일이 경과한 경우
고객님의 사용 또는 일부 소비에 의해 상품의 가치가 훼손된 경우
시간 경과에 따라 상품 등의 가치가 현저히 감소하여 재판매가 불가능한 경우
복제가 가능한 재화 등의 포장을 훼손한 경우(DVD, CD, 도서 등 복제 가능한 상품)
설치상품으로 고객님이 이상 여부를 확인한 후 설치가 완료된 상품의 경우(가전, 가구, 헬스기구 등)
고객님의 요청에 따라 개별적으로 주문제작되는 상품으로 재판매가 불가능한 경우(이니셜 표시상품, 사이즈 맞춤상품 등)
구매한 상품의 구성품이 누락된 경우(화장품 세트, 의류부착 악세서리, 가전제품 부속품, 사은품 등)
기타, 상품의 교환, 환불 및 상품 결함 등의 보상은 소비자분쟁해결기준(공정거래위원회 고시)에 의함
A/S 문의는 제조사로 먼저 문의 시 빠르게 처리 가능하며, 이마트/트레이더스 매장 상품에 한해 점포의 고객만족센터를 방문하시면 A/S 접수 가능
(영수증, 고객주문서 등 증빙서류 지참) / 자세한 문의는 하단 고객센터 번호로 문의
</pre>
			</td>
		</tr>
		</tbody>
		</table>
	</div>
	<br>
</div> <!-- end div_refund_wrap -->


<!-- 댓글 입력창 div -->
<%-- 
<div id="div_reply_wrap" style="width: 1500px; display: inline-block; padding: 50px;">
<h2>댓글</h2>
<div id="rep_insert_div">
<form id="_repForm" method="post">
	<input type="hidden" name="pseq" value="${product.seq}">
	<input type="hidden" name="id" value="${login.id}">
	댓글쓰기 창 [${login.id}] <br> 
	<textarea rows="5" cols="20" name="content" id="_content"></textarea>
	<button type="button" onclick="insertReply()">입력</button>
</form>
</div> --%> <!-- end rep_insert_div --><br>

<!-- 댓글 목록이 나올 div//////////////////////////////////////////////////////////////////////////// -->
<%-- <div id="rep_list_div">
<c:if test="${replyList.size() eq '0' or empty replyList }">
댓글이 없습니다
</c:if>
<c:if test="${replyList.size() > '0' }">
<c:forEach items="${replyList }"  var="reply">
	<div id="reply${reply.seq}">
	<form id="reply${reply.seq}" method="post">
		<table border="1">
		<colgroup>
			<col width="200px"><col width="1000px"><col width="200px"><col width="200px">
		</colgroup>
		<tr>
			<td>${reply.id}</td>
			<td>
				<input type="text" id="content${reply.seq}" style="border: none; width: 100%;" value="${reply.content}" readonly="readonly">
				${reply.content}
			</td>
			<td>${reply.wdate}</td>
			<td>
				<div id="before${reply.seq}">
					<button type="button" onclick="updateView(${reply.seq})">수정</button>
					<button type="button" onclick="deleteReply(${reply.seq})">삭제</button>
				</div>
				<div id="after${reply.seq}" style="display: none;">
					<button type="button" onclick="updateReply(${reply.seq})">완료</button>
					<button type="button" onclick="cancelReply(${reply.seq})">취소</button>
				</div>
			</td>
		</tr>
		</table>
	</form>
	</div>
</c:forEach>
</c:if>
</div> --%> <!-- end rep_list_div -->

<!-- </div> --> <!-- end div_reply_wrap -->
</div> 
</div> <!-- end div_root -->

<form id="cartForm" action="cartinsert.do" method="post">
	<input type="hidden" name="pseq" value="${product.product_seq}">
	<input type="hidden" id="myCount" name="myCount">
	<input type="hidden" name="id" value="${login.id}">
</form>


<script>
var images = $("li.als-item").length;

var total = '${product.price}' * Number( $("#_myCount").val() );
$(".total").append( (total+"원") );

$(document).ready(function() {
	var num = $("#slide_index").val();

	$("li.als-item").slice(num,num+3).attr("style","display: inline;");
	
	// 메뉴고정 시작///////////////// 근데 잘 안되는것 같기도 함
	var jbOffset = $(".jbMenu").offset();
	$(window).scroll(function() {
		if( $(document).scrollTop() > jbOffset.top ) {
			$(".jbMenu").addClass("jbFixed");
		}
		else {
			$(".jbMenu").removeClass("jbFixed");
		}
	});
});

$(document).on("click", "#mBtn", function() {
	var val = Number( $("#_myCount").val() );
	
	if(val>1) {
		val = val-1;
	}
	
	$("#_myCount").val( val );
	showTotal();
});

//제품 총 판매수량(남은수량임)
var pcount = ${product.pcount};
$(document).on("click", "#pBtn", function() {
	var val = Number( $("#_myCount").val() );
	
	if( val==pcount ) {
		alert("현재 재고를 초과할 수 없습니다");
		return;
	}
	else if(val==10) {
		alert("최대 주문수량은 10입니다");
		return;
	}
	else {
		val = val+1;
	}
	
	$("#_myCount").val( val );
	showTotal();
});

$(document).on("change", "#_myCount", function() {
	alert($("#_myCount").val());
});

function showTotal() {
	var total = '${product.price}' * Number( $("#_myCount").val() );
	$(".total").empty();
	$(".total").append( (total+"원") );
}

$(document).on("click", "#_cartinsertBtn", function() {
	$("#myCount").val( $("#_myCount").val() );
	$("#cartForm").submit();
});

$(document).on("click", "#_cartlistBtn", function() {	
	location.href="cartlist.do?id=${login.id}";
});

$(document).on("click", "#_rightBtn", function() {
	//이전 시작값 가져오기
	var num = Number($("#slide_index").val());
	//alert(num);
	
	if( (num+3)>=images ) {
		return;
	}	
	
	var start = num;
	var end = num+3;

	//이전 시작값, 끝값 안보여주기
	$("li.als-item").slice(start,end).attr("style","display: none;");
	
	//이전 시작값에 현재시작값 세팅
	$("#slide_index").val( end );

	//현재 시작값, 끝값 보여주기
	$("li.als-item").slice(end,end+3).attr("style","display: inline;");
});

$(document).on("click", "#_leftBtn", function() {
	//조금전 시작숫자
	var num = Number($("#slide_index").val());
	
	if( num==0 ) {
		return;
	}	
	
	var start = num-3;
	var end = num;

	$("li.als-item").slice(num,num+3).attr("style","display: none;");
	
	$("#slide_index").val( start );

	$("li.als-item").slice(start,end).attr("style","display: inline;");
});

$(document).on("click", "li.als-item", function() {
	$("#div_pic img").attr("src", $(this).children("img").attr("src"));
});

//상품평쓰기 버튼 클릭시
function goodsWriteClick() {
	alert("111");
	
	<%
	if(session.getAttribute("login")==null) {
		%>
		alert("로그인을 해야 합니다");
		return;
		<%
	}
	%>
	
	location.href="sellList.do";
}

/* 
function insertReply() {
	if($("#_content").val().trim()=="" || $("#_content").val().trim().length==0) {
		alert("댓글 내용을 입력해야 합니다");
		return;
	}
	$("#_repForm").attr("action", "insertReply.do").submit();
}

function updateView(seq) {
	$("#content"+seq).css("border", "inherit");
	$("#content"+seq).css("background-color", "#999999");
	$("#content"+seq).removeAttr("readonly");
	
	$("#before"+seq).hide();
	$("#after"+seq).show();
	
	$("#replyListForm").attr("action")
} 
*/

</script>

</body>
</html>



































