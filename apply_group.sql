/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : javaclub

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-10-30 12:35:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for apply_group
-- ----------------------------
DROP TABLE IF EXISTS `apply_group`;
CREATE TABLE `apply_group` (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '队伍id',
  `group_name` varchar(100) DEFAULT NULL COMMENT '队伍名',
  `project_id` int(3) DEFAULT '0',
  `status` int(1) DEFAULT '0' COMMENT '状态 0-正常 1退出',
  `praise_count` int(5) DEFAULT '0' COMMENT '被点赞数',
  `score` int(5) DEFAULT '0' COMMENT '队伍得分',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_group_name` (`group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='队伍表';
