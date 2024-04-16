<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
  <h2>Spring version 1.</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Board</div>
    <div class="panel-body">
    
    	<form action = "boardInsert.do" method="post" enctype="multipart/form-data">
    	<table class="table">
    		<tbody>
    			<tr>
	    			<td>제목</td>
	    			<td><input type="text" name="title" class="form-control"></td>
    			</tr>
    			
    			<tr>
	    			<td>파일</td>
	    			<td><input type="file" name="imgpath" class="form-control"></td>
    			</tr>
    			
    			<tr>
	    			<td>내용</td>
	    			<td>
	    				<textarea name="content" rows="7" class="form-control"></textarea>
	    			</td>

    			</tr>
    			<tr>
	    			<td>작성자</td>
	    			<td><input type="text" name="writer" class="form-control"></td>
    			</tr>
    			<tr>
    			<td colspan="2" align="center">
    				<button type="reset" class="btn btn-danger">취소</button>
    				<button type="submit" class="btn btn-warning">작성</button>
    				
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




