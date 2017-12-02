package com.maven.ssm.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.maven.ssm.crud.bean.Employee;
import com.maven.ssm.crud.bean.Msg;
import com.maven.ssm.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

//       @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pn",defaultValue ="1") Integer pn,
//                          Model model){
//        //这不是一个分页查询
//        //引入PageHelper分页插件
//        //在查询之前调用,传入页码，以及每页的大小
//        PageHelper.startPage(pn,5);
//        //startPage后面的查询就是个分页的查询
//        List<Employee> employees = employeeService.getAll();
//        //使用PageInfo来包装查询后的结果，只需要将PageInfo 交给
//        //页面，封装了详细的分页信息，包括有我们查询出来的数据
//        //naxigatePages:连续显示的页数
//        PageInfo page = new PageInfo(employees,5);
//        model.addAttribute("pageInfo",page);
//        return "list";
//    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //引入PageHelper分页插件
        //在查询之前调用,传入页码，以及每页的大小
        PageHelper.startPage(pn, 10);
        //startPage后面的查询就是个分页的查询
        List<Employee> employees = employeeService.getAll();
        //使用PageInfo来包装查询后的结果，只需要将PageInfo 交给
        //页面，封装了详细的分页信息，包括有我们查询出来的数据
        //naxigatePages:连续显示的页数
        PageInfo page = new PageInfo(employees, 5);
        return Msg.success().add("pageInfo",page);
    }

    @ResponseBody
    @RequestMapping(value = "/emp" , method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map=new HashMap<String,Object>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError:fieldErrors) {
                System.out.println("错误字段名："+fieldError.getField());
                System.out.println("错误字信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFileds",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @ResponseBody
    @RequestMapping(value = "/checkUser")
    public Msg checkUser(@RequestParam("empName") String empName){
        String regx="(^[a-zA-Z0-9_-]{5,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名可以是2-5位中文或者5-16位英文和数字的组合");
        }
        //数据库校验
        boolean falg=  employeeService.checkUser(empName);
      if(falg){
          return Msg.success();
      }else {
          return Msg.fail().add("va_msg","用户名不可用");
      }
    }

    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable(value = "id") Integer id) {

        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable(value = "ids") String ids){
        //批量删除
        if(ids.contains("-")){
           List<Integer> del_ids=new ArrayList<Integer>();
           String[] str_ids=ids.split("-");
           for (String id:str_ids) {
               del_ids.add(Integer.parseInt(id));
           }
           employeeService.deleteBatch(del_ids);
       }else {
            //单个删除
           Integer id = Integer.parseInt(ids);
           employeeService.deleteEmp(id);
       }
      return Msg.success();
    }
}
