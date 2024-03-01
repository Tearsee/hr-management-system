package com.turing.mapper;

import com.turing.pojo.Employee;
import com.turing.pojo.Train;
import org.apache.ibatis.annotations.*;

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

    /**
     * 批量删除
     * @param ids
     */
    void deleteByIds(@Param("ids") int[] ids);

    /**
     * 修改培训信息
     * @param train
     * @return
     */
    @Update("update emptrain set eid=#{eid},trainDate=#{trainDate},trainContent=#{trainContent},remark=#{remark} where id=#{id}")
    void updateById(Train train);


    /**
     * 分页查询
     * @param begin
     * @param size
     * @return
     */
    @Select("select * from emptrain limit #{begin},#{size}")
    List<Train> selectByPage(@Param("begin") int begin, @Param("size") int size);

    /**
     * 查询总条数
     * @return
     */
    @Select("select count(*) from emptrain")
    int selectTotalCount();

    /**
     * 分页条件查询
     * @param begin
     * @param size
     * @return
     */
    List<Train> selectByPageAndCondition(@Param("begin") int begin, @Param("size") int size,@Param("train") Train train);

    /**
     * 根据条件查询总条数
     * @param train
     * @return
     */
    int selectTotalCountByCondition(Train train);


    /**
     * 分页查询含成绩(个人)
     * @param begin
     * @param size
     * @return
     */
    @Select("select * from emptrain where eid=#{eid} limit #{begin},#{size}")
    List<Train> selectMarkByPageAndId(@Param("begin") int begin, @Param("size") int size,@Param("eid")int eid);

    /**
     * 查询总条数(个人)
     * @return
     */
    @Select("select count(*) from emptrain where eid=#{eid}")
    int selectMarkTotalCount(int eid);

    /**
     * 添加培训计划
     * @param train
     */
    @Insert("insert into emptrain values (null,#{eid},#{trainDate},#{trainContent},0)")
    void addByEmp(Train train);
}
