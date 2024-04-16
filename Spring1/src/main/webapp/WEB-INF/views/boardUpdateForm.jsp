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
 
<% pageContext.setAttribute("ln", "\n"); %>
<div class="container">
  <h2>Spring version 1.</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Board</div>
    <div class="panel-body">
    <form action = "boardUpdate.do" method="post">
    	
    <input type="hidden" name="idx" value="${vo.idx}">
    	<table class="table">
    		<tbody>
    			<tr>
	    			<td>제목</td>
	    			<td>
	    				<input type="text" name="title" value = "${vo.title}" class = "form-control"> 
	    			</td>
	    				
    			</tr>
    			<tr>
	    			<td>내용</td>
	    			<td> 
	    				<textarea name="content" rows="7" class="form-control" cols="">${vo.content}</textarea>
	    			</td>
    			</tr>
    			<tr>
	    			<td>작성자</td>
	    			<td>
	    				<input type="text" name="writer" value = "${vo.writer}" class = "form-control"> 
	    			</td>
    			</tr>
    			<tr>
	    			<td>작성일</td>
	    			<td>
					    ${fn:split(vo.indate, " ")[0]}				
					</td>
    			</tr>
    			
    			<tr>
    				<td colspan="2" align="center">
    					<button type="submit" class="btn btn-info">수정</button>
    					<button type="reset" class="btn btn-danger">취소</button>
    					<a href="boardList.do" class="btn btn-warning">목록</a>
    				</td>
    			</tr>
    			
    			
    		</tbody>
    	
    	</table>
    	</form>
    
    
    </div>
    
    
    
    
    
    <div class="panel-footer">스프링게시판 - 김자영</div>
  </div>
</div>

</body>
</html>




