package com.wz.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wz.crud.bean.Department;
import com.wz.crud.bean.Msg;
import com.wz.crud.service.DepartmentService;

@Controller
public class DepartmentController {

	@Autowired
	DepartmentService departmentService;
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts(){
		//查出所有的部门信息
		List<Department> depts = departmentService.getDepts();
		return Msg.success().add("depts", depts);
	}
	
}
