<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>
<form name="frmFrom" id="_frmForm" action="hotelwriteAf.do" method="post" enctype="multipart/form-data" onsubmit="return submitChk()">
<table>
<tr>
	<th>호텔명</th>
	<td>
		<input type="text" name="title" value="">
	<td>
</tr>
<tr>
	<th>지역</th>
	<td>
		<select name="place1" id="place1">
			<option value="서울특별시">서울특별시</option>
			<option value="경기도">경기도</option>
			<option value="강원도">강원도</option>
			<option value="충청도">충청도</option>
			<option value="전라도">전라도</option>
			<option value="경상도">경상도</option>
			<option value="제주도">제주도</option>
		</select>
		상세 주소 : <input type="text" value="" name="place2" id="place2">
		<input type="hidden" value="" name="place" id="place">
	<td>
</tr>
<tr>
	<th>객실 수</th>
	<td>
		<input type="text" name="maxcount" value="">
	</td>
</tr>
<tr>
	<th>사진첨부</th>
	<td>
		<input multiple="multiple" type="file" name="pFiles[]" id="_pFiles" style="width: 400px" />
	</td>
</tr>
<tr>
	<th>썸네일첨부</th>
	<td>
		<input type="file" name="fileThumb" style="width: 400px">
	<td>
</tr>
<tr>
	<th>1일 숙박비용</th>
	<td> 
		<input type="text" value="" name="price">
	<td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="10" cols="50" style="resize: none" name="content"></textarea>
	<td>
</tr>
</table>
<input type="submit" value="글쓰기">
<input type="button" value="취소">
</form>

<script type="text/javascript">
function submitChk(){
	var place1 = $("#place1").prop("selected",true).val();
	var place2 = $("#place2").val();
	var place = place1 + "-" + place2;
	
	if(place2 != null && place2 != ""){
		$("#place").val(place);
		alert("성공");
		return true;
	}
	alert("실패");
	return false;
}
 
$('#_pFiles').change(function(){
	
	const target = document.getElementsByName('pFiles[]');
	        
	var html = '';
	$.each(target[0].files, function(index, file){
		
	    const fileName = file.name;
	    const fileEx = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
	    if(fileEx != "jpg" && fileEx != "png" &&  fileEx != "gif" &&  fileEx != "bmp" && 
	    		fileEx != "wmv" && fileEx != "mp4" && fileEx != "avi"){
	    	
	        alert("파일은 (jpg, png, gif, bmp, wmv, mp4, avi) 형식만 등록 가능합니다.");

			$("#_pFiles").val("");
	        return false;
	    }
	 });
});



/* 
$(document).ready(function () {
	for(var i = 2; i<=5; i++){
		$("#file"+i).hide();
	}
});
function fileChange( cnt ){
	var num = cnt.options[cnt.selectedIndex].value;
	
	 for(i=1; i<=5; i++){   // 초기화
	    $("#file" + i ).val("");
	    $("#file"+i).hide();
	 }
	   
	 for(i=1; i<=num; i++){
	    $("#file" +i).show();
	      
	 }
}
 */
 
</script>

</body>
</html>


