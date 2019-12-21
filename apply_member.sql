/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : javaclub

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-10-30 12:35:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for apply_member
-- ----------------------------
DROP TABLE IF EXISTS `apply_member`;
CREATE TABLE `apply_member` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `username` varchar(12) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  `gender` int(1) DEFAULT NULL COMMENT '0-男 1女',
  `major` varchar(50) DEFAULT NULL COMMENT '专业',
  `enrollment` varchar(11) DEFAULT NULL COMMENT '入学年份',
  `entrytime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '报名时间',
  `mobile` varchar(20) CHARACTER SET utf8mb4 DEFAULT '',
  `status` int(1) DEFAULT '0' COMMENT '状态 0-正常 1-离队',
  `position` int(11) DEFAULT '0' COMMENT '职位 0-队员 1-队长',
  `groupid` int(5) DEFAULT NULL COMMENT '队伍id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='比赛队员表';
