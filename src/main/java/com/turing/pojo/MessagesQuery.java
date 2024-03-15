package com.turing.pojo;

public class MessagesQuery {
    // 工号
    private String staffId;
    // 员工名称
    private String employeeName;
    // 部门ID
    private Integer deptId;
    // 在职状态 : 0:离职 1:在职
    private Integer employmentStatus;
    // 详细内容
    private String message;
    public String getMessage() {
        return message;
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

    public Integer getEmploymentStatus() {
        return employmentStatus;
    }

    public void setEmploymentStatus(Integer employmentStatus) {
        this.employmentStatus = employmentStatus;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    // 在职状态逻辑视图
    public String getEmploymentStatusStr() {
        if (employmentStatus == null) {
            return "未知";
        }
        return employmentStatus == 0 ? "离职" : "在职";
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
}
