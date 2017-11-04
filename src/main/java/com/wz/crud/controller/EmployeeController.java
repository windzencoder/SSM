package com.wz.crud.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
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
	 * 如果直接发送ajax的put请求，请求体中有数据，但是employee封装不上
	 * 原因是：Tomcat
	 * 1.将请求体中的数据，封装为一个map
	 * 2.request.getParameter("empName")就会从这个map中取值
	 * 3.SpringMVC封装POJO对象的时候，会把POJO中每个属性的值，通过request.getParameter("empName")取出来
	 * 
	 * Ajax发送PUT请求引发的血案：
	 * PUT请求，请求体中的数据，request.getParameter("empName")为null
	 * Tomcat一看是put请求，就不会封装请求体中的数据为map，只有post请求才封装
	 * 
	 * 更新用户信息
	 * @return
	 * value="/emp/{id}" employee中empId为null 修改为value="/emp/{empId}"即可
	 */
	@RequestMapping(value="/emp/{empId}", method=RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee){
		System.out.println("更新用户信息:"+employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 查询员工
	 * @PathVariable("id") 从路径中获取id值
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id){
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	/**
	 * 校验用户名
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkUser(@RequestParam("empName") String empName){
		//判断用户名是否合法
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regex)){
			return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
		}
		//数据库用户名重复校验
		boolean b = employeeService.checkUser(empName);
		if (b) {
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}
	
	/**
	 * 保存员工
	 * @return
	 * @Valid 表示要校验数据
	 * BindingResult result 封装校验结果
	 */
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result){
		if (result.hasErrors()) {
			//校验失败，应该返回失败，在模态框中显示校验失败的错误信息
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名：" + fieldError.getField());
				System.out.println("错误信息：" + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			employeeService.saveEmp(employee);
			return Msg.success();
		}
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
