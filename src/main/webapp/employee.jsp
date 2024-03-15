<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2024/2/29
  Time: 22:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%-- 获取 session 中传输的对象 user --%>
<jsp:useBean id="user" class="com.turing.pojo.User" scope="session"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
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
        .text {
            font-size: 14px;
        }

        .item {
            padding: 18px 0;
        }

        .box-card {
            width: 480px;
        }
    </style>

    <!--上传头像-->
    <style scoped>
        .avatar-uploader {
            border: 1px dashed #d9d9d9;
            border-radius: 6px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            width: 178px;
            height: 178px;
        }

        .avatar-uploader .el-upload:hover {
            border-color: #409eff;
        }

        .avatar-uploader-icon {
            font-size: 28px;
            color: #8c939d;
            width: 178px;
            height: 178px;
            line-height: 178px;
            text-align: center;
        }

        .avatar {
            width: 178px;
            height: 178px;
            display: block;
        }
    </style>

    <!--新版卡片-->
    <style>
        .text {
            font-size: 14px;
        }

        .item {
            margin-bottom: 18px;
        }

        .clearfix:before,
        .clearfix:after {
            display: table;
            content: "";
        }

        .clearfix:after {
            clear: both
        }

        .box-card {
            width: 480px;
        }
    </style>

    <!--布局栅栏-->
    <style>
        .el-row {
            margin-bottom: 20px;

            &:last-child {
                margin-bottom: 0;
            }
        }

        .el-col {
            border-radius: 4px;
        }

        .bg-purple-dark {
            background: #99a9bf;
        }

        .bg-purple {
            background: #d3dce6;
        }

        .bg-purple-light {
            background: #e5e9f2;
        }

        .grid-content {
            border-radius: 4px;
            min-height: 36px;
        }

        .row-bg {
            padding: 10px 0;
            background-color: #f9fafc;
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
    <el-dialog
            title="提示"
            :visible.sync="dialogVisible2"
            width="30%"
            :before-close="handleClose">
        <span>欢迎使用人力资源管理系统</span>
        <span slot="footer" class="dialog-footer">
<%--    <el-button @click="dialogVisible2 = false">取 消</el-button>--%>
        <el-button type="primary" @click="dialogVisible2 = false;selectOneById('${user.staffId}')">开始使用</el-button>
        </span>
    </el-dialog>

    <el-container style="height: 500px; border: 1px solid #eee">


        <el-header style="text-align: right; font-size: 12px">
            <span style="float: left; text-align: left;" id="flag">人力资源管理系统</span>

            <span>${user.staffId}</span>
            <el-dropdown>
                <i class="el-icon-user" style="margin-right: 15px"></i>
                <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item>
                        <form action="logout">
                            <input type="submit" value="退出登录"/>
                        </form>
                    </el-dropdown-item>
                </el-dropdown-menu>
            </el-dropdown>
        </el-header>

        <el-container>
            <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
                <el-menu :default-openeds="['1', '7']" @select="handleSelect">
                    <el-menu-item index="home"><i class="el-icon-s-home"></i>首页</el-menu-item>
                    <el-menu-item index="inbox" @click="dialogVisible5=true"><i class="el-icon-message"></i>邮箱
                    </el-menu-item>
                    <el-submenu index="2">
                        <template slot="title"><i class="el-icon-suitcase"></i>培训</template>
                        <el-menu-item index="announcement" @click="selectByPage_announcement"><i
                                class="el-icon-files"></i>
                            培训公告
                        </el-menu-item>
                        <el-menu-item index="join" @click="dialogVisible3=true">
                            <i class="el-icon-circle-plus-outline"></i>
                            参与培训
                        </el-menu-item>
                        <el-menu-item index="mark" @click="selectMarkByPageAndId">
                            <i class=" el-icon-paperclip"></i>
                            培训情况
                        </el-menu-item>
                    </el-submenu>

                    <el-submenu index="3">
                        <template slot="title"><i class="el-icon-news"></i>请假</template>
                        <el-menu-item index="vacate" @click="dialogVisible4=true">
                            <i class="el-icon-s-promotion"></i>
                            申请请假
                        </el-menu-item>

                    </el-submenu>

                    <el-submenu index="4">
                        <template slot="title"><i class="el-icon-date"></i>考勤</template>
                        <el-menu-item index="emprpManage" @click="selectByPageAndCondition_rewardPunish">
                            <i class="el-icon-s-order"></i>

                            考勤奖罚记录
                        </el-menu-item>
                    </el-submenu>

                    <el-submenu index="5">
                        <template slot="title"><i class="el-icon-s-finance"></i>工资管理</template>
                        <el-menu-item index="salary" @click="selectSalary">
                            <i class="el-icon-wallet"></i>
                            薪资
                        </el-menu-item>
                    </el-submenu>


                </el-menu>
            </el-aside>

            <el-container>

                <div v-show="currentPage_ === 'home'">
                    <el-main>

                        <el-card class="box-card">
                            <span>个人资料信息</span>
                            <span style="float: right">
                            <el-link icon="el-icon-edit"
                                     @click="dialogVisible1=true;getupdate(employee.id)">编辑资料信息</el-link>
                        </span>
                            <el-divider></el-divider>
                            <span>工号</span>
                            <span style="float: right">{{employee.staffId}}</span>
                            <el-divider></el-divider>
                            <span>年龄</span>
                            <span style="float: right">{{employee.age}}</span>
                            <el-divider></el-divider>
                            <span>邮箱</span>
                            <span style="float: right">{{employee.email}}</span>
                            <el-divider></el-divider>
                            <span>手机号</span>
                            <span style="float: right">{{employee.phone}}</span>
                            <el-divider></el-divider>
                            <span>部门ID</span>
                            <span style="float: right">{{employee.deptId}}</span>
                            <el-divider></el-divider>
                            <span>职位ID</span>
                            <span style="float: right">{{employee.posId}}</span>
                            <el-divider></el-divider>
                            <span>在职状态</span>
                            <span style="float: right">{{employee.employmentStatus}}</span>
                        </el-card>
                    </el-main>

                </div>
                <div v-show="currentPage_ === 'announcement'">
                    <el-main>
                        <!--表格-->
                        <template>
                            <el-table
                                    :data="tableData_announcement"
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
                                @size-change="handleSizeChange_announcement"
                                @current-change="handleCurrentChange_announcement"
                                :current-page="currentPage_announcement"
                                :page-sizes="[5, 10, 15, 20]"
                                :page-size="5"
                                layout="total, sizes, prev, pager, next, jumper"
                                :total="totalCount_announcement">
                        </el-pagination>
                    </el-main>
                </div>
                <div v-show="currentPage_ === 'mark'">
                    <el-main>
                        <!--表格-->
                        <template>
                            <el-table
                                    :data="tableData_mark"
                                    style="width: 100%"
                                    :row-class-name="tableRowClassName"
                            >
                                <el-table-column3
                                        type="index"
                                        width="50">
                                </el-table-column3>

                                <el-table-column
                                        prop="trainDate"
                                        align="center"
                                        label="培训日期">

                                    <template slot-scope="scope">

                                        <div>{{goTime(scope.row.trainDate)}}</div>

                                    </template>
                                </el-table-column>

                                <%--  <el-table-column align="center" prop="phone" label="活动时间" width="200">
                                      <template slot-scope="scope">
                                          <div>开始时间：</div>
                                          <div>{{goTime(scope.row.start_time)}}</div>
                                          <div>结束时间：</div>
                                          <div>{{goTime(scope.row.end_time)}}</div>
                                      </template>
                                  </el-table-column>--%>

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

                                <%-- <el-table-column
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

                                 </el-table-column>--%>
                            </el-table>
                        </template>

                        <!--分页工具条-->
                        <el-pagination
                                @size-change="handleSizeChange_mark"
                                @current-change="handleCurrentChange_mark"
                                :current-page="currentPage_mark"
                                :page-sizes="[5, 10, 15, 20]"
                                :page-size="5"
                                layout="total, sizes, prev, pager, next, jumper"
                                :total="totalCount_mark">
                        </el-pagination>
                    </el-main>
                </div>
                <div v-show="currentPage_ === 'join'">
                    <%--添加培训表单--%>
                    <el-dialog
                            title="添加个人培训计划"
                            :visible.sync="dialogVisible3"
                            width="30%"
                    >

                        <el-form ref="form" :model="train" label-width="80px">
                            <%--<el-form-item label="员工编号">
                                <el-input v-model="train.eid"></el-input>
                            </el-form-item>--%>

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

                            <el-form-item>
                                <el-button type="primary" @click="addByEmp">提交</el-button>
                                <el-button @click="dialogVisible3 = false">取消</el-button>
                            </el-form-item>
                        </el-form>

                    </el-dialog>


                </div>
                <div v-show="currentPage_ === 'vacate'">
                    <!--添加员工数据对话框表单-->
                    <el-dialog
                            title="申请请假"
                            :visible.sync="dialogVisible4"
                            width="30%"
                    >

                        <el-form ref="form" :model="vacate" label-width="80px">
                            <%-- <el-form-item label="员工Id">
                                 <el-input v-model="vacate.eid"></el-input>
                             </el-form-item>--%>

                            <el-form-item label="开始时间">
                                <el-date-picker
                                        v-model="vacate.start_date"
                                        align="right"
                                        type="date"
                                        placeholder="选择日期"
                                        :picker-options="pickerOptions">
                                </el-date-picker>
                            </el-form-item>

                            <el-form-item label="结束时间">
                                <el-date-picker
                                        v-model="vacate.end_date"
                                        align="right"
                                        type="date"
                                        placeholder="选择日期"
                                        :picker-options="pickerOptions">
                                </el-date-picker>
                            </el-form-item>

                            <el-form-item label="请假类型">
                                <%--                                <el-input v-model="vacate.type"></el-input>--%>


                                <el-select v-model="vacate.type" placeholder="请选择">
                                    <el-option
                                            v-for="item in options"
                                            :key="item.value"
                                            :label="item.label"
                                            :value="item.value">
                                    </el-option>
                                </el-select>
                            </el-form-item>

                            <el-form-item label="备注">
                                <el-input v-model="vacate.remark"></el-input>
                            </el-form-item>

                            <el-form-item>
                                <el-button type="primary" @click="vacateByEmp">提交</el-button>
                                <el-button @click="dialogVisible4 = false">取消</el-button>
                            </el-form-item>
                        </el-form>

                    </el-dialog>

                </div>
                <div v-show="currentPage_ === 'inbox'">
                    <!--添加员工数据对话框表单-->
                    <el-dialog
                            title="发送邮件"
                            :visible.sync="dialogVisible5"
                            width="30%"
                    >

                        <el-form ref="form" :model="vacate" label-width="80px">
                            <%--<el-form-item label="员工Id">
                                <el-input v-model="messages.eid"></el-input>
                            </el-form-item>--%>

                            <el-form-item label="内容">
                                <el-input v-model="messages.message"></el-input>
                            </el-form-item>

                            <el-form-item>
                                <el-button type="primary" @click="send">提交</el-button>
                                <el-button @click="dialogVisible5 = false">取消</el-button>
                            </el-form-item>
                        </el-form>

                    </el-dialog>


                </div>
                <div v-show="currentPage_ === 'emprpManage'">

                    <!--搜索表单-->
                    <el-form :inline="true" :model="rewardPunish" class="demo-form-inline">

                        <el-form-item label="奖罚类型">
                            <el-select v-model="rewardPunish.rpType" placeholder="请选择">
                                <el-option
                                        v-for="item in options_rp"
                                        :key="item.value"
                                        :label="item.label"
                                        :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>

                       <%-- <el-form-item label="奖罚日期">
                            <el-date-picker
                                    v-model="rewardPunish.rpDate"
                                    align="right"
                                    type="date"
                                    placeholder="选择日期"
                                    :picker-options="pickerOptions">
                            </el-date-picker>
                        </el-form-item>--%>

                        <el-form-item>
                            <el-button type="primary" @click="onSubmit_rewardPunish">查询</el-button>
                        </el-form-item>
                    </el-form>

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
                                    align="center"
                            >
                            </el-table-column>

                            <el-table-column
                                    prop="rpDate"
                                    align="center"
                                    width="300px"
                                    label="奖罚时间">

                                <template slot-scope="scope">

                                    <div>{{goTime(scope.row.rpDate)}}</div>

                                </template>
                            </el-table-column>

                            <el-table-column
                                    prop="rpTypeStr"
                                    label="奖罚类型"
                                    align="center"
                                    width="250px"
                            >
                            </el-table-column>

                            <el-table-column
                                    prop="rpReason"
                                    label="奖罚原因"
                                    align="center"
                                    width="250px"
                            >
                            </el-table-column>

                            <el-table-column
                                    prop="rpPoint"
                                    label="奖罚分"
                                    align="center"
                                    width="250px"
                            >
                            </el-table-column>

                            <el-table-column
                                    prop="remark"
                                    label="备注"
                                    align="center"
                                    width="350px"
                            >
                            </el-table-column>

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
                <div v-show="currentPage_ === 'salary'">
                    <!--搜索表单-->
                    <el-form :inline="true" :model="salary" class="demo-form-inline">

                        <el-form-item label="日期">
                            <el-select v-model="salary.month" placeholder="一月份">
                                <el-option
                                        v-for="item in options_sal"
                                        :key="item.value"
                                        :label="item.label"
                                        :value="item.value">
                                </el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" @click="selectSalary">查询</el-button>
                        </el-form-item>
                    </el-form>
                    <!--表格-->
                    <template>
                        <el-table
                                :data="tableData_salary"
                                style="width: 100%"
                                :row-class-name="tableRowClassName"
                        >
                           <%-- <el-table-column
                                    prop="month"
                                    label="月份"
                                    align="center"
                                    width="300px"
                            >
                            </el-table-column>--%>

                            <el-table-column
                                    prop="basicSalary"
                                    label="底薪"
                                    align="center"
                                    width="450px"

                            >
                            </el-table-column>

                            <el-table-column
                                    prop="performance"
                                    label="业绩"
                                    align="center"
                                    width="450px"
                            >
                            </el-table-column>

                            <el-table-column
                                    prop="sal"
                                    label="工资"
                                    align="center"
                                    width="450px"

                            >
                            </el-table-column>

                        </el-table>
                    </template>

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

                </div>
            </el-container>


        </el-container>
    </el-container>

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
                <el-button type="primary" @click="updateById">提交</el-button>
                <el-button @click="dialogVisible1 = false">取消</el-button>
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
            this.selectOneById();
        },
        data() {
            const item = {
                date: '2016-05-02',
                name: '王小虎',
                address: '上海市普陀区金沙江路 1518 弄'
            };
            return {
                // 当前页面
                currentPage_: 'home',
                // 当前页码
                currentPage_announcement: '1',
                // 页面展示数
                pageSize_announcement: '5',
                // 总条数
                totalCount_announcement: '100',
                size: '',
                tableData: Array(20).fill(item),
                currentDate: new Date(),
                imageUrl: "",
                form: {},
                tableData: [{
                    date: '2016-05-02',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1518 弄'
                }, {
                    date: '2016-05-04',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1517 弄'
                }, {
                    date: '2016-05-01',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1519 弄'
                }, {
                    date: '2016-05-03',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1516 弄'
                }],

                message: 'Hello, Vue!',
                // 品牌模型数据
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
                // 修改数据对话框是否展示的标记
                dialogVisible1: false,
                tableData_announcement: [{
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
                user: {
                    id: '',
                    username: '',
                    password: '',
                    enabled: '',
                    staffId: ''
                },
                dialogVisible2: true,
                // 成绩表格
                tableData_mark: [{
                    id: '1',
                    eid: '6',
                    trainDate: '2024-2-21',
                    trainContent: 'xxxxxxx',
                    remark: '',
                }, {
                    id: '1',
                    eid: '6',
                    trainDate: '2024-2-21',
                    trainContent: 'xxxxxxx',
                    remark: '',
                }, {
                    id: '1',
                    eid: '6',
                    trainDate: '2024-2-21',
                    trainContent: 'xxxxxxx',
                    remark: '',
                }, {
                    id: '1',
                    eid: '6',
                    trainDate: '2024-2-21',
                    trainContent: 'xxxxxxx',
                    remark: '',
                }],
                // 培训 当前页码
                currentPage_mark: 1,

                // 每页显示的条数
                pageSize_mark: 5,

                // 总条数
                totalCount_mark: 100,

                dialogVisible3: false,

                train: {
                    id: '',
                    eid: '',
                    trainDate: '',
                    trainContent: '',
                    remark: ''
                },
                dialogVisible4: false
                ,
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
                messages: {
                    eid: '',
                    message: ''
                },
                dialogVisible5: false
                ,
                options: [{
                    value: '0',
                    label: '病假'
                }, {
                    value: '1',
                    label: '事假'
                }],

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

                options_rp: [{
                    value: '0',
                    label: '罚'
                }, {
                    value: '1',
                    label: '奖'
                }],

                dialogVisible6: false
                ,

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
                }]
                ,

                value_calendar: new Date(),
                // 当前页码
                currentPage_salary: '1',
                // 页面展示数
                pageSize_salary: '5',
                // 总条数
                totalCount_salary: '100',
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
                options_sal: [{
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
        },
        methods: {
            //上传图片
            field101BeforeUpload(file) {
                var formData = new FormData();
                formData.append("file", file.file);
                //请求上传接口 pic()
                pic(formData).then((res) => {
                    this.imageUrl = res.msg;
                });
            },

            /** 修改按钮操作 */
            handleUpdate(row) {
                this.reset();
                this.fileList = [];
                const id = row.id || this.ids;
                getXssUpload(id).then((response) => {
                    this.form = response.data;
                    //注意
                    this.imageUrl = this.form.url
                });
            },
            /** 提交按钮 */
            submitForm() {
                this.$refs["form"].validate((valid) => {
                    if (valid) {
                        if (this.form.id != null) {
                            //注意提交时要把图片地址赋过来
                            this.form.url = this.imageUrl;
                            //修改保存
                            updateXssUpload(this.form).then((response) => {
                            });
                        } else {
                            //注意提交时要图片把地址赋过来
                            this.form.url = this.imageUrl;
                            //添加保存接口
                            addXssUpload(this.form).then((response) => {
                                this.$modal.msgSuccess("新增成功");
                            });
                        }
                    }
                });
            },
            // 员工个人查询
            selectOneById(staffId) {
                <%-- 调用对象 user 的 staffId 属性 --%>
                // const staffId = this.$session.user.staffId;
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/employee/selectOneById?staffId=" + staffId// 暂时写死
                }).then(resp => {
                        // 设置数据
                        this.employee.id = resp.data.id;
                        this.employee.staffId = resp.data.staffId;
                        this.employee.employeeName = resp.data.employeeName;
                        this.employee.age = resp.data.age;
                        this.employee.employmentStatus = resp.data.employmentStatus;
                        this.employee.email = resp.data.email;
                        this.employee.phone = resp.data.phone;
                        this.employee.deptId = resp.data.deptId;
                        this.employee.posId = resp.data.posId;
                    }
                )
            },
            updateById() {
                var _this = this;
                //提交表单数据,发送异步请求
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/employee/updateById",
                    data: _this.employee
                }).then(function (resp) {
                    //判断响应标识
                    if (resp.data == "success") {
                        //关闭窗口
                        _this.dialogVisible1 = false;

                        //重新加载页面
                        _this.selectOneById();

                        //成功提示框
                        _this.$message({
                            message: '恭喜你，编辑成功',
                            type: 'success'
                        });
                    }
                })
            },
            // 修改数据
            getupdate(id) {
                // this.employee.id = row.id;
                this.employee.staffId = row.staffId;
                this.employee.employeeName = row.employeeName;
                this.employee.age = row.age;
                this.employee.employmentStatus = row.employmentStatus;
                this.employee.email = row.email;
                this.employee.phone = row.phone;
                this.employee.deptId = row.deptId;
                this.employee.posId = row.posId;
            },
            // 点击侧边导航栏-->右侧动态变化
            handleSelect(index) {
                this.currentPage_ = index;
            },
            // 分页查询公告
            selectByPage_announcement() {
                axios({
                    method: "get",
                    url: "http://localhost:8080/hr-management-system/announcement/selectByPage?currentPage_announcement=" + this.currentPage_announcement + "&pageSize_announcement=" + this.pageSize_announcement,
                }).then(resp => {
                        // 设置表格数据
                        this.tableData_announcement = resp.data.rows; //{rows:[],totoalCount}
                        this.totalCount_announcement = resp.data.totalCount;
                    }
                )
            },
            //分页
            handleSizeChange_announcement(val) {
                //console.log(`每页 ${val} 条`);

                // 重新设置展示页数
                this.pageSize_announcement = val;

                // 重新查询 分页 数据
                this.selectByPage_announcement();

            }
            ,
            handleCurrentChange_announcement(val) {
                console.log(`当前页: ${val}`); //   当前页 : 8
                // val : currentPage

                // 重新设置当前页码
                this.currentPage_announcement = val;

                // 重新查询 分页 数据
                this.selectByPage_announcement();
            },
            // 根据条件分页查询
            selectMarkByPageAndId() {
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/train/selectMarkByPageAndId?currentPage_mark=" + this.currentPage_mark + "&pageSize_mark=" + this.pageSize_mark + "&id=" + this.employee.id,
                    // data: this.train
                }).then(resp => {
                        // 设置表格数据
                        this.tableData_mark = resp.data.rows; //{rows:[],totoalCount}
                        this.totalCount_mark = resp.data.totalCount;
                    }
                )
            },
            //分页
            handleSizeChange_mark(val) {
                //console.log(`每页 ${val} 条`);

                // 重新设置展示页数
                this.pageSize_mark = val;

                // 重新查询 分页 数据
                this.selectMarkByPageAndId();

            },
            handleCurrentChange_mark(val) {
                <%--console.log(`当前页: ${val}`); //   当前页 : 8--%>
                // val : currentPage

                // 重新设置当前页码
                this.currentPage_mark = val;

                // 重新查询 分页 数据
                this.selectMarkByPageAndId();
            },


            // 添加数据
            addByEmp() {
                var _this = this;
                //console.log(this.employee);
                //提交表单数据,发送异步请求
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/train/addByEmp?id=" + _this.employee.id,
                    data: _this.train
                }).then(function (resp) {
                    //判断响应标识
                    if (resp.data == "success") {

                        //关闭窗口
                        _this.dialogVisible3 = false;

                        /* //重新加载页面
                         _this.selectByPage();
 */
                        //成功提示框
                        _this.$message({
                            message: '恭喜你，添加成功',
                            type: 'success'
                        });

                    }

                })
            },

            // 添加数据
            vacateByEmp() {
                var _this = this;
                //console.log(this.employee);
                //提交表单数据,发送异步请求
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/vacate/addByEmp?id=" + _this.employee.id,
                    data: _this.vacate
                }).then(function (resp) {
                    //判断响应标识
                    if (resp.data == "success") {

                        //关闭窗口
                        _this.dialogVisible4 = false;

                        /* //重新加载页面
                         _this.selectByPage();
 */
                        //成功提示框
                        _this.$message({
                            message: '申请发送成功',
                            type: 'success'
                        });

                    } else if (resp.data == "date_error") {
                        //失败提示框
                        _this.$message({
                            message: '开始时间不得晚于结束时间',
                            type: 'error'
                        });
                    } else if (resp.data == "date_error1") {
                        //失败提示框
                        _this.$message({
                            message: '开始时间不得晚于现在时间',
                            type: 'error'
                        });
                    }

                })
            },
            // 添加数据
            send() {
                var _this = this;
                //console.log(this.employee);
                //提交表单数据,发送异步请求
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/messages/send?id=" + _this.employee.id,
                    data: _this.messages
                }).then(function (resp) {
                    //判断响应标识
                    if (resp.data == "success") {

                        //关闭窗口
                        _this.dialogVisible5 = false;

                        /* //重新加载页面
                         _this.selectByPage();
 */
                        //成功提示框
                        _this.$message({
                            message: '发送成功',
                            type: 'success'
                        });

                    }

                })
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
                    url: "http://localhost:8080/hr-management-system/rewardPunish/selectByPageAndCondition2?currentPage_rewardPunish=" + this.currentPage_rewardPunish + "&pageSize_rewardPunish=" + this.pageSize_rewardPunish + "&id=" + this.employee.id,
                    data: this.rewardPunish
                }).then(resp => {
                        // 设置表格数据
                        this.tableData_rewardPunish = resp.data.rows; //{rows:[],totoalCount}
                        // 设置总条数
                        this.totalCount_rewardPunish = resp.data.totalCount;
                    }
                )
            },

            goTime(val) {
                var timestamp4 = new Date(val);
                //利用拼接正则等手段转化为yyyy-MM-dd hh:mm:ss 格式
                return timestamp4.toLocaleDateString().replace(/\//g, "-") + " " + timestamp4.toTimeString().substr(0, 8);
            },
            // 分页查询
           /* selectSalary() {
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/salary/selectByPageAndCondition"
                }).then(resp => {
                        // 设置表格数据
                        this.tableData_salary = resp.data; //{rows:[],totoalCount}
                    }
                )
            }*/
            // 分页查询
            selectSalary() {
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/salary/selectByPageAndCondition2?currentPage_salary=" + this.currentPage_salary + "&pageSize_salary=" + this.pageSize_salary + "&employeeName=" + this.employee.employeeName,
                    data: this.salary
                }).then(resp => {
                        // 设置表格数据
                        this.tableData_salary = resp.data.rows;
                        this.totalCount_salary = resp.data.totalCount;
                    }
                )
            },
            //分页
            handleSizeChange_salary(val) {
                //console.log(`每页 ${val} 条`);

                // 重新设置展示页数
                this.pageSize_salary = val;

                // 重新查询 分页 数据
                this.selectSalary();

            },
            handleCurrentChange_salary(val) {
                console.log(`当前页: ${val}`); //   当前页 : 8
                // val : currentPage

                // 重新设置当前页码
                this.currentPage_salary = val;

                // 重新查询 分页 数据
                this.selectSalary();
            }
        }
    })

</script>


</body>
</html>