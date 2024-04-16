<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

    
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>
<body>
<div class="container">
	
	<jsp:include page="header.jsp"></jsp:include>

  <h2>Spring version 3.</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Board</div>
    <div class="panel-body" id="list">
    	<table class="table table-bordered table-hover">
    		<thead>
    			<tr>
    				<td>번호</td>
    				<td>제목</td>
    				<td>작성자</td>
    				<td>작성일</td>
    				<td>조회수</td>
    			</tr>
    		</thead>
    		<tbody id="view">
    			
    		</tbody>
    		
    		<tfoot>
    			<tr>
    				<td colspan="5">
    					<button id="goForm" class="btn btn-primary">글쓰기</button>
    				</td>
    			</tr>
    		</tfoot>
    	
    	</table>
    </div>
    
    <!-- 글쓰기 폼 -->
    <div style="display: none;" class="panel-body" id="wform" enctype="mutilpart/form-data">
    	<form action= "_URL" method="POST" id="uploadForm">
			<table class="table table-hover">
				
				<tr>
					<td>제목</td>
					<td><input class="form-control" type="text" name="title" id="title"></td>
				</tr>
				<tr>
					<td>파일</td>
					<td><input class="form-control" type="file" name="imgpath" id="imgpath"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea class="form-control" id = "content" name="content" rows="7" cols=""></textarea></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input class="form-control" type="text" name="writer" id="writer"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button id="goInsert" type="button" class="btn btn-warning">글작성</button>
						<button id="fclear" type="reset" class="btn btn-danger">취소</button>
						<button id="goList" type="button" class="btn btn-info">목록</button>
					</td>
				</tr>
				
			</table>
    	
    	
    	</form>
    </div>
    <div class="panel-footer">스프링게시판 - 김자영</div>
  </div>
</div>


<script type="text/javascript">
	
	$(document).ready(function(){
		// HTML 문서가 전부 로딩됟고 실행되는 부분
		
		loadList();
			
			
		
		// 글쓰기 버튼 눌렀을 때 게시판을 가리고 글작성 폼은 보여주는 기능
		$("#goForm").on("click", function(){
			$("#list").css("display", "none");
			$("#wform").css("display", "block");
		})
		
		//목록 버튼 눌렀을 때 글작성은 가리고 게시판을 보여주는 기능
		// 쌤풀이
		$("#goList").on("click", function(){
			$("#list").css("display", "block");
			$("#wform").css("display", "none");
		})
		
		// 글쓰기 기능(파일 업로드)
		$("#goInsert").on("click", function(){
			
			let form = document.getElementById("uploadForm");
			let data = new FormData(form);
			
			//비동기 방식
			$.ajax({
				url : "boardInsert.do", //보낼곳
				type : "post", //방식
				enctype : "multipart/form-data",
				data : data, //보낼 데이터
				processData : false, 
				contentType : false,
				cache : false, //캐시 메모리
				timeout : 600000, // 파일 업로드 시간 제한 (1000=1초) 10분
				success : loadList, //콜백함수(데이터 보내고ㄷ나서 게시글 다시 불러서 보냄)
				error : function(){ alert("error...");}
			});
			
			
			// 자: 글작성 후 밀기
			$("#fclear").trigger("click");
			
		});
		
	});
	
	// 게시글 상세보기 기능
	function goContent(idx){
		
		if($("#c"+idx).css("display") == "none"){
			$("#c"+idx).css("display", "table-row"); //table-row인 상태 펼쳐져있는 상태//none이면 펼쳐라
			
		}else{ //display none이 아니라면
			$("#c"+idx).css("display", "none"); 
		
			// 게시글 조회수 올리기 기능(자:게시글 닫을 때)
			$.ajax({
				url : "boardCount.do/" + idx,//자:pathValuable //data보낼 필요 없음
				type : "get",
				success : loadList,
				error : function(){ alert("error...");}

				
			});
		
		
		}
	}
	
	// 게시글 삭제 기능
	function goDelete(idx){
	
		// 쌤풀이
		
		$.ajax({
//			url : "boardDelete.do?idx="+idx,
			url : "boardDelete.do/"+idx,
			type : "get",
			success : loadList,
			error : function(){ alert("error...");}
		});
		
		
		/*자영실습 실패~~~
		$.ajax({
			url : "boardDelete.do", //보낼곳
			type : "post", //방식
			data : {obj.idx = idx}, 
			success : boardList,
			error : function(){ alert("error...");}
		});*/
		
	}
	
	function loadList(){
		// Server로부터 게시글 정보를 비동기로 가져오는 기능
		
		// 비동기로 요청하는 기능 - 요청데이터 -> JSON
		// JSON -> { key1 : value1, key2 : value2, test : function(){ } }
		$.ajax({
			url : "boardList.do",
			type : "get",
			dataType : "json",
			success : makeView,
			error : function(){ alert("error...");}
		});
	}
	
	function makeView(data){
		// 서버에서 게시글 데이터 가져오기 성공했을 때 실행되는 함수
		console.log(data);
		let list="";
		
		$.each(data, function(index, obj){
			list += "<tr>";
			list += "<td>" + (index+1) + "</td>";
			list += "<td id='t"+obj.idx+"'>";
			list += "<a href = 'javascript:goContent("+obj.idx+ ")'>";
			list += obj.title + "</a></td>";
			list += "<td>" + obj.writer + "</td>";
			list += "<td>" + obj.indate + "</td>";
			list += "<td>" + obj.count + "</td>";
			list += "</tr>";
			
			//240318월
			// 상세내용 보여주기
			list += "<tr id='c"+obj.idx+"' style='display:none'>";
			list += "<td>내용</td>";
			list += "<td colspan='4'>";
			if(obj.imgpath != null){
				list += "<img src='resources/board/" + obj.imgpath + "'>";
			}else{
				list += "<img wiedth='50px' src='resources/board/ai.png'>";
				
			}
			
			list += "<br>";
			list += "<textarea id ='ta"+obj.idx +"' style='background-color : white;' class='form-control' row='7' readonly >";
			list += obj.content;
			list += "</textarea>";
			
			// 수정, 삭제 버튼 추가
			list += "<br>";
			
			list += "<span id='ub"+ obj.idx + "'>";
			list += "<button onclick='goUpdateForm(" + obj.idx + ")' class='btn btn-warning btn-sm'>수정</button>";
			list += "</span>";
			
			list += "&nbsp;&nbsp;<button onclick='goDelete("+ obj.idx +")' class='btn btn-danger btn-sm'>삭제</button>";
			list += "</td>";
			list += "</tr>";
			
		});
		$("#view").html(list);
		
		$("#list").css("display", "block");
		$("#wform").css("display", "none");
		
	}
	
	// 수정화면으로 만드는 기능
	function goUpdateForm(idx){ //자:idx를 받아옴(해당 textarea수정 위해서)
		$("#ta"+idx).attr("readonly", false); //자:해당 textarea 의 readonly 풀어주기
		
		//자:제목수정
		let title = $("#t"+idx).text(); //기존 제목에 있던 값을 가져오자
		//console.log(title); //확인용
		let newInput = "<input id='nt"+ idx +"' type='text' class='form-control' value='" + title + "'>";
		$("#t"+idx).html(newInput);
		let newButton = "<button onclick = 'goUpdate("+idx+")' class='btn btn-primary btn-sm'>수정하기</button>";
		$("#ub"+idx).html(newButton);
	}
	
	// 수정기능
	function goUpdate(idx){
		
		let title = $("#nt"+idx).val(); //자:input 태그 안의 내용 가져옴
		let content = $("#ta"+idx).val(); //자:내용
		
		console.log(title + "/" + content);//자:확인용
		
		$.ajax({
			url : "boardUpdate.do",
			type : "post",
			data : {"idx" : idx, "title" : title, "content" : content},
			success : loadList,
			error : function(){ alert("error...");}
			
		})
	}
	
	
</script>







</body>
</html>



 
