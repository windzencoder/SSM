<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>员工列表</title>
    <!-- Bootstrap -->
    <link href="${APP_PATH }/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script type="text/javascript" src="${APP_PATH }/static/js/jquery-2.1.4.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script type="text/javascript" src="${APP_PATH }/static/bootstrap/js/bootstrap.min.js"></script>
    
  </head>
  <body>
	
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="clo-md-4 col-md-offset-8 text-right">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped" >
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<td>${emp.empId }</td>
							<td>${emp.empName }</td>
							<td>${emp.gender == "M" ? "男" : "女" }</td>
							<td>${emp.email }</td>
							<td>${emp.department.deptName }</td>
							<td>
								<button class="btn btn-primary btn-sm">
	  								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
								</button>
								<button class="btn btn-danger btn-sm">
	  								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
								</button>
							</td>
						</tr>
					</c:forEach>

				</table>
			</div>
		</div>
		<!-- 显示分页 -->
		<div class="row">
			<!-- 文字信息 -->
			<div class="col-md-6 text-left">
				当前第${pageInfo.pageNum }页，总共${pageInfo.pages }页，总${pageInfo.total }记录数
			</div>
			<!-- 分页信息 -->
			<div class="col-md-6 text-right">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
					  <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
					  <c:if test="${pageInfo.hasPreviousPage }">
					  	<li>
					      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="上一页">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
					  </c:if>
					    <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
					    		<c:if test="${page_Num == pageInfo.pageNum }">
					    			<li class="active"><a href="#">${page_Num }</a></li>
					    		</c:if>
					    		<c:if test="${page_Num != pageInfo.pageNum }">
					    			<li><a href="${APP_PATH}/emps?pn=${page_Num }">${page_Num }</a></li>
					    		</c:if>
					    </c:forEach>	
					    
					<c:if test="${pageInfo.hasNextPage }">
					    <li>
					      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="下一页">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					 </c:if>	    
				    <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
				  </ul>
				</nav>
			</div>
		</div>
	</div>
	
  </body>
</html>