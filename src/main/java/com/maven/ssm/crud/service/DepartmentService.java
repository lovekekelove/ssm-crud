package com.maven.ssm.crud.service;

import com.maven.ssm.crud.bean.Department;
import com.maven.ssm.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

   public List<Department> getAll(){
      return departmentMapper.selectByExample(null);
   }
}
