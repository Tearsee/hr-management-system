package com.turing.service;

import com.turing.pojo.Announcement;
import com.turing.pojo.Employee;
import com.turing.pojo.PageBean;
import com.turing.pojo.Vacate;
import org.apache.ibatis.annotations.Insert;

public interface VacateService {
    /**
     * 分页条件查询
     * @param currentPage
     * @param pageSize
     * @param vacate
     * @return
     */
    PageBean<Vacate> selectByPageAndCondition(int currentPage, int pageSize, Vacate vacate);

}
