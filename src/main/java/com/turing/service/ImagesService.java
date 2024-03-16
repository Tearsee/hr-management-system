package com.turing.service;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;

public interface ImagesService {

    /**
     * 上传头像
     * @param path
     * @param name
     * @param eid
     */
    void upload(String path,String name,int eid);

}
