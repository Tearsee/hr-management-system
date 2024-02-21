package com.turing.pojo;

public class Employee {
    // id 主键
    private Integer id;
    // 工号
    private Integer staffId;
    // 员工名称
    private String employeeName;
    // 年龄
    private Integer age;
    // 雇佣状态 : 0:离职 1:在职
    private Integer employmentStatus;
    // 工资
    private Integer salary;
    // 底薪
    private Integer basicSalary;
    // 出勤次数
    private Integer attendanceCount;
    // 业绩
    private Integer performance;

    public Integer getSalary() {
        return salary;
    }

    public void setSalary(Integer salary) {
        this.salary = salary;
    }

    public Integer getBasicSalary() {
        return basicSalary;
    }

    public void setBasicSalary(Integer basicSalary) {
        this.basicSalary = basicSalary;
    }

    public Integer getAttendanceCount() {
        return attendanceCount;
    }

    public void setAttendanceCount(Integer attendanceCount) {
        this.attendanceCount = attendanceCount;
    }

    public Integer getPerformance() {
        return performance;
    }

    public void setPerformance(Integer performance) {
        this.performance = performance;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Integer getEmploymentStatus() {
        return employmentStatus;
    }

    // 雇佣状态逻辑视图
    public String getEmploymentStatusStr(){
        if(employmentStatus == null){
            return "未知";
        }
        return employmentStatus == 0 ? "离职":"在职";
    }

    public void setEmploymentStatus(Integer status) {
        this.employmentStatus = status;
    }

    public Integer getStaffId() {
        return staffId;
    }

    public void setStaffId(Integer staffId) {
        this.staffId = staffId;
    }
}
