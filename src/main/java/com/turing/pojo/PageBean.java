package com.turing.pojo;

import java.util.List;

public class PageBean<T> {

    // 总记录数
    private int totalCount;

    // 页面数据
    private List<T> rows;

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }
}
