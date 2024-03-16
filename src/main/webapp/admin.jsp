<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2024/2/29
  Time: 17:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <!--布局容器-->
    <style>
        .el-header {
            background-color: #B3C0D1;
            color: #333;
            line-height: 60px;
        }

        .el-aside {
            color: #333;
        }
    </style>

    <style>
        /* 选择器可以是具体的元素名称，如 p、h1 等 */
        #flag {
            /* 字体名称 */
            font-family: Microsoft YaHei, sans-serif;
            /* 字体大小 */
            font-size: 18px;
            /* 字体颜色 */
            color: #333;
            font-weight: bold; /* 字体加粗 */
        }
    </style>

</head>
<body>
<div id="app">

    <!--管理员页面导航栏-->
    <el-container style="height: 500px; border: 1px solid #eee">
        <el-header style="text-align: right; font-size: 12px">
            <%--            <span style="margin-left: 15px">人力资源管理系统</span>--%>
            <span style="float: left; text-align: left;" id="flag">人力资源管理系统</span>
            <span>${user.username}</span>
            <el-dropdown>
                <i class="el-icon-user" style="margin-right: 15px"></i>
                <el-dropdown-menu slot="dropdown">
                    <%--                    <el-dropdown-item><a href="http://localhost:8080/hr-management-system/login.jsp" onclick="">退出登录</a>--%>
                    <el-dropdown-item>
                        <form action="logout">
                            <input type="submit" value="退出登录"/>
                        </form>
                    </el-dropdown-item>

                    <el-dropdown-item>

                        <form action="uploadServlet" method="post" enctype="multipart/form-data">
                            <input type="file" name="image"/>
                            <input type="submit" value="上传头像"/>
                        </form>
                    </el-dropdown-item>

                </el-dropdown-menu>
            </el-dropdown>
        </el-header>

        <el-container>
            <!--侧边导航栏-->
            <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
                <div class="menu">
                    <el-menu :default-openeds="['1', '3']" @select="handleSelect">
                        <el-menu-item index="home"><i class="el-icon-s-home"></i>首页</el-menu-item>
                        <el-menu-item index="inbox" @click="receive"><i class="el-icon-message"></i>收件箱
                        </el-menu-item>
                        <el-submenu index="systemManage">
                            <template slot="title"><i class="el-icon-menu"></i>系统管理</template>

                            <el-menu-item index="employeeManage"><i class="el-icon-user"></i>员工管理</el-menu-item>
                            <%--                            <el-menu-item index="departmentManage">部门管理</el-menu-item>--%>

                        </el-submenu>
                        <el-submenu index="transactionManage">
                            <template slot="title"><i class="el-icon-more"></i>事务管理</template>

                            <el-menu-item-group>
                                <template slot="title">培训</template>
                                <el-menu-item index="trainManage" @click="selectByPageAndCondition_train">
                                    <i class="el-icon-s-order"></i>
                                    培训管理
                                </el-menu-item>
                                <el-menu-item index="trainAnnouncement" @click="selectByPage_announcement_admin">
                                    <i class="el-icon-files"></i>

                                    培训公告管理
                                </el-menu-item>
                            </el-menu-item-group>

                            <el-menu-item-group>
                                <template slot="title">请假</template>
                                <el-menu-item index="vacateManage" @click="selectByPageAndCondition_vacate">
                                    <i class="el-icon-reading"></i>
                                    请假审批
                                </el-menu-item>
                            </el-menu-item-group>
                            <el-menu-item-group>
                                <template slot="title">考勤</template>
                                <el-menu-item index="emprpManage" @click="selectByPageAndCondition_rewardPunish">
                                    <i class="el-icon-edit"></i>
                                    考勤表现
                                </el-menu-item>
                            </el-menu-item-group>
                            <el-menu-item-group>
                                <template slot="title">工资</template>
                                <el-menu-item index="salary" @click="selectByPageAndCondition_salary">
                                    <i class="el-icon-data-line"></i>
                                    工资管理
                                </el-menu-item>
                            </el-menu-item-group>

                        </el-submenu>

                        <el-menu-item index="register" @click="dialogVisible7 = true"><i
                                class="el-icon-circle-plus-outline"></i>注册员工账号
                        </el-menu-item>
                    </el-menu>
                </div>

            </el-aside>

            <el-container>
                <el-main>
                    <div v-show="currentPage_ === 'home'" style="width: 40%">
                        <el-calendar v-model="value_calendar">
                        </el-calendar>
                        <!-- 如果是文件路径 -->
                        <img src="upload/图片文件名.jpg" alt="图片描述" />
                    </div>
                    <div v-show="currentPage_ === 'employeeManage'">
                        <!--搜索表单-->
                        <el-form :inline="true" :model="employee" class="demo-form-inline">

                            <el-form-item label="员工在职状态">
                                <el-select v-model="employee.employmentStatus" placeholder="在职状态">
                                    <el-option label="在职" value="1"></el-option>
                                    <el-option label="离职" value="0"></el-option>
                                </el-select>
                            </el-form-item>

                            <el-form-item label="工号">
                                <el-input v-model="employee.staffId" placeholder="工号"></el-input>
                            </el-form-item>

                            <el-form-item label="员工名称">
                                <el-input v-model="employee.employeeName" placeholder="员工名称"></el-input>
                            </el-form-item>

                            <el-form-item label="员工编号">
                                <el-input v-model="employee.id" placeholder="员工编号"></el-input>
                            </el-form-item>

                            <el-form-item>
                                <el-button type="primary" @click="onSubmit">查询</el-button>
                            </el-form-item>
                        </el-form>
                        <!--按钮-->
                        <el-row>

                            <el-button type="danger" plain @click="deleteByIds">批量删除</el-button>
                            <el-button type="primary" plain @click="dialogVisible = true">新增</el-button>

                        </el-row>

                        <!--表格-->
                        <template>
                            <el-table
                                    :data="tableData"
                                    style="width: 100%"
                                    :row-class-name="tableRowClassName"
                                    @selection-change="handleSelectionChange"
                            >
                                <el-table-column
                                        type="selection"
                                        width="55">
                                </el-table-column>
                                <el-table-column3
                                        type="index"
                                        width="50">
                                </el-table-column3>

                                <el-table-column
                                        prop="id"
                                        label="员工编号"
                                        align="center"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="staffId"
                                        label="工号"
                                        align="center"
                                >
                                </el-table-column>
                                <el-table-column
                                        prop="employeeName"
                                        label="员工名称"
                                        align="center"
                                >
                                </el-table-column>
                                <el-table-column
                                        prop="age"
                                        align="center"
                                        label="年龄">
                                </el-table-column>

                                <el-table-column
                                        prop="email"
                                        align="center"
                                        label="邮箱">
                                </el-table-column>

                                <el-table-column
                                        prop="phone"
                                        align="center"
                                        label="联系电话">
                                </el-table-column>

                                <el-table-column
                                        prop="deptStr"
                                        align="center"
                                        label="所属部门">
                                </el-table-column>

                                <el-table-column
                                        prop="posId"
                                        align="center"
                                        label="职位ID">
                                </el-table-column>

                                <el-table-column
                                        prop="employmentStatusStr"
                                        align="center"
                                        label="在职状态">
                                </el-table-column>

                                <el-table-column
                                        align="center"
                                        label="操作">
                                    <template slot-scope="scope">
                                        <el-button @click="dialogVisible1=true;getupdate(scope.row)" type="primary"
                                                   round>编辑
                                        </el-button>
                                        <el-button @click="softDeleteById(scope.row.id)" type="danger" round>删除
                                        </el-button>
                                    </template>
                                </el-table-column>

                            </el-table>
                        </template>

                        <!--分页工具条-->
                        <el-pagination
                                @size-change="handleSizeChange"
                                @current-change="handleCurrentChange"
                                :current-page="currentPage"
                                :page-sizes="[5, 10, 15, 20]"
                                :page-size="5"
                                layout="total, sizes, prev, pager, next, jumper"
                                :total="totalCount">
                        </el-pagination>

                    </div>
                    <div v-show="currentPage_ === 'trainManage'">
                        <!--搜索表单-->
                        <el-form :inline="true" :model="train" class="demo-form-inline">

                            <el-form-item label="员工编号(id)">
                                <el-input v-model="train.eid" placeholder="员工编号(id)"></el-input>
                            </el-form-item>

                            <el-form-item>
                                <el-button type="primary" @click="onSubmit_train">查询</el-button>
                            </el-form-item>
                        </el-form>
                        <!--按钮-->
                        <el-row>

                            <el-button type="danger" plain @click="deleteByIds_train">批量删除</el-button>
                            <el-button type="primary" plain @click="dialogVisible3 = true">新增</el-button>

                        </el-row>

                        <!--表格-->
                        <template>
                            <el-table
                                    :data="tableData_train"
                                    style="width: 100%"
                                    :row-class-name="tableRowClassName"
                                    @selection-change="handleSelectionChange"
                            >
                                <el-table-column
                                        type="selection"
                                        width="55">
                                </el-table-column>
                                <el-table-column3
                                        type="index"
                                        width="50">
                                </el-table-column3>

                                <el-table-column
                                        prop="eid"
                                        align="center"
                                        label="员工编号">
                                </el-table-column>

                                <el-table-column
                                        prop="trainDate"
                                        align="center"
                                        label="培训日期">

                                    <template slot-scope="scope">

                                        <div>{{goTime(scope.row.trainDate)}}</div>

                                    </template>
                                </el-table-column>
                                <el-table-column
                                        prop="trainContent"
                                        align="center"
                                        label="培训内容">
                                </el-table-column>

                                <el-table-column
                                        prop="remark"
                                        align="center"
                                        label="成绩">
                                </el-table-column>

                                <el-table-column
                                        align="center"
                                        label="操作">

                                    <template slot-scope="scope">
                                        <el-button @click="dialogVisible2=true;getupdate_train(scope.row)"
                                                   type="primary"
                                                   round>编辑
                                        </el-button>
                                        <!--                                        <el-button @click="softDeleteById(scope.row.id)" type="danger" round>软删除-->
                                        </el-button>
                                    </template>

                                </el-table-column>

                            </el-table>
                        </template>

                        <!--分页工具条-->
                        <el-pagination
                                @size-change="handleSizeChange_train"
                                @current-change="handleCurrentChange_train"
                                :current-page="currentPage_train"
                                :page-sizes="[5, 10, 15, 20]"
                                :page-size="5"
                                layout="total, sizes, prev, pager, next, jumper"
                                :total="totalCount_train">
                        </el-pagination>

                    </div>
                    <div v-show="currentPage_ === 'trainAnnouncement'">

                        <!--按钮-->
                        <el-row>
                            <el-button type="primary" plain @click="dialogVisible4 = true">发布公告</el-button>
                        </el-row>

                        <!--表格-->
                        <template>
                            <el-table
                                    :data="tableData_announcement_admin"
                                    style="width: 100%"
                                    :row-class-name="tableRowClassName"
                            >
                                <el-table-column
                                        prop="id"
                                        label="序号"
                                        width="300px"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="detail"
                                        label="培训内容"
                                        width="900px"
                                >
                                </el-table-column>

                            </el-table>
                        </template>

                        <!--分页工具条-->
                        <el-pagination
                                @size-change="handleSizeChange_announcement_admin"
                                @current-change="handleCurrentChange_announcement_admin"
                                :current-page="currentPage_announcement_admin"
                                :page-sizes="[5, 10, 15, 20]"
                                :page-size="5"
                                layout="total, sizes, prev, pager, next, jumper"
                                :total="totalCount_announcement_admin">
                        </el-pagination>
                    </div>
                    <div v-show="currentPage_ === 'vacateManage'">

                        <!--搜索表单-->
                        <el-form :inline="true" :model="vacate" class="demo-form-inline">

                            <el-form-item label="员工编号(id)">
                                <el-input v-model="vacate.eid" placeholder="员工编号(id)"></el-input>
                            </el-form-item>

                            <el-form-item label="审批状态">
                                <%--                                <el-input v-model="vacate.status" placeholder="审批状态"></el-input>--%>

                                <el-select v-model="vacate.status" placeholder="审批状态">
                                    <el-option label="通过" value="1"></el-option>
                                    <el-option label="不通过" value="0"></el-option>
                                    <el-option label="待审核" value="2"></el-option>
                                </el-select>
                            </el-form-item>

                            <el-form-item>
                                <el-button type="primary" @click="onSubmit_vacate">查询</el-button>
                            </el-form-item>
                        </el-form>
                        <!--表格-->
                        <template>
                            <el-table
                                    :data="tableData_vacate"
                                    style="width: 100%"
                                    :row-class-name="tableRowClassName"
                            >
                                <el-table-column
                                        prop="id"
                                        label="序号"
                                        width="50px"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="eid"
                                        label="员工编号(id)"
                                        align="center"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="startDate"
                                        align="center"
                                        label="开始时间">

                                    <template slot-scope="scope">

                                        <div>{{goTime(scope.row.startDate)}}</div>

                                    </template>
                                </el-table-column>


                                <el-table-column
                                        prop="endDate"
                                        align="center"
                                        label="结束时间">

                                    <template slot-scope="scope">

                                        <div>{{goTime(scope.row.endDate)}}</div>

                                    </template>
                                </el-table-column>

                                <el-table-column
                                        prop="typeStr"
                                        label="请假类型"
                                        align="center"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="remark"
                                        label="备注"
                                        align="center"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="statusStr"
                                        label="审批状态"
                                        align="center"
                                >
                                </el-table-column>
                                <el-table-column
                                        align="center"
                                        label="操作">

                                    <template slot-scope="scope">
                                        <el-button @click="dialogVisible5=true;getupdate_vacate(scope.row)"
                                                   type="primary"
                                                   round>审阅
                                        </el-button>
                                        <!--                                        <el-button @click="softDeleteById(scope.row.id)" type="danger" round>软删除-->
                                        </el-button>
                                    </template>

                                </el-table-column>

                            </el-table>
                        </template>

                        <!--分页工具条-->
                        <el-pagination
                                @size-change="handleSizeChange_vacate"
                                @current-change="handleCurrentChange_vacate"
                                :current-page="currentPage_vacate"
                                :page-sizes="[5, 10, 15, 20]"
                                :page-size="5"
                                layout="total, sizes, prev, pager, next, jumper"
                                :total="totalCount_vacate">
                        </el-pagination>

                    </div>
                    <div v-show="currentPage_ === 'emprpManage'">
                        <!--搜索表单-->
                        <el-form :inline="true" :model="rewardPunish" class="demo-form-inline">

                            <el-form-item label="员工编号(id)">
                                <el-input v-model="rewardPunish.eid" placeholder="员工编号(id)"></el-input>
                            </el-form-item>

                            <el-form-item label="奖罚类型">
                                <%--                                <el-input v-model="rewardPunish.rpType" placeholder="奖罚类型"></el-input>--%>
                                <el-select v-model="rewardPunish.rpType" placeholder="奖罚类型">
                                    <el-option label="罚" value="0"></el-option>
                                    <el-option label="奖" value="1"></el-option>
                                </el-select>
                            </el-form-item>

                            <el-form-item>
                                <el-button type="primary" @click="onSubmit_rewardPunish">查询</el-button>
                            </el-form-item>
                        </el-form>

                        <!--按钮-->
                        <el-row>
                            <el-button type="primary" plain @click="dialogVisible6 = true">新增</el-button>
                        </el-row>

                        <!--表格-->
                        <template>
                            <el-table
                                    :data="tableData_rewardPunish"
                                    style="width: 100%"
                                    :row-class-name="tableRowClassName"
                            >
                                <el-table-column
                                        prop="id"
                                        label="序号"
                                        width="50px"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="eid"
                                        label="员工编号(id)"
                                        align="center"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="rpDate"
                                        align="center"
                                        label="奖罚时间">

                                    <template slot-scope="scope">

                                        <div>{{goTime(scope.row.rpDate)}}</div>

                                    </template>
                                </el-table-column>

                                <el-table-column
                                        prop="rpTypeStr"
                                        label="奖罚类型"
                                        align="center"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="rpReason"
                                        label="奖罚原因"
                                        align="center"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="rpPoint"
                                        label="奖罚分"
                                        align="center"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="remark"
                                        label="备注"
                                        align="center"
                                >
                                </el-table-column>

                                <%-- <el-table-column
                                         align="center"
                                         label="操作">

                                     <template slot-scope="scope">
                                         <el-button @click="dialogVisible5=true;getupdate_rewardPunish(scope.row)"
                                                    type="primary"
                                                    round>审阅
                                         </el-button>
                                         <!--                                        <el-button @click="softDeleteById(scope.row.id)" type="danger" round>软删除-->
                                         </el-button>
                                     </template>

                                 </el-table-column>--%>

                            </el-table>
                        </template>

                        <!--分页工具条-->
                        <el-pagination
                                @size-change="handleSizeChange_rewardPunish"
                                @current-change="handleCurrentChange_rewardPunish"
                                :current-page="currentPage_rewardPunish"
                                :page-sizes="[5, 10, 15, 20]"
                                :page-size="5"
                                layout="total, sizes, prev, pager, next, jumper"
                                :total="totalCount_rewardPunish">
                        </el-pagination>
                    </div>
                    <div v-show="currentPage_ === 'register'">

                        <el-dialog
                                title="注册"
                                :visible.sync="dialogVisible7"
                                width="50%"
                        >

                            <el-form ref="form" :model="user" label-width="55px">
                                <el-form-item label="用户名">
                                    <el-input v-model="user.username" placeholder="请输入2-9位的英文名字"></el-input>
                                </el-form-item>

                                <el-form-item label="密码">
                                    <el-input v-model="user.password"
                                              placeholder="请输入6-10位的密码只能包含数字字母下划线，其中至少包含数字和字母"></el-input>
                                </el-form-item>

                                <el-form-item label="工号">
                                    <el-input v-model="user.staffId"></el-input>
                                </el-form-item>

                                <el-form-item>
                                    <el-button type="primary" @click="addRegister">提交</el-button>
                                    <el-button @click="dialogVisible7 = false">取消</el-button>
                                </el-form-item>
                            </el-form>

                        </el-dialog>


                    </div>
                    <div v-show="currentPage_ === 'inbox'">
                        <!--表格-->
                        <template>
                            <el-table
                                    :data="tableData_messages"
                                    style="width: 100%"
                                    :row-class-name="tableRowClassName"
                            >
                                <el-table-column
                                        type="index"
                                        label="序号"
                                        width="50">
                                </el-table-column>

                                <el-table-column
                                        prop="staffId"
                                        label="工号"
                                        width="100px"
                                >
                                </el-table-column>
                                <el-table-column
                                        prop="employeeName"
                                        label="员工名字"
                                        width="150px"
                                >
                                </el-table-column>
                                <el-table-column
                                        prop="deptStr"
                                        label="所属部门"
                                        width="150px"
                                >
                                </el-table-column>
                                <el-table-column
                                        prop="employmentStatusStr"
                                        label="在职状态"
                                        width="150px"
                                >
                                </el-table-column>
                                <el-table-column
                                        prop="message"
                                        label="内容详情"
                                        width="800px"
                                >
                                </el-table-column>

                            </el-table>
                        </template>

                    </div>
                    <div v-show="currentPage_ === 'salary'">

                        <!--搜索表单-->
                        <el-form :inline="true" :model="salary" class="demo-form-inline">


                            <el-form-item label="员工名称">
                                <el-input v-model="salary.employeeName" placeholder="员工名称"></el-input>
                            </el-form-item>

                            <el-form-item label="日期">
                                <el-select v-model="salary.month" placeholder="请选择月份">
                                    <el-option
                                            v-for="item in options"
                                            :key="item.value"
                                            :label="item.label"
                                            :value="item.value">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item>
                                <el-button type="primary" @click="selectByPageAndCondition_salary">查询</el-button>
                            </el-form-item>
                        </el-form>
                        <!--按钮-->
                        <el-row>
                            <el-button type="primary" @click="dialogVisible9 = true">新增</el-button>
                        </el-row>
                        <!--表格-->
                        <template>
                            <el-table
                                    :data="tableData_salary"
                                    style="width: 100%"
                                    :row-class-name="tableRowClassName"
                            >
                                <el-table-column
                                        prop="staffId"
                                        label="工号"
                                        align="center"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="employeeName"
                                        label="员工名称"
                                        align="center"
                                >
                                </el-table-column>


                                <el-table-column
                                        prop="deptStr"
                                        label="所属部门"
                                        align="center"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="basicSalary"
                                        label="底薪"
                                        align="center"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="performance"
                                        label="业绩"
                                        align="center"
                                >
                                </el-table-column>

                                <el-table-column
                                        prop="sal"
                                        label="工资"
                                        align="center"
                                >
                                </el-table-column>


                            </el-table>

                            <!--分页工具条-->
                            <el-pagination
                                    @size-change="handleSizeChange_salary"
                                    @current-change="handleCurrentChange_salary"
                                    :current-page="currentPage_salary"
                                    :page-sizes="[5, 10, 15, 20]"
                                    :page-size="5"
                                    layout="total, sizes, prev, pager, next, jumper"
                                    :total="totalCount_salary">
                            </el-pagination>
                        </template>


                    </div>

                </el-main>


            </el-container>


        </el-container>
    </el-container>

    <!--员工-->

    <!--添加员工数据对话框表单-->
    <el-dialog
            title="添加员工"
            :visible.sync="dialogVisible"
            width="30%"
    >

        <el-form ref="form" :model="employee" label-width="80px">
            <el-form-item label="工号">
                <el-input v-model="employee.staffId"></el-input>
            </el-form-item>

            <el-form-item label="员工名称">
                <el-input v-model="employee.employeeName" placeholder="请输入中文名字"></el-input>
            </el-form-item>

            <el-form-item label="年龄">
                <el-input v-model="employee.age" placeholder="请输入年龄"></el-input>
            </el-form-item>

            <el-form-item label="邮箱">
                <el-input v-model="employee.email" placeholder="请输入邮箱"></el-input>
            </el-form-item>

            <el-form-item label="手机号">
                <el-input v-model="employee.phone" placeholder="请输入11位手机号码"></el-input>
            </el-form-item>

            <el-form-item label="部门编号">
                <el-input v-model="employee.deptId" placeholder="请输入部门编号(1-9)"></el-input>
            </el-form-item>

            <el-form-item label="职位ID">
                <el-input v-model="employee.posId"></el-input>
            </el-form-item>

            <el-form-item label="在职状态">
                <el-switch v-model="employee.employmentStatus"
                           active-value="1"
                           inactive-value="0"
                ></el-switch>
            </el-form-item>


            <el-form-item>
                <el-button type="primary" @click="addEmployee">提交</el-button>
                <el-button @click="dialogVisible = false">取消</el-button>
            </el-form-item>
        </el-form>

    </el-dialog>

    <!--修改数据对话框表单-->
    <el-dialog
            title="编辑员工信息"
            :visible.sync="dialogVisible1"
            width="30%"
    >
        <el-form ref="form" :model="employee" label-width="80px">
            <el-form-item label="工号">
                <el-input v-model="employee.staffId"></el-input>
            </el-form-item>

            <el-form-item label="员工名称">
                <el-input v-model="employee.employeeName"></el-input>
            </el-form-item>

            <el-form-item label="年龄">
                <el-input v-model="employee.age"></el-input>
            </el-form-item>

            <el-form-item label="邮箱">
                <el-input v-model="employee.email"></el-input>
            </el-form-item>

            <el-form-item label="手机号">
                <el-input v-model="employee.phone"></el-input>
            </el-form-item>

            <el-form-item label="部门编号">
                <el-input v-model="employee.deptId"></el-input>
            </el-form-item>

            <el-form-item label="职位ID">
                <el-input v-model="employee.posId"></el-input>
            </el-form-item>

            <el-form-item label="在职状态">
                <el-switch v-model="employee.employmentStatus"
                           active-value="1"
                           inactive-value="0"
                ></el-switch>
            </el-form-item>


            <el-form-item>
                <el-button type="primary" @click="updateById">提交</el-button>
                <el-button @click="dialogVisible1 = false">取消</el-button>
            </el-form-item>
        </el-form>

    </el-dialog>

    <!--培训-->

    <!--添加数据对话框表单-->
    <el-dialog
            title="添加培训计划"
            :visible.sync="dialogVisible3"
            width="30%"
    >

        <el-form ref="form" :model="train" label-width="80px">
            <el-form-item label="员工编号">
                <el-input v-model="train.eid"></el-input>
            </el-form-item>

            <el-form-item label="培训日期">
                <%-- <el-date-picker
                         v-model="train.trainDate"
                         align="right"
                         type="date"
                         placeholder="选择日期"
                         :picker-options="pickerOptions">
                 </el-date-picker>--%>

                <el-date-picker
                        v-model="train.trainDate"
                        type="date"
                        placeholder="选择日期">
                </el-date-picker>
            </el-form-item>


            <el-form-item label="培训内容">
                <el-input v-model="train.trainContent"></el-input>
            </el-form-item>

            <el-form-item label="成绩">
                <el-input v-model="train.remark" placeholder="0-100"></el-input>
            </el-form-item>

            <el-form-item>
                <el-button type="primary" @click="addTrain">提交</el-button>
                <el-button @click="dialogVisible3 = false">取消</el-button>
            </el-form-item>
        </el-form>

    </el-dialog>

    <!--修改数据对话框表单-->
    <el-dialog
            title="编辑员工信息"
            :visible.sync="dialogVisible2"
            width="30%"
    >
        <el-form ref="form" :model="train" label-width="80px">
            <el-form-item label="员工编号">
                <el-input v-model="train.eid"></el-input>
            </el-form-item>

            <el-form-item label="培训日期">
                <el-date-picker
                        v-model="train.trainDate"
                        align="right"
                        type="date"
                        placeholder="选择日期"
                        :picker-options="pickerOptions">
                </el-date-picker>
            </el-form-item>

            <el-form-item label="培训内容">
                <el-input v-model="train.trainContent"></el-input>
            </el-form-item>

            <el-form-item label="成绩">
                <el-input v-model="train.remark"></el-input>
            </el-form-item>

            <el-form-item>
                <el-button type="primary" @click="updateById_train">提交</el-button>
                <el-button @click="dialogVisible2 = false">取消</el-button>
            </el-form-item>
        </el-form>

    </el-dialog>

    <!--培训公告-->
    <!--添加数据对话框表单-->
    <el-dialog
            title="发布公告"
            :visible.sync="dialogVisible4"
            width="30%"
    >

        <el-form ref="form" :model="trainannounce" label-width="80px">
            <el-form-item label="详细内容">
                <el-input
                        type="textarea"
                        :rows="4"
                        placeholder="请输入内容"
                        v-model="trainannounce.detail">
                </el-input>
            </el-form-item>

            <el-form-item>
                <el-button type="primary" @click="addTrainAnnouncement">提交</el-button>
                <el-button @click="dialogVisible4 = false">取消</el-button>
            </el-form-item>
        </el-form>

    </el-dialog>

    <!--批阅表单-->
    <el-dialog
            title="审批请假"
            :visible.sync="dialogVisible5"
            width="30%"
    >
        <el-form ref="form" :model="vacate" label-width="80px">
            <el-form-item>
                <el-switch v-model="vacate.status"
                           active-value="1"
                           inactive-value="0"
                           active-text="通过"
                           inactive-text="不通过"
                ></el-switch>
            </el-form-item>

            <el-form-item>
                <el-button type="primary" @click="updateById_vacate">提交</el-button>
                <el-button @click="dialogVisible5 = false">取消</el-button>
            </el-form-item>
        </el-form>

    </el-dialog>

    <!--考勤表单-->
    <!--添加员工数据对话框表单-->
    <el-dialog
            title="添加奖罚"
            :visible.sync="dialogVisible6"
            width="35%"
    >

        <el-form ref="form" :model="rewardPunish" label-width="80px">
            <el-form-item label="员工编号(id)" label-width="100px">
                <el-input v-model="rewardPunish.eid"></el-input>
            </el-form-item>

            <el-form-item label="奖罚日期" label-width="100px">
                <el-date-picker
                        v-model="rewardPunish.rpDate"
                        type="date"
                        placeholder="选择日期">
                </el-date-picker>
            </el-form-item>


            <el-form-item label="奖罚类型" label-width="100px">
                <el-switch v-model="rewardPunish.rpType"
                           active-value="1"
                           inactive-value="0"
                           active-text="奖"
                           inactive-text="罚"
                ></el-switch>
            </el-form-item>


            <el-form-item label="奖罚原因" label-width="100px">
                <el-input v-model="rewardPunish.rpReason"></el-input>
            </el-form-item>

            <el-form-item label="奖罚分" label-width="100px">
                <el-input v-model="rewardPunish.rpPoint" placeholder="0-100"></el-input>
            </el-form-item>

            <el-form-item label="备注" label-width="100px">
                <el-input v-model="rewardPunish.remark"></el-input>
            </el-form-item>

            <el-form-item>
                <el-button type="primary" @click="addRewardPunish">提交</el-button>
                <el-button @click="dialogVisible6 = false">取消</el-button>
            </el-form-item>
        </el-form>

    </el-dialog>

    <!--添加数据对话框表单-->
    <el-dialog
            title="添加员工工资"
            :visible.sync="dialogVisible9"
            width="30%"
    >

        <el-form ref="form" :model="salary" label-width="80px">
            <el-form-item label="员工ID">
                <el-input v-model="salary.eid"></el-input>
            </el-form-item>

            <el-form-item label="工资">
                <%--                <el-input v-model="salary.sal"></el-input>--%>
                <el-input-number v-model="salary.sal" :min="2500" :step="100" label="工资">

                </el-input-number>
            </el-form-item>


            <el-form-item label="底薪">
                <el-input-number v-model="salary.basicSalary" :min="2500" :step="100" label="工资">

                </el-input-number>
            </el-form-item>

            <el-form-item label="业绩">
                <el-input-number v-model="salary.performance" :min="0" :step="100" label="工资">

                </el-input-number>
            </el-form-item>

            <el-form-item label="日期">
                <el-select v-model="salary.month" placeholder="请选择月份">
                    <el-option
                            v-for="item in options"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                    </el-option>
                </el-select>
            </el-form-item>

            <el-form-item>
                <el-button type="primary" @click="addSalary">提交</el-button>
                <el-button @click="dialogVisible9 = false">取消</el-button>
            </el-form-item>
        </el-form>

    </el-dialog>

</div>

<script src="js/vue.js"></script>
<script src="element-ui/lib/index.js"></script>
<link rel="stylesheet" href="element-ui/lib/theme-chalk/index.css">

<script src="js/axios-0.18.0.js"></script>

<script>

    new Vue({
        el: "#app",
        mounted() {
            this.selectAll();
        },
        methods: {
            tableRowClassName({row, rowIndex}) {
                if (rowIndex === 1) {
                    return 'warning-row';
                } else if (rowIndex === 3) {
                    return 'success-row';
                }
                return '';
            },
            // 复选框选中后执行的方法
            handleSelectionChange(val) {
                this.multipleSelection = val;

                console.log(this.multipleSelection)
            },
            // 查询方法
            onSubmit() {
                // console.log(this.employee);
                this.selectAll();
            },
            // 根据条件分页查询
            selectAll() {
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/admin/selectByPageAndCondition?currentPage=" + this.currentPage + "&pageSize=" + this.pageSize,
                    data: this.employee
                }).then(resp => {
                        // 设置表格数据
                        this.tableData = resp.data.rows; //{rows:[],totoalCount}
                        this.totalCount = resp.data.totalCount;
                    }
                )
            },
            // 分页查询
            selectAll2() {
                axios({
                    method: "get",
                    url: "http://localhost:8080/hr-management-system/admin/selectByPage?currentPage=" + this.currentPage + "&pageSize=" + this.pageSize,
                }).then(resp => {
                        // 设置表格数据
                        this.tableData = resp.data.rows; //{rows:[],totoalCount}
                        this.totalCount = resp.data.totalCount;
                    }
                )
            },
            // 添加数据
            addEmployee() {

                var _this = this;
                //console.log(this.employee);
                //提交表单数据,发送异步请求
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/admin/add",
                    data: _this.employee
                }).then(function (resp) {
                    //判断响应标识
                    if (resp.data == "success") {

                        //关闭窗口
                        _this.dialogVisible = false;

                        //重新加载页面
                        _this.selectAll2();

                        //成功提示框
                        _this.$message({
                            message: '恭喜你，添加成功',
                            type: 'success'
                        });

                    } else if (resp.data == "repeat_sdfId") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '该工号已存在',
                            type: 'error'
                        });

                    } else if (resp.data == "format_empname") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '名字格式有误',
                            type: 'error'
                        });

                    } else if (resp.data == "format_empage") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '年龄格式有误',
                            type: 'error'
                        });

                    } else if (resp.data == "format_email") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '邮箱格式有误',
                            type: 'error'
                        });
                    } else if (resp.data == "format_tel") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '手机号码格式有误',
                            type: 'error'
                        });

                    } else if (resp.data == "format_dept") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '部门编号格式有误',
                            type: 'error'
                        });

                    }

                })
            },
            updateById() {
                var _this = this;
                //提交表单数据,发送异步请求
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/admin/updateById",
                    data: _this.employee
                }).then(function (resp) {
                    //判断响应标识
                    if (resp.data == "success") {
                        //关闭窗口
                        _this.dialogVisible1 = false;

                        //重新加载页面
                        _this.selectAll2();

                        //成功提示框
                        _this.$message({
                            message: '恭喜你，编辑成功',
                            type: 'success'
                        });
                    } else if (resp.data == "repeat_sdfId") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '工号重复',
                            type: 'error'
                        });

                    } else if (resp.data == "format_empname") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '名字格式有误',
                            type: 'error'
                        });

                    } else if (resp.data == "format_empage") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '年龄格式有误',
                            type: 'error'
                        });

                    } else if (resp.data == "format_email") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '邮箱格式有误',
                            type: 'error'
                        });
                    } else if (resp.data == "format_tel") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '手机号码格式有误',
                            type: 'error'
                        });

                    } else if (resp.data == "format_dept") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '部门编号格式有误',
                            type: 'error'
                        });

                    }

                })
            },
            // 修改数据
            getupdate(row) {
                this.employee.id = row.id;
                this.employee.staffId = row.staffId;
                this.employee.employeeName = row.employeeName;
                this.employee.age = row.age;
                this.employee.employmentStatus = row.employmentStatus;
                this.employee.email = row.email;
                this.employee.phone = row.phone;
                this.employee.deptId = row.deptId;
                this.employee.posId = row.posId;
            },
            // 批量删除
            deleteByIds() {
                // 弹出确认框
                this.$confirm('此操作将永久删除该员工, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    // 删除成功逻辑
                    for (let i = 0; i < this.multipleSelection.length; i++) {
                        let selectionElement = this.multipleSelection[i];
                        this.selectedIds[i] = selectionElement.id;
                    }

                    // 发送异步请求
                    axios({
                        method: "post",
                        url: "http://localhost:8080/hr-management-system/admin/deleteByIds",
                        data: this.selectedIds
                    }).then(resp => {

                        if (resp.data == "success") {
                            // 重新加载页面
                            this.selectAll()

                            //成功提示框
                            this.$message({
                                message: '恭喜你，删除成功',
                                type: 'success'
                            });
                        }
                    })
                }).catch(() => {
                    // 取消删除逻辑
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                })
            }
            ,
            // 删除单条数据(软删除)
            softDeleteById(id) {
                // 弹出确认框
                this.$confirm('此操作将软删除该员工, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    // 删除成功逻辑
                    // 发送异步请求
                    axios({
                        method: "get",
                        url: "http://localhost:8080/hr-management-system/admin/softDeleteById?id=" + id,
                    }).then(resp => {

                        if (resp.data == "success") {
                            // 重新加载页面
                            this.selectAll()

                            //成功提示框
                            this.$message({
                                message: '恭喜你，软删除成功',
                                type: 'success'
                            });
                        }
                    })
                }).catch(() => {
                    // 取消删除逻辑
                    this.$message({
                        type: 'info',
                        message: '已取消软删除'
                    });
                })
            },
            //分页
            handleSizeChange(val) {
                //console.log(`每页 ${val} 条`);

                // 重新设置展示页数
                this.pageSize = val;

                // 重新查询 分页 数据
                this.selectAll();

            }
            ,
            handleCurrentChange(val) {
                console.log(`当前页: ${val}`); //   当前页 : 8
                // val : currentPage

                // 重新设置当前页码
                this.currentPage = val;

                // 重新查询 分页 数据
                this.selectAll();
            }
            ,
            // 培训增删改查

            // 添加数据
            addTrain() {
                var _this = this;
                //console.log(this.employee);
                //提交表单数据,发送异步请求
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/train/add",
                    data: _this.train
                }).then(function (resp) {
                    //判断响应标识
                    if (resp.data == "success") {

                        //关闭窗口
                        _this.dialogVisible3 = false;

                        //重新加载页面
                        _this.selectByPage();

                        //成功提示框
                        _this.$message({
                            message: '恭喜你，添加成功',
                            type: 'success'
                        });

                    } else if (resp.data == "repeat_eid") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '员工编号不存在，请重新输入',
                            type: 'error'
                        });

                    } else if (resp.data == "repeat_remark") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '输入成绩应处于0-100之间',
                            type: 'error'
                        });

                    }

                })
            },
            handleOpen(key, keyPath) {
                console.log(key, keyPath);
            },
            handleClose(key, keyPath) {
                console.log(key, keyPath);
            },
            // 点击侧边导航栏-->右侧动态变化
            handleSelect(index) {
                this.currentPage_ = index;
            },
            // 修改数据
            updateById_train() {
                var _this = this;
                //提交表单数据,发送异步请求
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/train/updateById",
                    data: _this.train
                }).then(function (resp) {
                    //判断响应标识
                    if (resp.data == "success") {
                        //关闭窗口
                        _this.dialogVisible2 = false;

                        //重新加载页面
                        _this.selectByPage();

                        //成功提示框
                        _this.$message({
                            message: '恭喜你，编辑成功',
                            type: 'success'
                        });
                    } else if (resp.data == "repeat_eid") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '员工编号不存在，请重新输入',
                            type: 'error'
                        });

                    } else if (resp.data == "repeat_remark") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '输入成绩应处于0-100之间',
                            type: 'error'
                        });

                    }
                })
            },
            // 修改数据
            getupdate_train(row) {
                this.train.id = row.id;
                this.train.eid = row.eid;
                this.train.trainDate = row.trainDate;
                this.train.age = row.age;
                this.train.trainContent = row.trainContent;
                this.train.remark = row.remark;
            },
            // 批量删除
            deleteByIds_train() {
                // 弹出确认框
                this.$confirm('此操作将永久删除该员工, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    // 删除成功逻辑
                    for (let i = 0; i < this.multipleSelection.length; i++) {
                        let selectionElement = this.multipleSelection[i];
                        this.selectedIds[i] = selectionElement.id;
                    }

                    // 发送异步请求
                    axios({
                        method: "post",
                        url: "http://localhost:8080/hr-management-system/train/deleteByIds",
                        data: this.selectedIds
                    }).then(resp => {

                        if (resp.data == "success") {
                            // 重新加载页面
                            this.selectByPage();

                            //成功提示框
                            this.$message({
                                message: '恭喜你，删除成功',
                                type: 'success'
                            });
                        }
                    })


                }).catch(() => {
                    // 取消删除逻辑
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                })
            }
            ,
            // 培训查询
            // 常规查询所有
            selectAll_train() {
                axios({
                    method: "get",
                    url: "http://localhost:8080/hr-management-system/train/selectAll"
                }).then(resp => {
                        // 设置表格数据
                        this.tableData_train = resp.data; //{rows:[],totoalCount}
                        // this.totalCount = resp.data.totalCount;
                    }
                )
            },
            // 分页查询
            selectByPage() {
                axios({
                    method: "get",
                    url: "http://localhost:8080/hr-management-system/train/selectByPage?currentPage_train=" + this.currentPage_train + "&pageSize_train=" + this.pageSize_train,
                }).then(resp => {
                        // 设置表格数据
                        this.tableData_train = resp.data.rows; //{rows:[],totoalCount}
                        this.totalCount_train = resp.data.totalCount;
                    }
                )
            },
            //分页
            handleSizeChange_train(val) {
                //console.log(`每页 ${val} 条`);

                // 重新设置展示页数
                this.pageSize_train = val;

                // 重新查询 分页 数据
                this.selectByPage();

            },
            handleCurrentChange_train(val) {
                console.log(`当前页: ${val}`); //   当前页 : 8
                // val : currentPage

                // 重新设置当前页码
                this.currentPage_train = val;

                // 重新查询 分页 数据
                this.selectByPage();
            },
            // 查询方法
            onSubmit_train() {
                // console.log(this.employee);
                this.selectByPageAndCondition_train();
            },
            // 根据条件分页查询
            selectByPageAndCondition_train() {
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/train/selectByPageAndCondition?currentPage_train=" + this.currentPage_train + "&pageSize_train=" + this.pageSize_train,
                    data: this.train
                }).then(resp => {
                        // 设置表格数据
                        this.tableData_train = resp.data.rows; //{rows:[],totoalCount}
                        this.totalCount_train = resp.data.totalCount;
                    }
                )
            },
            // 分页查询公告
            selectByPage_announcement_admin() {
                axios({
                    method: "get",
                    url: "http://localhost:8080/hr-management-system/announcement/selectByPage?currentPage_announcement=" + this.currentPage_announcement_admin + "&pageSize_announcement=" + this.pageSize_announcement_admin,
                }).then(resp => {
                        // 设置表格数据
                        this.tableData_announcement_admin = resp.data.rows; //{rows:[],totoalCount}
                        this.totalCount_announcement_admin = resp.data.totalCount;
                    }
                )
            },
            //分页
            handleSizeChange_announcement_admin(val) {
                //console.log(`每页 ${val} 条`);

                // 重新设置展示页数
                this.pageSize_announcement_admin = val;

                // 重新查询 分页 数据
                this.selectByPage_announcement_admin();

            }
            ,
            handleCurrentChange_announcement_admin(val) {
                console.log(`当前页: ${val}`); //   当前页 : 8
                // val : currentPage

                // 重新设置当前页码
                this.currentPage_announcement_admin = val;

                // 重新查询 分页 数据
                this.selectByPage_announcement_admin();
            },
            // 添加培训公告
            addTrainAnnouncement() {
                var _this = this;
                //console.log(this.employee);
                //提交表单数据,发送异步请求
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/announcement/add",
                    data: _this.trainannounce
                }).then(function (resp) {
                    //判断响应标识
                    if (resp.data == "success") {

                        //关闭窗口
                        _this.dialogVisible4 = false;

                        //重新加载页面
                        _this.selectByPage_announcement_admin();

                        //成功提示框
                        _this.$message({
                            message: '恭喜你，添加成功',
                            type: 'success'
                        });

                    }

                })
            },
            // 分页条件查询
            selectByPageAndCondition_vacate() {
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/vacate/selectByPageAndCondition?currentPage_vacate=" + this.currentPage_vacate + "&pageSize_vacate=" + this.pageSize_vacate,
                    data: this.vacate
                }).then(resp => {
                        // 设置表格数据
                        this.tableData_vacate = resp.data.rows; //{rows:[],totoalCount}
                        // 设置总条数
                        this.totalCount_vacate = resp.data.totalCount;
                    }
                )
            },
            // 查询方法
            onSubmit_vacate() {
                // console.log(this.employee);
                this.selectByPageAndCondition_vacate();
            },
            //分页
            handleSizeChange_vacate(val) {
                //console.log(`每页 ${val} 条`);

                // 重新设置展示页数
                this.pageSize_vacate = val;

                // 重新查询 分页 数据
                this.selectByPageAndCondition_vacate();

            },
            handleCurrentChange_vacate(val) {
                console.log(`当前页: ${val}`); //   当前页 : 8
                // val : currentPage

                // 重新设置当前页码
                this.currentPage_vacate = val;

                // 重新查询 分页 数据
                this.selectByPageAndCondition_vacate();
            },
            updateById_vacate() {
                var _this = this;
                //提交表单数据,发送异步请求
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/vacate/updateById?id=" + _this.vacate.id + "&status=" + _this.vacate.status,
                    // data: _this.vacate
                }).then(function (resp) {
                    //判断响应标识
                    if (resp.data == "success") {
                        //关闭窗口
                        _this.dialogVisible5 = false;

                        //重新加载页面
                        _this.selectByPageAndCondition_vacate();

                        //成功提示框
                        _this.$message({
                            message: '恭喜你，编辑成功',
                            type: 'success'
                        });
                    }
                })
            },
            // 回显数据到表单上
            getupdate_vacate(row) {
                this.vacate.id = row.id;
            },
            // 查询方法
            onSubmit_rewardPunish() {
                // console.log(this.employee);
                this.selectByPageAndCondition_rewardPunish();
            },
            //分页
            handleSizeChange_rewardPunish(val) {
                //console.log(`每页 ${val} 条`);

                // 重新设置展示页数
                this.pageSize_rewardPunish = val;

                // 重新查询 分页 数据
                this.selectByPageAndCondition_rewardPunish();

            },
            handleCurrentChange_rewardPunish(val) {
                console.log(`当前页: ${val}`); //   当前页 : 8
                // val : currentPage

                // 重新设置当前页码
                this.currentPage_rewardPunish = val;

                // 重新查询 分页 数据
                this.selectByPageAndCondition_rewardPunish();
            },
            // 分页条件查询
            selectByPageAndCondition_rewardPunish() {
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/rewardPunish/selectByPageAndCondition?currentPage_rewardPunish=" + this.currentPage_rewardPunish + "&pageSize_rewardPunish=" + this.pageSize_rewardPunish,
                    data: this.rewardPunish
                }).then(resp => {
                        // 设置表格数据
                        this.tableData_rewardPunish = resp.data.rows; //{rows:[],totoalCount}
                        // 设置总条数
                        this.totalCount_rewardPunish = resp.data.totalCount;
                    }
                )
            },
            // 添加数据
            addRewardPunish() {

                var _this = this;
                //console.log(this.employee);
                //提交表单数据,发送异步请求
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/rewardPunish/add",
                    data: _this.rewardPunish
                }).then(function (resp) {
                    //判断响应标识
                    if (resp.data == "success") {

                        //关闭窗口
                        _this.dialogVisible6 = false;

                        //重新加载页面
                        _this.selectByPageAndCondition_rewardPunish();

                        //成功提示框
                        _this.$message({
                            message: '恭喜你，添加成功',
                            type: 'success'
                        });

                    } else if (resp.data == "repeat_eid") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '员工编号不存在，请重新输入',
                            type: 'error'
                        });

                    } else if (resp.data == "repeat_remark") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '输入成绩应处于0-100之间',
                            type: 'error'
                        });

                    }

                })
            },
            // 注册员工账号
            addRegister() {
                var _this = this;
                //console.log(this.employee);
                //提交表单数据,发送异步请求
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/register/add",
                    data: _this.user
                }).then(function (resp) {
                    //判断响应标识
                    if (resp.data == "success") {

                        //关闭窗口
                        _this.dialogVisible7 = false;

                        //重新加载页面
                        _this.selectByPage_announcement_admin();

                        //成功提示框
                        _this.$message({
                            message: '恭喜你，添加成功',
                            type: 'success'
                        });

                    } else if (resp.data == "fail1") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '用户名重复',
                            type: 'error'
                        });

                    } else if (resp.data == "fail2") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '工号重复',
                            type: 'error'
                        });

                    } else if (resp.data == "fail3") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '用户名和工号都重复',
                            type: 'error'
                        });
                    } else if (resp.data == "format_username") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '用户名或密码格式有误',
                            type: 'error'
                        });

                    } else if (resp.data == "format_password") {
                        // 用户名或者密码重复逻辑
                        //成功提示框
                        _this.$message({
                            message: '用户名或密码格式有误',
                            type: 'error'
                        });

                    }

                })


            },

            // 分页查询
            receive() {
                axios({
                    method: "get",
                    url: "http://localhost:8080/hr-management-system/admin/receive"
                }).then(resp => {
                        // 设置表格数据
                        this.tableData_messages = resp.data; //{rows:[],totoalCount}
                    }
                )
            },
            goTime(val) {
                var timestamp4 = new Date(val);
                //利用拼接正则等手段转化为yyyy-MM-dd hh:mm:ss 格式
                return timestamp4.toLocaleDateString().replace(/\//g, "-") + " " + timestamp4.toTimeString().substr(0, 8);
            },

            // 分页查询
            selectByPageAndCondition_salary() {
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/salary/selectByPageAndCondition?currentPage_salary=" + this.currentPage_salary + "&pageSize_salary=" + this.pageSize_salary,
                    data: this.salary
                }).then(resp => {
                        // 设置表格数据
                        this.tableData_salary = resp.data.rows;
                        this.totalCount_salary = resp.data.totalCount;
                    }
                )
            },

            // 添加数据
            addSalary() {
                var _this = this;
                //console.log(this.employee);
                //提交表单数据,发送异步请求
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/salary/add",
                    data: _this.salary
                }).then(function (resp) {
                    //判断响应标识
                    if (resp.data == "success") {

                        //关闭窗口
                        _this.dialogVisible9 = false;

                        //重新加载页面
                        _this.selectSalary();

                        //成功提示框
                        _this.$message({
                            message: '恭喜你，添加成功',
                            type: 'success'
                        });

                    } else if (resp.data == "error_eid") {

                        //成功提示框
                        _this.$message({
                            message: '该员工编号不存在,请重新输入',
                            type: 'error'
                        });

                    } else if (resp.data == "error_sal") {

                        //成功提示框
                        _this.$message({
                            message: '底薪不能大于工资,请重新输入',
                            type: 'error'
                        });
                    }

                })
            },
            //分页
            handleSizeChange_salary(val) {
                //console.log(`每页 ${val} 条`);

                // 重新设置展示页数
                this.pageSize_salary = val;

                // 重新查询 分页 数据
                this.selectByPageAndCondition_salary();

            },
            handleCurrentChange_salary(val) {
                console.log(`当前页: ${val}`); //   当前页 : 8
                // val : currentPage

                // 重新设置当前页码
                this.currentPage_salary = val;

                // 重新查询 分页 数据
                this.selectByPageAndCondition_salary();
            },

        },
        data() {
            return {
                // 员工总条数
                totalCount: 100,

                // 培训总条数
                totalCount_train: 100,

                // 每页显示的条数
                pageSize: 5,


                // 选中的id int[]数组
                selectedIds: [],

                // 员工 当前页码
                currentPage: 1,

                // 培训 当前页码
                currentPage_train: 1,

                // 每页显示的条数
                pageSize_train: 5,

                //当前页面
                currentPage_: 'home',

                // 添加数据对话框是否展示的标记
                dialogVisible: false,

                // 修改数据对话框是否展示的标记
                dialogVisible1: false,

                // 员工模型数据
                employee: {
                    id: '',
                    staffId: '',
                    employeeName: '',
                    age: "",
                    employmentStatus: "",
                    email: "",
                    phone: "",
                    deptId: "",
                    posId: ""
                },
                // 复选框选中数据集合
                multipleSelection: [],
                // 表格数据
                tableData: [{
                    id: '',
                    staffId: 'aaa111',
                    employeeName: '张三',
                    age: "18",
                    employmentStatus: "1",
                    email: "1437369274@qq.com",
                    phone: "13530696351",
                    deptId: "6",
                    posId: "23",
                }, {
                    staffId: 'aaa111',
                    employeeName: '张三',
                    age: "18",
                    employmentStatus: "1",
                    email: "1437369274@qq.com",
                    phone: "13530696351",
                    deptId: "6",
                    posId: "23",
                }, {
                    staffId: 'aaa111',
                    employeeName: '张三',
                    age: "18",
                    employmentStatus: "1",
                    email: "1437369274@qq.com",
                    phone: "13530696351",
                    deptId: "6",
                    posId: "23",
                }, {
                    staffId: 'aaa111',
                    employeeName: '张三',
                    age: "18",
                    employmentStatus: "1",
                    email: "1437369274@qq.com",
                    phone: "13530696351",
                    deptId: "6",
                    posId: "23",
                }],
                // 培训
                // 培训模型数据
                train: {
                    id: '',
                    eid: '',
                    trainDate: '',
                    trainContent: '',
                    remark: ''
                },
                // 表格数据
                tableData_train: [{
                    id: '1',
                    eid: '6',
                    trainDate: '2024-2-21',
                    trainContent: 'xxxxxxx',
                    remark: ''
                }, {
                    id: '1',
                    eid: '6',
                    trainDate: '2024-2-21',
                    trainContent: 'xxxxxxx',
                    remark: ''
                }, {
                    id: '1',
                    eid: '6',
                    trainDate: '2024-2-21',
                    trainContent: 'xxxxxxx',
                    remark: ''
                }, {
                    id: '1',
                    eid: '6',
                    trainDate: '2024-2-21',
                    trainContent: 'xxxxxxx',
                    remark: ''
                }],
                // 修改培训数据对话框是否展示的标记
                dialogVisible2: false,

                // 添加培训计划对话框是否展示的标记
                dialogVisible3: false,

                // 培训公告表格
                tableData_announcement_admin: [{
                    id: '1',
                    detail: "2024-2-21日井冈山培训"
                }, {
                    id: '2',
                    detail: "2024-2-21日井冈山培训"
                }, {
                    id: '3',
                    detail: "2024-2-21日井冈山培训"
                }, {
                    id: '4',
                    detail: "2024-2-21日井冈山培训"
                }],
                // 当前页码
                currentPage_announcement_admin: '1',
                // 页面展示数
                pageSize_announcement_admin: '5',
                // 总条数
                totalCount_announcement_admin: '100',
                // 培训公告添加表单
                dialogVisible4: false,
                // 文本域
                textarea: '',
                // 培训公告
                trainannounce: {
                    id: '',
                    detail: ''
                },
                // 模型数据
                vacate: {
                    id: '',
                    eid: '',
                    start_date: '',
                    end_date: '',
                    type: '',
                    remark: '',
                    status: ''
                }
                ,
                tableData_vacate: [{
                    id: '1',
                    eid: '5',
                    start_date: '2024:02:19',
                    end_date: '2024:02:20',
                    type: '1',
                    remark: '',
                    status: ''
                }, {
                    id: '2',
                    eid: '5',
                    start_date: '2024:02:19',
                    end_date: '2024:02:20',
                    type: '1',
                    remark: '',
                    status: ''
                }, {
                    id: '3',
                    eid: '5',
                    start_date: '2024:02:19',
                    end_date: '2024:02:20',
                    type: '1',
                    remark: '',
                    status: ''
                }, {
                    id: '4',
                    eid: '5',
                    start_date: '2024:02:19',
                    end_date: '2024:02:20',
                    type: '1',
                    remark: '',
                    status: ''
                }],
                // 当前页码
                currentPage_vacate: '1',
                // 页面展示数
                pageSize_vacate: '5',
                // 总条数
                totalCount_vacate: '100',
                // 审批对话框表单
                dialogVisible5: false,
                //
                value: '100',
                // 表格
                tableData_rewardPunish: [{
                    id: '1',
                    eid: '5',
                    rpDate: '2024-02-19',
                    rpType: '1',
                    rpReason: '',
                    rpPoint: '',
                    remark: ''
                }, {
                    id: '1',
                    eid: '5',
                    rpDate: '2024-02-19',
                    rpType: '1',
                    rpReason: '',
                    rpPoint: '',
                    remark: ''
                }, {
                    id: '1',
                    eid: '5',
                    rpDate: '2024-02-19',
                    rpType: '1',
                    rpReason: '',
                    rpPoint: '',
                    remark: ''
                }, {
                    id: '1',
                    eid: '5',
                    rpDate: '2024-02-19',
                    rpType: '1',
                    rpReason: '',
                    rpPoint: '',
                    remark: ''
                }, {
                    id: '1',
                    eid: '5',
                    rpDate: '2024-02-19',
                    rpType: '1',
                    rpReason: '',
                    rpPoint: '',
                    remark: ''
                },]
                ,
                // 模型数据
                rewardPunish: {
                    id: '',
                    eid: '',
                    rpDate: '',
                    rpType: '',
                    rpReason: '',
                    rpPoint: '',
                    remark: ''
                },
                // 当前页码
                currentPage_rewardPunish: '1',
                // 页面展示数
                pageSize_rewardPunish: '5',
                // 总条数
                totalCount_rewardPunish: '100',
                // 新增奖罚表单展示
                dialogVisible6: false
                ,
                // 新增奖罚表单展示
                dialogVisible7: false,
                user: {
                    id: '',
                    username: '',
                    password: '',
                    enabled: '',
                    staffId: ''
                },
                // 培训公告表格
                tableData_messages: [{
                    staffId: '',
                    employeeName: '',
                    deptId: '',
                    employmentStatus: '',
                    message: ''
                }, {
                    staffId: '',
                    employeeName: '',
                    deptId: '',
                    employmentStatus: '',
                    message: ''
                }, {
                    staffId: '',
                    employeeName: '',
                    deptId: '',
                    employmentStatus: '',
                    message: ''
                }, {
                    staffId: '',
                    employeeName: '',
                    deptId: '',
                    employmentStatus: '',
                    message: ''
                }],
                messages: {
                    eid: '',
                    message: ''
                },
                pickerOptions: {
                    disabledDate(time) {
                        return time.getTime() > Date.now();
                    },
                    shortcuts: [{
                        text: '今天',
                        onClick(picker) {
                            picker.$emit('pick', new Date());
                        }
                    }, {
                        text: '昨天',
                        onClick(picker) {
                            const date = new Date();
                            date.setTime(date.getTime() - 3600 * 1000 * 24);
                            picker.$emit('pick', date);
                        }
                    }, {
                        text: '一周前',
                        onClick(picker) {
                            const date = new Date();
                            date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
                            picker.$emit('pick', date);
                        }
                    }]
                },

                tableData_salary: [{
                    staffId: '',
                    employeeName: '',
                    deptId: '',
                    sal: '',
                    basicSalary: '',
                    performance: ''
                }, {
                    id: '',
                    eid: '',
                    sal: '',
                    basicSalary: '',
                    performance: ''
                }],
                salary: {
                    eid: '',
                    staffId: '',
                    employeeName: '',
                    deptId: '',
                    sal: '',
                    basicSalary: '',
                    performance: '',
                    month: ''
                },
                dialogVisible9: false
                ,

                value_calendar: new Date()

                ,
                // 当前页码
                currentPage_salary: '1',
                // 页面展示数
                pageSize_salary: '5',
                // 总条数
                totalCount_salary: '100',


                options: [{
                    value: '1',
                    label: '一月'
                }, {
                    value: '2',
                    label: '二月'
                }, {
                    value: '3',
                    label: '三月'
                }, {
                    value: '4',
                    label: '四月'
                }, {
                    value: '5',
                    label: '五月'
                }, {
                    value: '5',
                    label: '五月'
                }, {
                    value: '6',
                    label: '六月'
                }, {
                    value: '7',
                    label: '七月'
                }, {
                    value: '8',
                    label: '八月'
                }, {
                    value: '9',
                    label: '九月'
                }, {
                    value: '10',
                    label: '十月'
                }, {
                    value: '11',
                    label: '十一月'
                }, {
                    value: '12',
                    label: '十二月'
                }]
            }
        }
    })

</script>


</body>
</html>