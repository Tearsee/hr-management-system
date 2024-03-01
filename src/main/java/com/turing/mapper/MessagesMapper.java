package com.turing.mapper;

import com.turing.pojo.Employee;
import com.turing.pojo.Messages;
import com.turing.pojo.Vacate;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface MessagesMapper {

    /**
     * 添加
     * @param messages
     */
    @Insert("insert into messages values (#{eid},#{message})")
    void send(Messages messages);

    // 管理员操作
    /**
     * 查询所有
     * @return
     */
    @Select("select * from messages")
    List<Messages> receive();

}
