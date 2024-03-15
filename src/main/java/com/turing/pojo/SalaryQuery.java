package com.turing.pojo;

import java.util.Date;

public class SalaryQuery {

    private Integer eid;

    public Integer getEid() {
        return eid;
    }

    public void setEid(Integer eid) {
        this.eid = eid;
    }

    private Integer sal;
    private Integer basicSalary;
    private Integer performance;

    // 工号
    private String staffId;
    // 员工名称
    private String employeeName;
    // 部门ID
    private Integer deptId;
    // 月份
    private  Integer month;

    public Integer getMonth() {
        return month;
    }

    public void setMonth(Integer month) {
        this.month = month;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    // 部门逻辑视图
    public String getDeptStr() {
        if(deptId == 1){
            return "行政部";
        }

        if(deptId == 2){
            return "财务部";
        }
        if(deptId == 3){
            return "质量管理部";
        }
        if(deptId == 4){
            return "营销部";
        }
        if(deptId == 5){
            return "营运部";
        }
        if(deptId == 6){
            return "研发部";
        }
        if(deptId == 7){
            return "运维部";
        }
        if(deptId == 8){
            return "人事部";
        }
        if(deptId == 9){
            return "客户服务部";
        }
        return null;
    }

    public Integer getSal() {
        return sal;
    }

    public void setSal(Integer sal) {
        this.sal = sal;
    }

    public Integer getBasicSalary() {
        return basicSalary;
    }

    public void setBasicSalary(Integer basicSalary) {
        this.basicSalary = basicSalary;
    }

    public Integer getPerformance() {
        return performance;
    }

    public void setPerformance(Integer performance) {
        this.performance = performance;
    }

}
