package com.turing.service;

import com.turing.pojo.Announcement;
import com.turing.pojo.Employee;
import com.turing.pojo.PageBean;
import com.turing.pojo.Vacate;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

public interface VacateService {
    /**
     * 分页条件查询
     * @param currentPage
     * @param pageSize
     * @param vacate
     * @return
     */
    PageBean<Vacate> selectByPageAndCondition(int currentPage, int pageSize, Vacate vacate);

    /**
     * 设置审批状态
     * @param id
     */
    @Update("update vacate set status=#{status} where id=#{id}")
    void updateById(@Param("id") int id, @Param("status") int status);
}
