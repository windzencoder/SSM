package com.wz.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wz.crud.bean.Employee;
import com.wz.crud.bean.EmployeeExample;
import com.wz.crud.bean.EmployeeExample.Criteria;
import com.wz.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	/**
	 * 查询所有的员工
	 * @return
	 */
	public List<Employee> getAll(){
		return employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 员工保存
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 校验用户名
	 * @param empName
	 * @return
	 */
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 通过id查询员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKeyWithDept(id);
		return employee;
	}

	/**
	 * 更新用户信息
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	
}
