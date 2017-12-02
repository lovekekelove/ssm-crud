package com.maven.ssm.crud.controller;

import com.maven.ssm.crud.bean.Department;
import com.maven.ssm.crud.bean.Msg;
import com.maven.ssm.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        //所有员工信息
       List<Department> list=departmentService.getAll();
       return Msg.success().add("depts",list);
    }

}
