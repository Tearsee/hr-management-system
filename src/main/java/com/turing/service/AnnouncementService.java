package com.turing.service;

import com.turing.pojo.Announcement;
import com.turing.pojo.PageBean;
import com.turing.pojo.Train;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AnnouncementService {
    /**
     * 分页查询
     * @param currentPage 当前页码
     * @param pageSize 每页展示条数
     * @return
     */
    PageBean<Announcement> selectByPage(int currentPage, int pageSize);

    /**
     * 添加培训公告
     * @param announcement
     */
    @Insert("insert into trainannounce values (null,#{detail})")
    void add(Announcement announcement);

}
