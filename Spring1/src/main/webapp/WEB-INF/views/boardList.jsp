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
  <h2>Spring version 1.</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Board</div>
    <div class="panel-body">
    
    	<table class = "table table-hover">
    		<thead>
    			<tr class = "warning">
    				<th>번호</th>
    				<th>제목</th>
    				<th>작성자</th>
    				<th>작성일</th>
    				<th>조회수</th>
    			</tr>	
    		</thead>
    		<tbody>
    			<c:forEach items="${list}" var="vo" varStatus="i">
    				<tr>
    					<td>${i.count}</td>
    					<td><a href = "boardContent.do?idx=${vo.idx}">${vo.title}</a></td>
    					<td>${vo.writer}</td>
    					<td>${fn:split(vo.indate, " ")[0]}</td>
    					<td>${vo.count}</td>
    				</tr>
    			</c:forEach>
    		</tbody>
    	</table>
    	
    	<a href="boardForm.do">글쓰기</a>
    	
    
    
    
    </div>
    
    
    
    <div class="panel-footer" class="btn btn-warning">스프링게시판 - 김자영</div>
  </div>
</div>

</body>
</html>




