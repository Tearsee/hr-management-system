package com.turing.service.impl;

import com.turing.mapper.EmployeeMapper;
import com.turing.mapper.MessagesMapper;
import com.turing.pojo.Employee;
import com.turing.pojo.Messages;
import com.turing.pojo.PageBean;
import com.turing.service.AdministratorService;
import com.turing.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class AdministratorServiceImpl implements AdministratorService {
    // 创建sqlSession 工厂
    private static SqlSessionFactory factory = SqlSessionFactoryUtils.getSqlSessionFactory();

    /**
     * 查询所有
     *
     * @return
     */
    @Override
    public List<Employee> selectAll() {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);

        // 执行方法
        List<Employee> employees = employeeMapper.selectAll();

        // 释放资源
        sqlSession.close();

        // 返回查询结果
        return employees;
    }

    /**
     * 添加员工
     *
     * @param emp
     */
    @Override
    public void add(Employee emp) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);

        // 执行方法
        employeeMapper.add(emp);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();

    }

    /**
     * 分页查询
     * @param currentPage 当前页码
     * @param pageSize 每页展示条数
     * @return
     */
    @Override
    public PageBean<Employee> selectByPage(int currentPage, int pageSize) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);

        // 计算开始索引
        int begin = (currentPage - 1) * pageSize;
        // 计算查询条目数
        int size = pageSize;

        // 查询当前页数据
        List<Employee> rows = employeeMapper.selectByPage(begin, size);

        // 查询总记录数
        int totalCount = employeeMapper.selectTotalCount();

        // 封装PageBean 对象
        PageBean<Employee> pageBean = new PageBean<>();
        pageBean.setRows(rows);
        pageBean.setTotalCount(totalCount);

        // 释放资源
        sqlSession.close();

        return pageBean;
    }

    /**
     * 批量删除
     * @param ids
     */
    @Override
    public void deleteByIds(int[] ids) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);

        // 执行方法
        employeeMapper.deleteByIds(ids);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();

    }

    /**
     * 分页条件查询
     * @param currentPage
     * @param pageSize
     * @param employee
     * @return
     */
    @Override
    public PageBean<Employee> selectByPageAndCondition(int currentPage, int pageSize, Employee employee) {

        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);

        // 计算开始索引
        int begin = (currentPage - 1) * pageSize;
        // 计算查询条目数
        int size = pageSize;

        // 处理employee条件 ，设置模糊表达式
        String staffId = employee.getStaffId();
        if(staffId != null && staffId.length() > 0){
            employee.setStaffId("%" + staffId + "%");
        }

        String employeeName = employee.getEmployeeName();
        if(employeeName != null && employeeName.length() > 0){
            employee.setEmployeeName("%" + employeeName + "%");
        }

        // 查询当前页数据
        List<Employee> rows = employeeMapper.selectByPageAndCondition(begin, size,employee);

        // 查询总记录数
        int totalCount = employeeMapper.selectTotalCountByCondition(employee);

        // 封装PageBean 对象
        PageBean<Employee> pageBean = new PageBean<>();
        pageBean.setRows(rows);
        pageBean.setTotalCount(totalCount);

        // 释放资源
        sqlSession.close();

        return pageBean;
    }

    /**
     * 修改员工信息
     * @param employee
     */
    @Override
    public void updateById(Employee employee) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);

        // 执行方法
        employeeMapper.updateById(employee);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();
    }

    /**
     * 软删除
     * @param id
     */
    @Override
    public void softDeleteById(int id) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);

        // 执行方法
        employeeMapper.softDeleteById(id);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();
    }

    /**
     * 收件箱
     * @return
     */
    @Override
    public List<Messages> receive() {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        MessagesMapper messagesMapper = sqlSession.getMapper(MessagesMapper.class);

        // 执行方法
        List<Messages> receive = messagesMapper.receive();

        // 释放资源
        sqlSession.close();

        // 返回查询结果
        return receive;
    }
}
