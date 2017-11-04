package com.wz.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wz.crud.bean.Employee;
import com.wz.crud.bean.Msg;
import com.wz.crud.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService employeeService;
	
	/**
	 * 校验用户名
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkUser(@RequestParam("empName") String empName){
		boolean b = employeeService.checkUser(empName);
		if (b) {
			return Msg.success();
		}else{
			return Msg.fail();
		}
	}
	
	/**
	 * 保存员工
	 * @return
	 */
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(Employee employee){
		employeeService.saveEmp(employee);
		return Msg.success();
	}
	
	
	@RequestMapping("/getEmps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn", defaultValue="1") Integer pn){
		
		//传入页码，页面大小
		PageHelper.startPage(pn,5);
		//startPage后面跟着一个分页查询
		List<Employee> emps = employeeService.getAll();
		//5表示连续显示的页数
		PageInfo page = new PageInfo<>(emps, 5);
		
		return Msg.success().add("pageInfo", page);
		
	}
	
	
	/**
	 * 查询员工 分页查询
	 * @return
	 */
	@RequestMapping("/emps")
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
