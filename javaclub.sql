create database `javaclub`;

use javaclub;

drop table if exists `member` ;
CREATE TABLE `member` (
	`id` int(50) NOT NULL AUTO_INCREMENT,
    `password` varchar(100),
    `username` varchar(100),
    `name` varchar(50) NOT NULL,
    `gender` varchar(4) COMMENT '性别  0-男 1-女',
    `birthday` datetime,
    `email` varchar(100),
    `major` varchar(50) COMMENT '所学专业',
    `enrollment` int COMMENT '入学年份',
    `entrytime` timestamp default CURRENT_TIMESTAMP COMMENT '加入时间',
    `census` text COMMENT '户籍所在地',
    `mobile` varchar(100),
    `othermobile` varchar(100) COMMENT '其他联系方式', 
    `deptid` bigint COMMENT '部门编号', 
    `remark` varchar(100) COMMENT '备注',
    `status` varchar(100) COMMENT '状态',
    `permission` varchar(4) default 0 COMMENT '管理权限  0-没有 1-有',
    PRIMARY KEY(`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='成员管理';
 
 
 insert into `member` 
 (`password`,`username`,`name`,`gender`,`birthday`,`email`,`major`,`enrollment`,`census`,`mobile`,`deptid`,`remark`,`status`,`permission`) 
VALUES
 ('java520','liangbin','梁彬','0','1996-12-18','lb19961218@163.com','CS','2015','ZJ','17806228320',2,'登录用账号','在读','1') ;
 
 select * from member;
 
 drop table if exists `dept`;
 CREATE TABLE `dept` (
	`id` bigint NOT NULL AUTO_INCREMENT,
    `name` varchar(50),
    `adminid` bigint COMMENT '部长编号',
    PRIMARY KEY(`id`)
 )ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门管理';
 
 