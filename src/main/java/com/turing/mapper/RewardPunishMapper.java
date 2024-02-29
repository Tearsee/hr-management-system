package com.turing.mapper;

import com.turing.pojo.Employee;
import com.turing.pojo.RewardPunish;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface RewardPunishMapper {
    /**
     * 分页条件查询
     * @param begin
     * @param size
     * @return
     */

    List<RewardPunish> selectByPageAndCondition(@Param("begin") int begin, @Param("size") int size, @Param("rewardPunish") RewardPunish rewardPunish);

    /**
     * 根据条件查询总条数
     * @param rewardPunish
     * @return
     */
    int selectTotalCountByCondition(RewardPunish rewardPunish);


    /**
     * 添加员工
     * @param rewardPunish
     */
    @Insert("insert into emprp values (null,#{eid},#{rpDate},#{rpType},#{rpReason},#{rpPoint},#{remark})")
    void add(RewardPunish rewardPunish);

}
