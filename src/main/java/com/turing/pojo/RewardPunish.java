package com.turing.pojo;

import java.util.Date;

public class RewardPunish {
    private Integer id;
    private Integer eid;
    private Date rpDate;
    private Integer rpType;
    private String rpReason;
    private Integer rpPoint;
    private String remark;

    public Integer getEid() {
        return eid;
    }

    public void setEid(Integer eid) {
        this.eid = eid;
    }

    public Date getRpDate() {
        return rpDate;
    }

    public void setRpDate(Date rpDate) {
        this.rpDate = rpDate;
    }

    public Integer getRpType() {
        return rpType;
    }

    public void setRpType(Integer rpType) {
        this.rpType = rpType;
    }

    public String getRpReason() {
        return rpReason;
    }

    public void setRpReason(String rpReason) {
        this.rpReason = rpReason;
    }

    public Integer getRpPoint() {
        return rpPoint;
    }

    public void setRpPoint(Integer rpPoint) {
        this.rpPoint = rpPoint;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }


    // 逻辑视图
    public String getRpTypeStr(){
        if(rpType == null){
            return "未知";
        }
        return rpType == 0 ? "罚":"奖";
    }


}
