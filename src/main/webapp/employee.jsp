<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2024/2/29
  Time: 18:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
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
</head>
<body>
<div id="app">

    <el-container style="height: 500px; border: 1px solid #eee">
        <el-header style="text-align: right; font-size: 12px">

            <el-dropdown>
                <i class="el-icon-user" style="margin-right: 15px"></i>
                <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item>查看</el-dropdown-item>
                    <el-dropdown-item>新增</el-dropdown-item>
                    <el-dropdown-item>删除</el-dropdown-item>
                </el-dropdown-menu>
            </el-dropdown>
        </el-header>

        <el-container>
            <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
                <el-menu :default-openeds="['1', '3']"  @select="handleSelect">
                    <el-menu-item index="home">首页</el-menu-item>
                    <el-submenu index="2">
                        <template slot="title"><i class="el-icon-message"></i>培训</template>
                        <el-menu-item index="announcement" @click="selectByPage_announcement">培训公告</el-menu-item>
                        <el-menu-item index="1-2">参与培训</el-menu-item>
                        <el-menu-item index="1-3">个人培训计划与成绩</el-menu-item>
                    </el-submenu>
                    <el-submenu index="3">
                        <template slot="title"><i class="el-icon-setting"></i>导航三</template>
                        <el-menu-item-group>
                            <template slot="title">分组一</template>
                            <el-menu-item index="3-1">选项1</el-menu-item>
                            <el-menu-item index="3-2">选项2</el-menu-item>
                        </el-menu-item-group>
                        <el-menu-item-group title="分组2">
                            <el-menu-item index="3-3">选项3</el-menu-item>
                        </el-menu-item-group>
                        <el-submenu index="3-4">
                            <template slot="title">选项4</template>
                            <el-menu-item index="3-4-1">选项4-1</el-menu-item>
                        </el-submenu>
                    </el-submenu>
                </el-menu>
            </el-aside>

            <el-container>

                <div  v-show="currentPage_ === 'home'">
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

                    <el-divider></el-divider>

                    <el-footer height="500px">
                        <el-card class="box-card">
                            <!-- <div slot="header" class="clearfix">
                                 <span>卡片名称</span>
                                 <el-button style="float: right; padding: 3px 0" type="text">操作按钮</el-button>
                             </div>
                             <div v-for="o in 4" :key="o" class="text item">
                                 {{'列表内容 ' + o }}
                             </div>
                             -->
                            <!--更新版-->
                            <div slot="header">

                                <el-form :model="form">
                                    <el-form-item label="路径" prop="url">
                                        <el-upload
                                                class="avatar-uploader"
                                                action=""
                                                :http-request="field101BeforeUpload"
                                                :show-file-list="false"
                                        >
                                            <img v-if="imageUrl" :src="imageUrl" class="avatar"/>
                                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                                        </el-upload>
                                    </el-form-item>
                                </el-form>


                            </div>
                            <div class="clearfix">
                                <h7>
                                    <span>全名</span>
                                </h7>
                                <el-button style="float: right; padding: 3px 0" type="text">编辑名称</el-button>
                            </div>

                        </el-card>
                    </el-footer>

                </div>
                <div  v-show="currentPage_ === 'announcement'">
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
                currentPage_ : 'home',
                // 当前页码
                currentPage_announcement:'1',
                // 页面展示数
                pageSize_announcement:'5',
                // 总条数
                totalCount_announcement:'100',
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
                tableData_announcement:[{
                    id:'1',
                    detail:"2024-2-21日井冈山培训"
                },{
                    id:'2',
                    detail:"2024-2-21日井冈山培训"
                },{
                    id:'3',
                    detail:"2024-2-21日井冈山培训"
                },{
                    id:'4',
                    detail:"2024-2-21日井冈山培训"
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
            selectOneById() {
                axios({
                    method: "post",
                    url: "http://localhost:8080/hr-management-system/employee/selectOneById?id=1"// 暂时写死
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
            selectByPage_announcement(){
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
            }
        }
    })

</script>


</body>
</html>