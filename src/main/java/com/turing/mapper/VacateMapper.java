package com.turing.mapper;

import com.turing.pojo.Train;
import com.turing.pojo.Vacate;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface VacateMapper {
    /**
     * 分页条件查询
     * @param begin
     * @param size
     * @return
     */

    List<Vacate> selectByPageAndCondition(@Param("begin") int begin, @Param("size") int size, @Param("vacate") Vacate vacate);

    /**
     * 根据条件查询总条数
     * @param leave
     * @return
     */
    int selectTotalCountByCondition(Vacate leave);

    /**
     * 设置审批状态
     * @param id
     */
    @Update("update vacate set status=#{status} where id=#{id}")
    void updateById(@Param("id") int id,@Param("status") int status);

    /**
     * 添加
     * @param vacate
     */
    @Insert("insert into vacate values (null,#{eid},#{startDate},#{endDate},#{type},#{remark},2)")
    void addByEmp(Vacate vacate);
}
