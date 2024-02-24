package com.turing.pojo;

public class Employee {
    // id 主键
    private Integer id;
    // 工号
    private String staffId;
    // 员工名称
    private String employeeName;
    // 年龄
    private Integer age;
    // 邮箱
    private String email;
    // 手机号
    private String phone;
    // 部门ID
    private Integer deptId;
    // 职位ID
    private Integer posId;
    // 在职状态 : 0:离职 1:在职
    private Integer employmentStatus;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public Integer getPosId() {
        return posId;
    }

    public void setPosId(Integer posId) {
        this.posId = posId;
    }

    public Integer getEmploymentStatus() {
        return employmentStatus;
    }

    public void setEmploymentStatus(Integer employmentStatus) {
        this.employmentStatus = employmentStatus;
    }

    // 雇佣状态逻辑视图
    public String getEmploymentStatusStr(){
        if(employmentStatus == null){
            return "未知";
        }
        return employmentStatus == 0 ? "离职":"在职";
    }

}
