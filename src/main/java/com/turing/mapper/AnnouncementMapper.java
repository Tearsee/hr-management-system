package com.turing.mapper;

import com.turing.pojo.Announcement;
import com.turing.pojo.Employee;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AnnouncementMapper {
    /**
     * 分页查询
     * @param begin
     * @param size
     * @return
     */
    @Select("select * from trainannounce limit #{begin},#{size}")
    List<Announcement> selectByPage(@Param("begin") int begin, @Param("size") int size);

    /**
     * 查询总条数
     * @return
     */
    @Select("select count(*) from trainannounce")
    int selectTotalCount();

    /**
     * 添加培训公告
     * @param announcement
     */
    @Insert("insert into trainannounce values (null,#{detail})")
    void add(Announcement announcement);
}
