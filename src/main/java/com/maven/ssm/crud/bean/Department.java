package com.maven.ssm.crud.bean;

import java.util.List;

public class Department {
    private Integer deptId;

    private String deptName;

    private List<Employee> emps;

    public List<Employee> getEmps() {
        return emps;
    }

    public void setEmps(List<Employee> emps) {
        this.emps = emps;
    }

    public Department() { }

    public Department(Integer deptId, String deptName) { this.deptId = deptId;this.deptName = deptName; }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}