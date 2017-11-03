package com.wz.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wz.crud.bean.Employee;
import com.wz.crud.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService employeeService;
	
	/**
	 * 查询员工 分页查询
	 * @return
	 */
	@RequestMapping("/emp")
	public String getEmps(@RequestParam(value="pn", defaultValue="1") Integer pn, Model model){
		
		//传入页码，页面大小
		PageHelper.startPage(pn,5);
		//startPage后面跟着一个分页查询
		List<Employee> emps = employeeService.getAll();
		//5表示连续显示的页数
		PageInfo page = new PageInfo<>(emps, 5);
		
		model.addAttribute("pageInfo", page);
		
		return "list";
	}
	
}
