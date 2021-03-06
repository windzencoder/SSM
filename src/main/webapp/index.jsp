<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link href="${APP_PATH }/static/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-2.1.4.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script type="text/javascript"
	src="${APP_PATH }/static/bootstrap/js/bootstrap.min.js"></script>

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
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all"/></th>
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
			<div class="col-md-6 text-left" id="page_info_area"></div>
			<!-- 分页信息 -->
			<div class="col-md-6 text-right" id="page_nav_area"></div>
		</div>
	</div>

	<!-- 员工添加模态框 -->
	<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<!-- 表单 -->
					<form class="form-horizontal">

						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="empName_add_input"
									name="empName" placeholder="empName">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="email_add_input"
									name="email" placeholder="email@123.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="checkbox-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked"> 男
								</label> <label class="checkbox-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_select">
									
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- 员工修改模态框 -->
	<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工修改</h4>
				</div>
				<div class="modal-body">
					<!-- 表单 -->
					<form class="form-horizontal">

						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static" ></p>
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="email_update_input"
									name="email" placeholder="email@123.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="checkbox-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"
									checked="checked"> 男
								</label> <label class="checkbox-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_select">
									
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
		
		var totalRecord,currentPage;//总记录数，当前页
		
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
		
		//新增员工 模态框
		$("#emp_add_modal_btn").click(function(){
			//清除模态框表单数据
			reset_form("#empAddModel form");
			//查询部门信息
			getDepts("#empAddModel select");
			//显示模态框
			$('#empAddModel').modal({
				backdrop:"static"
			});
		});
		
		//表单重置 清除表单样式及内容
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//查询所有的部门信息并显示在下拉列表中
		function getDepts(ele){
			$(ele).empty();//清空
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//alert(JSON.stringify(result));
					//显示部门
					$.each(result.extend.depts, function(){
						$(ele).append($("<option></option>").append(this.deptName).attr("value", this.deptId));
					});
				}
			});
		}
		
		//用户名后端校验 绑定change事件
		$("#empName_add_input").change(function(){
			//ajax校验用户名是否可用
			$.ajax({
				url:"${APP_PATH}/checkuser",
				//data: {"empName" : this.value},
				data: "empName="+this.value,
				type:"POST",
				success:function(result){
					if(result.code == 100){
						show_validate_msg("#empName_add_input", "success", "用户名可用");
						$("#emp_save_btn").attr("ajax-va", "success");//保存校验状态 成功
					}else{
						show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va", "error");//保存校验状态 失败
					}
				}
			});
		});
		
		//员工新增 保存事件
		$("#emp_save_btn").click(function(){
			//先对要提交给服务器的数据进行校验
			if(!validate_add_form()){
				return false;
			} 
			//判断之前的ajax用户名校验是否成功，如果成功，则提交
			if($("#emp_save_btn").attr("ajax-va") == "error"){
				return false;
			}
			var data = $("#empAddModel form").serialize();
			//模态框数据提交到服务器
			$.ajax({
				url:"${APP_PATH}/emp",
				data: data,
				type:"POST",
				success:function(result){
					//alert(result.msg);
					if(result.code == 100){
						//关闭模态框
						$('#empAddModel').modal('hide');
						//来到最后一页
						to_page(totalRecord);
					}else{
						//alert(JSON.stringify(result));
						if(result.extend.errorFields.email != undefined){//邮箱错误
							show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
						}
						if(result.extend.errorFields.empName != undefined){//员工名称错误
							show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
						}
					}
				}
			});
		})
		
		//校验员工提交表单数据
		function validate_add_form(){
			//拿到校验的数据
			var empName = $("#empName_add_input").val();
			//用户名正则表达式匹配
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			//alert(regName.test(empName));
			if(!regName.test(empName)){
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			}else{
				show_validate_msg("#empName_add_input", "success", "");
			}
			//邮箱校验
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_add_input", "success", "");
			}
			return true;
		}
		
		//显示校验信息
		function show_validate_msg(ele, status, msg){
			//清除当期元素验证状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success" == status){//校验成功
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}
			if("error" == status){//校验失败
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		//解析分页信息
		function build_page_info(result){
			//清空
			$('#page_info_area').empty();
			$('#page_info_area').append("当前"+result.extend.pageInfo.pageNum
					+"第页，总共"+result.extend.pageInfo.pages+"页，总"
					+result.extend.pageInfo.total+"记录数");
			totalRecord = result.extend.pageInfo.total;//保存总页数
			currentPage = result.extend.pageInfo.pageNum;//保存当前页
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
				var checkBoxTd = $('<td></td>').append($('<input type="checkbox" class="check_item" />'));
				var empIdTd = $('<td></td>').append(item.empId);
				var empNameTd = $('<td></td>').append(item.empName);
				var gender = item.gender == "M" ? "男" : "女";
				var genderTd = $('<td></td>').append(gender);
				var emailTd = $('<td></td>').append(item.email);
				var deptNameTd = $('<td></td>').append(item.department.deptName);
				var editBtn = $('<button></button>').addClass("btn btn btn-primary btn-sm edit_btn")
					.append($('<span></span>').addClass("glyphicon glyphicon-pencil"))
					.append("编辑");
				//为编辑按钮添加自定义的属性，来表示当期员工的id
				editBtn.attr("edit-id", item.empId);
				
				var delBtn = $('<button></button>').addClass("btn btn-danger btn-sm delete_btn")
					.append($('<span></span>').addClass("glyphicon glyphicon-trash"))
					.append("删除");
				//为删除按钮添加自定义的属性，来表示当期员工的id
				delBtn.attr("delete-id", item.empId);
				
				var btnTd = $('<td></td>').append(editBtn).append(" ").append(delBtn);
				$('<tr></tr>').append(checkBoxTd)
					.append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(deptNameTd)
					.append(btnTd)
					.appendTo($('#emps_table tbody'));
			})
		}
		
		//编辑按钮事件
		$(document).on("click", ".edit_btn", function(){
			//alert("edit");
			//1.查出部门信息，显示部门列表
			getDepts("#empUpdateModel select");
			//查询员工信息
			getEmp($(this).attr("edit-id"));
			//把员工的id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
			//显示模态框
			$('#empUpdateModel').modal({
				backdrop:"static"
			});
		});
		
		//查询员工
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/" + id,
				type:"GET",
				success:function(result){
					//alert(JSON.stringify(result));
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModel input[name=gender]").val([empData.gender]);
					$("#empUpdateModel select").val([empData.dId]);
				}
			});
		}
		
		//点击更新，更新员工信息
		$("#emp_update_btn").click(function(){
			//验证邮箱信息
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_update_input", "success", "");
			}
			
			//alert($("#empUpdateModel form").serialize());
			
			//发送ajax请求修改员工信息
			//方式一 方法post请求，带上_method=PUT
			/*
			$.ajax({
				url:"${APP_PATH}/emp/" + $(this).attr("edit-id"),
				type:"POST",
				data:$("#empUpdateModel form").serialize() + "&_method=PUT",
				success:function(result){
					alert(JSON.stringify(result));
				}
			});
			*/
			//方式二 直接发送put请求
			$.ajax({
				url:"${APP_PATH}/emp/" + $(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModel form").serialize(),
				success:function(result){
					//alert(JSON.stringify(result));
					//关闭对话框
					$("#empUpdateModel").modal("hide");
					//回到本页面
					to_page(currentPage);
				}
			});
			
		});
		
		
		//单个删除
		$(document).on("click", ".delete_btn", function(){
			//alert("delete");
			//alert($(this).parents("tr").find("td:eq(1)").text());
			
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			if(confirm("确认删除"+empName+"吗?")){
				$.ajax({
					url:"${APP_PATH}/emp/" + $(this).attr("delete-id"),
					type:"DELETE",
					success:function(result){
						//alert(JSON.stringify(result));
						alert(result.msg);
						to_page(currentPage);
					}
				})
			}
		});
		
		//全选 全不选
		$("#check_all").click(function(){
			//attr后去checkded为undefined，所有用prop
			//alert($(this).prop("checked"));
			$(".check_item").prop("checked", $(this).prop("checked"));
		})
		$(document).on("click", ".check_item", function(){
			//判断当前选中元素的是否为5个
			var flag = $(".check_item:checked").length == $(".check_item").length
			$("#check_all").prop("checked", flag);
		});
		
		//多个删除
		$("#emp_delete_all_btn").click(function(){
			//遍历选中的项目
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"), function(){
				var empName = $(this).parents("tr").find("td:eq(2)").text();
				empNames += empName+",";
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			empNames = empNames.substring(0, empNames.length-1);
			del_idstr = del_idstr.substring(0, del_idstr.length-1);
			if(confirm("确认删除【"+empNames+"】吗?")){
				//发送ajax请求
				$.ajax({
					url:"${APP_PATH}/emp/" + del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
		
	
	</script>

</body>
</html>