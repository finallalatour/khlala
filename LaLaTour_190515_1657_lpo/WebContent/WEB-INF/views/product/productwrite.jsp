<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<div style="width: 1500px;">
<h1>제품등록</h1>

<form action="productwriteaf.do" id="_frmWrite" method="post" enctype="multipart/form-data">
<table border="1">
<colgroup>
	<col width="100px"><col width="500px">
</colgroup>

<tbody>
<tr>
	<th>ID</th>
	<td><input type="text" name="id" value="admin" readonly="readonly"></td>
</tr>
<tr>
	<th>제목</th>
	<td><input type="text" name="title" id="_title"></td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="5" cols="20" name="content" id="_content"></textarea>
	</td>
</tr>
<tr>
	<th>썸네일</th>
	<td>
		<input type="file" name="filethumbnail" accept=".jpg, .jpeg, .png, .bmp, .gif, .jfif">
	</td>
</tr>
<tr>
	<th>수량</th>
	<td><input type="text" name="pcount" id="_pcount"></td>
</tr>
<tr>
	<th>원산지</th>
	<td>
	<select name="place1" id="_place1">
		<option value="서울특별시" selected="selected">서울특별시</option>
        <option value="경기도">경기도</option>
        <option value="강원도">강원도</option>
        <option value="충청도">충청도</option>
        <option value="전라도">전라도</option>
        <option value="경상도">경상도</option>
        <option value="제주도">제주도</option>
	</select><br>
	상세 주소 : <input type="text" name="place2" id="_place2">
	<input type="hidden" name="place" id="_place">
	</td>
</tr>
<tr>
	<th>관련축제</th>
	<td>
		<input type="text" id="f_title" readonly="readonly" placeholder="축제를 검색해 주세요">
		<button type="button" id="_deleteBtn">취소</button>
		<br><hr>
		<input type="hidden" name="fseq" id="_fseq" value="0">
		<input type="text" id="s_keyword" placeholder="축제 검색어 입력">
		<button type="button" id="_festivalBtn">검색</button>
		<div id="demo" class="demo" style="display: none;">
		</div>
	</td>
</tr>
<tr>
	<th>가격</th>
	<td><input type="text" name="price" id="_price"></td>
</tr>
<tr>
	<th>이미지</th>
	<td id="_imageTd">
		<button type="button" id="faddBtn">입력추가</button>
		<hr>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="button" value="제품등록" onclick="check()">
		<input type="button" value="제품목록" onclick="location.href='productlist.do'">
	</td>
</tr>
</tbody>
</table>
</form>
</div>

<script>
//축제검색 버튼 클릭
$("#_festivalBtn").click(function() {
	if($("#s_keyword").val()=="") {
		alert("검색어를 입력해야 합니다");
	}
	else {
		getFestivalList();
	}
});

//축제 삭제 버튼
$("#_deleteBtn").click(function() {
	$("#_fseq").val("0");
	$("#f_title").val("");
});

//파일입력 버튼 클릭
$("#faddBtn").on("click", function() {
	var etag = "<div><input multiple='multiple' type='file' name='fileload' accept='.jpg, .jpeg, .png, .bmp, .gif, .jfif'>";
	etag += "<button type='button' onclick='delEl(this)'>취소</button><br></div>";
	$("#_imageTd").append(etag);
});

//파일입력폼 중 하나를 지울때, 엘리먼트 삭제시킴
function delEl(obj) {
	$(obj).parent().remove();
}

//축제검색 시 목록가져와서 화면에 뿌려줄 ajax
function getFestivalList() {
	$.ajax({
		url: "getFestivalList.do",
		type: "get",
		data: { s_keyword:$("#s_keyword").val() },
		
		success: function(data) {
			//alert("ss");
			var list = data.list; //list로 날아왔음
			$("#demo").empty();
			$("#demo").show();
			
			if(list.length==0) {
				alert("검색된 축제가 없습니다");
				$("#s_keyword").val("");
				$("#demo").empty();
				$("#demo").hide();
			}
			else {
				for(i=0; i<list.length; i++) {
					if(i==0) {
						var tag = "<input type='radio' name='fseqs' value='" + list[i].seq + "' ftname='" + list[i].title + "' checked='checked'>" + list[i].title;
					}
					else {
						var tag = "<input type='radio' name='fseqs' value='" + list[i].seq + "' ftname='" + list[i].title + "'>" + list[i].title;
					}
					$("#demo").append(tag + "<br>");
					//$("#demo").innerHTML(tag);
				}
				
				var tag = "<button type='button' id='setBtn'>선택</button> ";
				$("#demo").append(tag);
				var tag = "<button type='button' id='cancelBtn'>취소</button>";
				$("#demo").append(tag);
			}
		},
		error: function(r,s,err) {
			alert("error");
		}
	});
}

//축제 검색해서 하나를 선택하면 등록
$(document).on("click", "#setBtn", function() {
	var fseq = $("input[name=fseqs]:checked").attr("value");
	var ftitle = $("input[name=fseqs]:checked").attr("ftname");
	$("#f_title").val(ftitle);
	$("#_fseq").val(fseq);
	$("#s_keyword").val("");
	$("#demo").empty();
	$("#demo").hide();
});

//축제검색했지만 등록안할때, 축제목록사라짐
$(document).on("click", "#cancelBtn", function() {
	$("#s_keyword").val("");
	$("#demo").empty();
	$("#demo").hide();
});

function check() {
	//제목 공백 안돼요
	var title = $("#_title").val().trim();
	$("#_title").val(title);
	if(title=="" || title.length==0) {
		alert("제목을 입력하세요");
		return false;
	}
	
	//내용 공백 안돼요
	var content = $("#_content").val();
	if(content=="" || content.length==0) {
		alert("내용을 입력하세요");
		return false;
	}
	
	//썸네일 등록 확인
	var thumb = document.getElementsByName("filethumbnail");
	if(thumb[0].files.length==0) {
		alert("썸네일을 등록해야 합니다");
		return false;
	}
	
	//수량 등록 및 숫자만 썼는지 확인
	var regPcount = /^[0-9]/g;
	if( !regPcount.test($("#_pcount").val()) ) {
		alert("숫자만 입력하세요");
		return false;
	}
	
	//원산지 체크
	alert($("#_place1").val());
	var places = $("#_place2").val().trim();
	$("#_place2").val(places);
	if(places=="" || places.length==0) {
		alert("지역을 입력하세요");
		return false;
	}
	$("#_place").val( $("#_place1").val() + " " + $("#_place2").val() );
	
	//다중파일 개수 확인 (10개까지만 허용)
	var obj = document.getElementsByName("fileload");
	var flength = 0;
	for(var i=0; i<obj.length; i++) {
		flength += obj[i].files.length;
	}
	if(flength>10) {
		alert("파일은 10개까지만 첨부할 수 있습니다.");
		return false;
	}
	
	//가격 등록 및 숫자만 썼는지 확인
	var regPrice = /^[0-9]/g;
	if( !regPrice.test($("#_price").val()) ) {
		alert("숫자만 입력하세요");
		return false;
	}
	
	//폼전송 해야한다.
	$("#_frmWrite").submit();
}

</script>
























