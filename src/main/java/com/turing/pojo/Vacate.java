package com.turing.pojo;

import java.util.Date;

public class Vacate {
    private Integer id;
    private Integer eid;
    private Date startDate;
    private Date endDate;
    private Integer type;
    private String remark;
    private Integer status;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getEid() {
        return eid;
    }

    public void setEid(Integer eid) {
        this.eid = eid;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    // 逻辑视图
    public String getTypeStr(){
        if(type == null){
            return "未知";
        }
        return type == 0 ? "病假":"事假";
    }

    // 逻辑视图
    public String getStatusStr(){
        if(status == null){
            return "未知";
        }
//        return type == 0 ? "病假":"事假";
        if(status == 1){
            return "通过";
        }
        if(status == 0){
            return "不通过";
        }

        return "待审核";
    }

}
