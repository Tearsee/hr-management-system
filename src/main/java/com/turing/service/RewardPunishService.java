package com.turing.service;

import com.turing.pojo.PageBean;
import com.turing.pojo.RewardPunish;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

public interface RewardPunishService {
    /**
     * 分页条件查询
     * @param currentPage
     * @param pageSize
     * @param rewardPunish
     * @return
     */
    PageBean<RewardPunish> selectByPageAndCondition(int currentPage, int pageSize, RewardPunish rewardPunish);



    /**
     * 添加
     * @param rewardPunish
     */
    void add(RewardPunish rewardPunish);
}
