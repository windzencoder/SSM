package com.wz.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.wz.crud.bean.Department;
import com.wz.crud.bean.Employee;
import com.wz.crud.dao.DepartmentMapper;
import com.wz.crud.dao.EmployeeMapper;

/**
 * 测试dao工作层
 * 
 * @author Miller
 *
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSession sqlSession;// 批量的sqlSession

	@Test
	public void testCRUD() {

		// ApplicationContext context = new
		// ClassPathXmlApplicationContext("applicationContext.xml");
		// context.getBean(DepartmentMapper.class);

		System.out.println(departmentMapper);

		// 1.插入几个部门
		// departmentMapper.insertSelective(new Department(null, "开发部"));
		// departmentMapper.insertSelective(new Department(null, "测试部"));

		// 2.插入几个员工
		// employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "jerry@163.com", 3));
		// 批量插入
		
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insertSelective(new Employee(null, uid, "M", uid + "@163.com", 3));
		}

	}

}
