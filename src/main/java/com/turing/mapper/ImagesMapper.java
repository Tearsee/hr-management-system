package com.turing.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;

public interface ImagesMapper {
    /**
     * 上传头像
     * @param path
     * @param eid
     */
    @Insert("INSERT INTO images (path,name,eid) VALUES (#{path},#{name},#{eid})")
    void upload(@Param("path") String path,@Param("name")String name,@Param("eid") int eid);
}
