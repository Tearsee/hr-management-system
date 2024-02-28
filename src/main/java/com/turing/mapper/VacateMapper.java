package com.turing.mapper;

import com.turing.pojo.Vacate;
import org.apache.ibatis.annotations.Param;

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
}
