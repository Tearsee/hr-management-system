package com.turing.service;

import com.turing.pojo.Messages;
import com.turing.pojo.PageBean;
import com.turing.pojo.Vacate;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface MessagesService {
    /**
     * 添加
     * @param messages
     */
    void send(Messages messages);

}
