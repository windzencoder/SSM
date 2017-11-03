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
				<table class="table table-striped" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>

				</table>
			</div>
		</div>
		<!-- 显示分页 -->
		<div class="row">
			<!-- 文字信息 -->
			<div class="col-md-6 text-left" id="page_info_area">
				
			</div>
			<!-- 分页信息 -->
			<div class="col-md-6 text-right" id="page_nav_area">
				
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		//页面加载完成后，直接发送ajax请求，得到分页数据
		$(function(){
			to_page(1);//跳转到第一页
		});
		
		//跳转到pn页
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/getEmps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//alert(JSON.stringify(result));
					//1.员工信息
					build_emps_table(result);
					//2.分页信息
					build_page_info(result);
					build_page_nav(result)
				}
			});
		}
		
		//解析分页信息
		function build_page_info(result){
			//清空
			$('#page_info_area').empty();
			$('#page_info_area').append("当前"+result.extend.pageInfo.pageNum
					+"第页，总共"+result.extend.pageInfo.pages+"页，总"
					+result.extend.pageInfo.total+"记录数");
		}
		
		//解析显示分页条
		function build_page_nav(result){
			//清空
			$('#page_nav_area').empty();
	
			var ul = $("<ul></ul>").addClass("pagination");
			
			//首页
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
			//下一页
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));
			
			if(result.extend.pageInfo.hasPreviousPage == false){//没有前一页
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}
			ul.append(firstPageLi).append(prePageLi);
			
			$.each(result.extend.pageInfo.navigatepageNums, function(index,item){
				var numPageLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
				if(result.extend.pageInfo.pageNum == item){//当前页
					numPageLi.addClass("active");
				}
				//单击事件
				numPageLi.click(function(){
					to_page(item);
				});
				ul.append(numPageLi);
			});
			
			//下一页
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
			//末页
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
		
			if(result.extend.pageInfo.hasNextPage == false){//没有下一页
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			ul.append(nextPageLi).append(lastPageLi);
		
			var navEle = $("<nav></nav>").append(ul);
			
			$('#page_nav_area').append(navEle);
		}
		
		//员工信息列表
		function build_emps_table(result){
			//清空
			$('#emps_table tbody').empty();
			
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index,item){
				var empIdTd = $('<td></td>').append(item.empId);
				var empNameTd = $('<td></td>').append(item.empName);
				var gender = item.gender == "M" ? "男" : "女";
				var genderTd = $('<td></td>').append(gender);
				var emailTd = $('<td></td>').append(item.email);
				var deptNameTd = $('<td></td>').append(item.department.deptName);
				var editBtn = $('<button></button>').addClass("btn btn btn-primary btn-sm")
					.append($('<span></span>').addClass("glyphicon glyphicon-pencil"))
					.append("编辑");
				var delBtn = $('<button></button>').addClass("btn btn-danger btn-sm")
					.append($('<span></span>').addClass("glyphicon glyphicon-trash"))
					.append("删除");
				var btnTd = $('<td></td>').append(editBtn).append(" ").append(delBtn);
				$('<tr></tr>').append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(deptNameTd)
					.append(btnTd)
					.appendTo($('#emps_table tbody'));
			})
		}
	
	</script>
	
  </body>
</html>