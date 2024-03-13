SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dept
-- ----------------------------

DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept`
(
    `id`   int                                                           NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名称',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 10
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  ROW_FORMAT = DYNAMIC COMMENT ='部门';


-- ----------------------------
-- Records of dept
-- ----------------------------

INSERT INTO `dept`
VALUES (1, '行政部');
INSERT INTO `dept`
VALUES (2, '财务部');
INSERT INTO `dept`
VALUES (3, '质量管理部');
INSERT INTO `dept`
VALUES (4, '营销部');
INSERT INTO `dept`
VALUES (5, '营运部');
INSERT INTO `dept`
VALUES (6, '研发部');
INSERT INTO `dept`
VALUES (7, '运维部');
INSERT INTO `dept`
VALUES (8, '人事部');
INSERT INTO `dept`
VALUES (9, '客户服务部');

-- ----------------------------
-- Table structure for emp
-- ----------------------------

DROP TABLE IF EXISTS `emprp`;
CREATE TABLE `emprp`
(
    `id`       int NOT NULL AUTO_INCREMENT,
    `eid`      int                                                           DEFAULT NULL COMMENT '员工编号',
    `rpDate`   date                                                          DEFAULT NULL COMMENT '奖罚日期',
    `rpType`   int                                                           DEFAULT NULL COMMENT '奖罚类型',
    `rpReason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '奖罚原因',
    `rpPoint`  int                                                           DEFAULT NULL COMMENT '奖罚分(满分100)',
    `remark`   varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `eid` (`eid`) USING BTREE,
    CONSTRAINT `emprp_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `tb_employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  ROW_FORMAT = DYNAMIC COMMENT ='员工奖惩情况';

-- ----------------------------
-- Records of emprp
-- ----------------------------

INSERT INTO `emprp`
VALUES (1, 1, '2018-09-08', 0, '迟到', 95, '');
INSERT INTO `emprp`
VALUES (3, 2, '2019-07-06', 0, '早退', 95, '');
INSERT INTO `emprp`
VALUES (4, 7, '2024-02-15', 1, 'xxxxxxxxx', 100, '');

-- ----------------------------
-- Table structure for empsalary
-- ----------------------------

DROP TABLE IF EXISTS `empsalary`;
CREATE TABLE `empsalary`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `eid`         int DEFAULT NULL COMMENT '员工编号',
    `sal`         int DEFAULT NULL COMMENT '员工工资',
    `basicSalary` int DEFAULT NULL COMMENT '底薪',
    `performance` int DEFAULT NULL COMMENT '业绩',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `eid` (`eid`) USING BTREE,
    CONSTRAINT `empsalary_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `tb_employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  ROW_FORMAT = DYNAMIC COMMENT ='员工工资';

-- ----------------------------
-- Records of empsalary
-- ----------------------------

INSERT INTO `empsalary`
VALUES (1, 1, 7000, 2000, 6);
INSERT INTO `empsalary`
VALUES (2, 2, 8000, 2000, 6);
INSERT INTO `empsalary`
VALUES (3, 4, 8000, 2000, 6);

-- ----------------------------
-- Table structure for emptrain
-- ----------------------------

DROP TABLE IF EXISTS `emptrain`;
CREATE TABLE `emptrain`
(
    `id`           int NOT NULL AUTO_INCREMENT,
    `eid`          int                                                           DEFAULT NULL COMMENT '员工编号',
    `trainDate`    date                                                          DEFAULT NULL COMMENT '培训日期',
    `trainContent` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '培训内容',
    `remark`       varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `pid` (`eid`) USING BTREE,
    CONSTRAINT `employeetrain_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `tb_employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  ROW_FORMAT = DYNAMIC COMMENT ='员工培训';

-- ----------------------------
-- Records of emptrain
-- ----------------------------

INSERT INTO `emptrain`
VALUES (1, 1, '2024-02-21', 'xxxxx', '90');
INSERT INTO `emptrain`
VALUES (2, 4, '2024-02-27', 'xxxxxxx', '90');
INSERT INTO `emptrain`
VALUES (4, 8, '2024-01-12', 'xxxx', '');

-- ----------------------------
-- Table structure for messages
-- ----------------------------

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`
(
    `eid`     int          DEFAULT NULL,
    `message` varchar(255) DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='信息库';

-- ----------------------------
-- Records of messages
-- ----------------------------

INSERT INTO `messages`
VALUES (1, 'xxxxxxxxxx');
INSERT INTO `messages`
VALUES (2, 'xxxxxxxxxxxxxxxxxxxx');
INSERT INTO `messages`
VALUES (3, 'xxxxxxxxxxxxxxxxxxxxxxxxx');
INSERT INTO `messages`
VALUES (4, 'xxxxxxxxxxxxxxxxxxxxxxxxxxx');

-- ----------------------------
-- Table structure for tb_employee
-- ----------------------------

DROP TABLE IF EXISTS `tb_employee`;
CREATE TABLE `tb_employee`
(
    `id`                int                                                      NOT NULL AUTO_INCREMENT COMMENT '员工编号',
    `employee_name`     varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '员工姓名',
    `age`               int                                                          DEFAULT NULL COMMENT '年龄',
    `email`             varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '邮箱',
    `phone`             varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '电话号码',
    `dept_id`           int                                                      NOT NULL COMMENT '所属部门',
    `pos_id`            int                                                      NOT NULL COMMENT '职位ID',
    `employment_status` int                                                          DEFAULT NULL COMMENT '在职状态',
    `staff_id`          char(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工号',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `deptId` (`dept_id`) USING BTREE,
    KEY `workId` (`staff_id`) USING BTREE,
    CONSTRAINT `tb_employee_ibfk_2` FOREIGN KEY (`dept_id`) REFERENCES `dept` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  AUTO_INCREMENT = 21
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  ROW_FORMAT = DYNAMIC COMMENT ='员工';

-- ----------------------------
-- Records of tb_employee
-- ----------------------------

INSERT INTO `tb_employee`
VALUES (1, '张三', 35, 'zhangsan@163.com', '17452135841', 1, 1, 1, 'sdf4215');
INSERT INTO `tb_employee`
VALUES (2, '李四 ', 36, 'lisi@163.com', '13564721547', 1, 1, 1, 'sdf7425');
INSERT INTO `tb_employee`
VALUES (3, '张强 ', 28, 'zhangqiang@163.com', '14785426357', 3, 3, 1, 'sdf5437');
INSERT INTO `tb_employee`
VALUES (4, '李宇 ', 28, '', '17548963254', 3, 23, 1, 'sdf8452');
INSERT INTO `tb_employee`
VALUES (6, '王思达', 37, '', '17452136854', 5, 23, 1, 'sdf4217');
INSERT INTO `tb_employee`
VALUES (7, '赵芳 ', 29, '', '13542687942', 2, 3, 1, 'sdf7845');
INSERT INTO `tb_employee`
VALUES (8, '邹好 ', 26, '', '16542314785', 4, 12, 1, 'sdf7496');
INSERT INTO `tb_employee`
VALUES (9, '李韵 ', 34, '', '14523147852', 1, 1, 1, 'sdf5780');
INSERT INTO `tb_employee`
VALUES (10, '王桂芳', 39, '', '18452369785', 2, 3, 1, 'sdf3456');

-- ----------------------------
-- Table structure for trainannounce
-- ----------------------------

DROP TABLE IF EXISTS `trainannounce`;
CREATE TABLE `trainannounce`
(
    `id`     int NOT NULL AUTO_INCREMENT COMMENT '公告编号',
    `detail` varchar(255) DEFAULT NULL COMMENT '公告细节',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 8
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  ROW_FORMAT = DYNAMIC COMMENT ='培训公告';

-- ----------------------------
-- Records of trainannounce
-- ----------------------------

INSERT INTO `trainannounce`
VALUES (1, '2024年2月2日举行井冈山培训');
INSERT INTO `trainannounce`
VALUES (2, '2024年2月5日举行井冈山培训');
INSERT INTO `trainannounce`
VALUES (3, '2024年2月4日举行井冈山培训');

-- ----------------------------
-- Table structure for user
-- ----------------------------

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(
    `id`       int NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户名',
    `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '密码',
    `enabled`  int                                                           DEFAULT NULL COMMENT '状态：1启用、0禁用',
    `staffId`  varchar(255)                                                  DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  ROW_FORMAT = DYNAMIC COMMENT ='系统用户';

-- ----------------------------
-- Records of user
-- ----------------------------

INSERT INTO `user`
VALUES (1, 'admin', 'admin123', 1, 'admin');
INSERT INTO `user`
VALUES (2, 'zs', 'zs123456', 1, 'sdf4215');
INSERT INTO `user`
VALUES (3, 'ls', 'ls123456', 1, 'sdf7425');


-- ----------------------------
-- Table structure for userdetail
-- ----------------------------

DROP TABLE IF EXISTS `userdetail`;
CREATE TABLE `userdetail`
(
    `id`    int NOT NULL AUTO_INCREMENT,
    `phone` bigint DEFAULT NULL,
    `age`   int    DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of userdetail
-- ----------------------------

INSERT INTO `userdetail`
VALUES (1, 120, 15);
INSERT INTO `userdetail`
VALUES (2, 110, 16);
INSERT INTO `userdetail`
VALUES (3, 130, 17);

-- ----------------------------
-- Table structure for vacate
-- ----------------------------

DROP TABLE IF EXISTS `vacate`;

CREATE TABLE `vacate`
(
    `id`         int NOT NULL AUTO_INCREMENT,
    `eid`        int          DEFAULT NULL,
    `start_date` date         DEFAULT NULL,
    `end_date`   date         DEFAULT NULL,
    `type`       int          DEFAULT NULL,
    `remark`     varchar(255) DEFAULT NULL,
    `status`     int          DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `vacate_tb_employee_id_fk` (`eid`),
    CONSTRAINT `vacate_tb_employee_id_fk` FOREIGN KEY (`eid`) REFERENCES `tb_employee` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 17
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of vacate
-- ----------------------------

INSERT INTO `vacate`
VALUES (1, 1, '2024-02-27', '2024-02-28', 1, '病假', 0);
INSERT INTO `vacate`
VALUES (2, 2, '2024-02-27', '2024-02-28', 1, '', 0);
INSERT INTO `vacate`
VALUES (7, 4, '2024-02-28', '2024-02-28', 1, '', 1);


