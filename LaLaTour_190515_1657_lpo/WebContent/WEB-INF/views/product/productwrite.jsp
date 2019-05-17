<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<h1>제품등록</h1>

<form action="productwriteaf.do" method="post" enctype="multipart/form-data">
<table border="1">
<colgroup>
	<col width="25%"><col width="75%">
</colgroup>

<tbody>
<tr>
	<th>ID</th>
	<td><input type="text" name="id" value="admin"></td>
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
		<input type="file" name="filethumbnail">
	</td>
</tr>
<tr>
	<th>수량</th>
	<td><input type="text" name="pcount" id="_pcount"></td>
</tr>
<tr>
	<th>원산지</th>
	<td><input type="text" name="place" id="_place"></td>
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
		<button type="button" id="faddBtn">추가등록</button>
		<hr>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="제품등록">
		<input type="button" value="제품목록">
	</td>
</tr>
</tbody>
</table>
</form>

<script>
$("#_festivalBtn").click(function() {
	if($("#s_keyword").val()=="") {
		alert("검색어를 입력해야 합니다");
	}
	else {
		getFestivalList();
	}
});

$("#_deleteBtn").click(function() {
	$("#_fseq").val("0");
	$("#f_title").val("");
});

$("#faddBtn").on("click", function() {
	var etag = "<div><input multiple='multiple' type='file' name='fileload'>  ";
	etag += "<button type='button' onclick='delEl(this)'>취소</button><br></div>";
	$("#_imageTd").append(etag);
});

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

$(document).on("click", "#setBtn", function() {
	var fseq = $("input[name=fseqs]:checked").attr("value");
	var ftitle = $("input[name=fseqs]:checked").attr("ftname");
	$("#f_title").val(ftitle);
	$("#_fseq").val(fseq);
	$("#s_keyword").val("");
	$("#demo").empty();
	$("#demo").hide();
});

$(document).on("click", "#cancelBtn", function() {
	$("#s_keyword").val("");
	$("#demo").empty();
	$("#demo").hide();
});

function delEl(obj) {
	$(obj).parent().remove();
}

function check() {
	alert("check in");
	return true;
}

</script>
























