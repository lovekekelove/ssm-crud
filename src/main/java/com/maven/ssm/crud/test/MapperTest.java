package com.maven.ssm.crud.test;

import com.maven.ssm.crud.bean.Department;
import com.maven.ssm.crud.bean.Employee;
import com.maven.ssm.crud.dao.DepartmentMapper;
import com.maven.ssm.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCRUD(){
        //部门插入
//         System.out.println(departmentMapper);
//         departmentMapper.insertSelective(new Department(null,"开发部"));
//         departmentMapper.insertSelective(new Department(null,"测试部"));
      //员工插入
//        employeeMapper.insertSelective(new Employee(null,"Jerry","M","22@qq.com",1));
       //批量插入
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i <1000 ; i++) {
            String uid = UUID.randomUUID().toString().substring(1, 5);
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1));
        }
        System.out.println("批量插入完成");
    }

    @Test
    public void testDept(){
        List<Department> depts=departmentMapper.selectByExample(null);
        for (Department dept:depts) {
            System.out.println(dept.getDeptName());
        }
    }
}
