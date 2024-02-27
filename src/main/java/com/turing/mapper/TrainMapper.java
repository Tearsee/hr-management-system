package com.turing.mapper;

import com.turing.pojo.Employee;
import com.turing.pojo.Train;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface TrainMapper {

    // 管理员操作
    /**
     * 查询所有
     * @return
     */
    @Select("select * from emptrain")
    List<Train> selectAll();

    /**
     * 添加培训计划
     * @param train
     */
    @Insert("insert into emptrain values (null,#{eid},#{trainDate},#{trainContent},#{remark})")
    void add(Train train);
}
