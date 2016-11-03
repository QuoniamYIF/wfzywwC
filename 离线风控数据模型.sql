-- 风控事件规则参数属性定义表
DROP TABLE IF EXISTS `rsParamVarDef`;

CREATE TABLE `rsParamVarDef` (
  `paramId`       int not null auto_increment comment '参数标识码',
  `name`          varchar(30) collate utf8_unicode_ci default NULL COMMENT '参数变量名称',
  `chnName`       varchar(50) collate utf8_unicode_ci default NULL COMMENT '参数变量中文名称',
  `inputType`     int default  NULL COMMENT '输入类型',
  `multiSelFlg`   int default  NULL COMMENT '多选标识',
  `dataType`      int default  NULL COMMENT '数据类型',
  `required`      int default  NULL COMMENT '必输标识',
  `defaultValue`  varchar(200) collate utf8_unicode_ci default NULL COMMENT '缺省值',
  `readOnly`      int default NULL COMMENT '只读标识',
  `minValue`      int default NULL COMMENT '最小值(长度)',
  `maxValue`      int default NULL COMMENT '最大值(长度)',
  `selectContent` varchar(100) collate utf8_unicode_ci default NULL COMMENT '选择资源',
  `validFlg`      int default NULL COMMENT '生效标识',
  `crtOrgNo`      varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`        varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`       timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`      varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`        varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`       timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`paramId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='风控事件规则参数属性定义';

CREATE UNIQUE INDEX uidx_rsParamVarDef ON rsParamVarDef(`name`);


-- 注释
--  A、paramId,参数标识码，自动生成，主键唯一，属于技术键值
--  B、inputType,输入类型 0-文本 1-机构单选+文本 2-机构多选+文本 3-日期+文本 4-下拉列表单选+文本 5-下拉列表多选+文本
--  C、multiSelFlg,多选标识 0-单选 1-复选
--  D、dataType,数据类型 0-字符型 1-数字型
--  E、required,必输标识，0-不必输 1-必输
--  F、readOnly，只读标识 0-非只读 1-只读
--  G、minValue，最小值(长度)，如果是数字型，此值为最小值，如果是字符型，此值为最小长度
--  H、maxValue，最大值(长度)，如果是数字型，此值为最大值，如果是字符型，此值为最大值
--  I、selectContent，选择资源，以空值，json格式、url的获取资源的形式存在，主要是针对下来和树类型，json||[{"NAME":,"VALUE":"Q13Q132"},]或者URL||HTTP://ASDASDFASDF?'
--  J、validFlg，生效标识 0-失效 1-生效



-- 事件配置表
DROP TABLE IF EXISTS `evntCnfig`;

CREATE TABLE `evntCnfig` (
  `evntId`           int not null auto_increment comment '事件标识码',
  `evntNo`           varchar(30)   collate utf8_unicode_ci default NULL COMMENT '事件编号',
  `chnName`          varchar(50)   collate utf8_unicode_ci default NULL COMMENT '事件中文名称',
  `evntCatlog`       varchar(2)    collate utf8_unicode_ci default NULL COMMENT '事件大类',
  `evntType`         varchar(10)   collate utf8_unicode_ci default NULL COMMENT '事件类型',
  `evntCmpPeriod`    varchar(2)    collate utf8_unicode_ci default NULL COMMENT '事件计算周期',
  `evntDmType`       varchar(2)    collate utf8_unicode_ci default NULL COMMENT '事件维度类型',
  `evntFormulaDes`   varchar(255)  collate utf8_unicode_ci default NULL COMMENT '事件计算公式描述',
  `assembleSql`      text          collate utf8_unicode_ci default NULL COMMENT '聚合Sql',
  `traceSql`         text          collate utf8_unicode_ci default NULL COMMENT '溯源SQL',
  `validFlg`         int default NULL COMMENT '生效标识',
  `memoDes`          varchar(100) collate utf8_unicode_ci default NULL COMMENT '备注',
  `crtOrgNo`      varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`        varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`       timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`      varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`        varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`       timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`evntId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='事件配置';

CREATE UNIQUE INDEX uidx_evntCnfig ON evntCnfig(`evntNo`);


-- 注释
--  A、evntId ,事件标识码,自动生成，主键唯一，属于技术键值
--  B、evntNo,事件编号 格式： 事件大类+5位数序号，如：消费 + 00001。唯一
--  C、evntCatlog,事件大类 来自公共代码表,url，http://??COMMCODE=EVNTCATLOG
--  D、envtType,事件类型 00-登陆、01-注册、02-激活、03-提现、04-充值、05-密码修改、06-消费、07-绑卡、09-交易, 来自公共代码表,url，http://??COMMCODE=EVNTTYP
--  E、evntCmpPeriod,事件计算周期 00-按年 01-按月 02-按日 03-小时 04-秒
--  F、evntDmType，事件维度类型 00-按客户，01-按机构，02-按事件类型，03-按机构+客户，代码来源参照公共代码表
--  G、assembleSql，聚合SQL 聚合SQL支持多条语句处理，多个维度处理,最后插入语句可能会有grou by和having分组聚合后限定词， ，如count(*) >#{xingming}
--  H、traceSql，溯源Sql 追索聚合数据的溯源明细SQL，支持多条语句处理，此SQL的写法是，先计算聚合语句，然后参照聚合后结果，过滤溯源明细，放入溯源明细表中
--  J、validFlg，生效标识 0-失效 1-生效



-- 事件基本参数内容配置表
DROP TABLE IF EXISTS `evntParamContent`;

CREATE TABLE `evntParamContent` (
  `paramCntId`    int not null auto_increment comment '参数内容标识码',
  `evntId`        int not null COMMENT '事件标识码',
  `paramCntConf`  text   collate utf8_unicode_ci default NULL COMMENT '参数内容配置',
  `crtOrgNo`      varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`        varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`       timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`      varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`        varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`       timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`paramCntId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='事件基本参数内容配置';

CREATE UNIQUE INDEX uidx_evntParamContent ON evntParamContent(`evntId`);


-- 注释
--  A、 paramCntId ,参数内容标识码,自动生成，主键唯一，属于技术键值
--  B、evntId,事件标识码 唯一
--  C、paramCntConf,参数内容配置 Json格式：{“属性参数变量名称1”:”3”,”属性参数变量名称2”:”XXXX”, “属性参数变量名称3”:”chmvar” ,…….}

-- 事件动态变量配置表
DROP TABLE IF EXISTS `evntDynVarConf`;

CREATE TABLE `evntDynVarConf` (
  `dynVarId`      int not null auto_increment comment '动态变量标识码',
  `evntId`        int not null COMMENT '事件标识码',
  `name`          varchar(30) collate utf8_unicode_ci default NULL COMMENT '动态变量名称',
  `chnName`       varchar(50) collate utf8_unicode_ci default NULL COMMENT '动态变量中文名称',
  `seqNo`         int not null COMMENT '序号',
  `inputType`     int default  NULL COMMENT '输入类型',
  `multiSelFlg`   int default  NULL COMMENT '多选标识',
  `dataType`      int default  NULL COMMENT '数据类型',
  `required`      int default  NULL COMMENT '必输标识',
  `defaultValue`  varchar(200) collate utf8_unicode_ci default NULL COMMENT '缺省值',
  `readOnly`      int default NULL COMMENT '只读标识',
  `minValue`      int default NULL COMMENT '最小值(长度)',
  `maxValue`      int default NULL COMMENT '最大值(长度)',
  `selectContent` varchar(100) collate utf8_unicode_ci default NULL COMMENT '选择资源',
  `validFlg`      int default NULL COMMENT '生效标识',
  `crtOrgNo`      varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`        varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`       timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`      varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`        varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`       timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`dynVarId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='事件动态变量配置';

CREATE UNIQUE INDEX uidx_evntDynVarConf ON evntDynVarConf(`evntId`,`name`,`seqNo`);


-- 注释
--  A、dynVarId,参数标识码，自动生成，主键唯一，属于技术键值
--  B、evntId，事件标识ID+动态变量名称+序号，唯一，业务主键
--  C、seqNo，序号，标识动态变量的界面顺序，可以不连续
--  D、inputType,输入类型 0-文本 1-机构单选+文本 2-机构多选+文本 3-日期+文本 4-下拉列表单选+文本 5-下拉列表多选+文本
--  E、multiSelFlg,多选标识 0-单选 1-复选
--  F、dataType,数据类型 0-字符型 1-数字型
--  G、required,必输标识，0-不必输 1-必输
--  H、readOnly，只读标识 0-非只读 1-只读
--  I、minValue，最小值(长度)，如果是数字型，此值为最小值，如果是字符型，此值为最小长度
--  J、maxValue，最大值(长度)，如果是数字型，此值为最大值，如果是字符型，此值为最大值
--  K、selectContent，选择资源，以空值，json格式、url的获取资源的形式存在，主要是针对下来和树类型，json||[{"NAME":,"VALUE":"Q13Q132"},]或者URL||HTTP://ASDASDFASDF?'
--  L、validFlg，生效标识 0-失效 1-生效


-- 事件计算结果表
DROP TABLE IF EXISTS `evntCmpRst`;

CREATE TABLE `evntCmpRst` (
  `evntRstId`     int not null  auto_increment comment '结果标识码',
  `cmpDte`        varchar(8)    collate utf8_unicode_ci default NULL COMMENT '计算日期',
  `evntId`        int           not null COMMENT '事件标识码',
  `cmpBatNo`      varchar(10)   collate utf8_unicode_ci default NULL COMMENT '计算批次号',
  `rstBelongTo`   varchar(100)  collate utf8_unicode_ci default NULL COMMENT '结果归属物',
  `cmpValue`      decimal(18,5) default 0.00 COMMENT '事件计算量值',
  `memoDes`       varchar(100)  collate utf8_unicode_ci default NULL COMMENT '备注',
  `crtOrgNo`      varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`        varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`       timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`      varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`        varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`       timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`evntRstId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='事件计算结果';

CREATE UNIQUE INDEX uidx_evntCmpRst ON evntCmpRst(`cmpDte`,`evntId`,`cmpBatNo`,`rstBelongTo`);


-- 注释
--  A、evntRstId,结果标识码，自动生成，主键唯一，属于技术键值
--  B、evntId，事件标识码,参考引用事件配置表
--  C、cmpDte，计算日期，非空,YYYYMMDD，由计算日期+事件标识id +批次号+结果归属物，形成唯一的业务主键
--  D、cmpBatNo,计算批次号，默认为0，按日为单位清0
--  E、rstBelongTo,结果归属物 各维度组合用#分隔，非空

-- 事件计算结果语句表
DROP TABLE IF EXISTS `evntCmpRstSql`;

CREATE TABLE `evntCmpRstSql` (
  `evntRstSqlId`  int not null  auto_increment comment '结果语句标识码',
  `cmpDte`        varchar(8)    collate utf8_unicode_ci default NULL COMMENT '计算日期',
  `evntId`        int           not null COMMENT '事件标识码',
  `cmpBatNo`      varchar(10)   collate utf8_unicode_ci default NULL COMMENT '计算批次号',
  `assembleSql`   text          collate utf8_unicode_ci default NULL COMMENT '聚合Sql',
  `paramCntConf`  text          collate utf8_unicode_ci default NULL COMMENT '参数内容配置',
  `dynVarCntConf` text          collate utf8_unicode_ci default NULL COMMENT '动态变量内容配置',
  `memoDes`       varchar(100)  collate utf8_unicode_ci default NULL COMMENT '备注',
  `crtOrgNo`      varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`        varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`       timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`      varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`        varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`       timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`evntRstSqlId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='事件计算结果语句';

CREATE UNIQUE INDEX uidx_evntCmpRstSql ON evntCmpRstSql(`cmpDte`,`evntId`,`cmpBatNo`);


-- 注释
--  A、evntRstSqlId,结果语句标识码，自动生成，主键唯一，属于技术键值
--  B、evntId，事件标识码,参考引用事件配置表
--  C、cmpDte，计算日期，非空,YYYYMMDD，由计算日期+事件标识id +批次号，形成唯一的业务主键
--  D、cmpBatNo,计算批次号，默认为0，按日为单位清0
--  E、assembleSql，聚合SQL 聚合SQL支持多条语句处理，多个维度处理,最后插入语句可能会有grou by和having分组聚合后限定词， ，如count(*) >#{xingming}
--  F、paramCntConf，参数内容配置 Json格式：{“属性参数变量名称1”:”3”,”属性参数变量名称2”:”XXXX”, “属性参数变量名称3”:”chmvar” ,…….}
--  G、dynVarCntConf 动态变量内容配置 Json格式：{“动态变量名称1”:”3”,”动态变量名称2”:”XXXX”, “动态变量名称3”:”chmvar” ,…….}


-- 事件计算结果溯源明细表
DROP TABLE IF EXISTS `evntCmpRstTrace`;

CREATE TABLE `evntCmpRstTrace` (
  `evntRstTraceId`   int not null  auto_increment comment '明细结果标识码',
  `cmpDte`           varchar(8)    collate utf8_unicode_ci default NULL COMMENT '计算日期',
  `evntId`           int           not null COMMENT '事件标识码',
  `cmpBatNo`         varchar(10)   collate utf8_unicode_ci default NULL COMMENT '计算批次号',
  `busiKeyValue`     varchar(100)  collate utf8_unicode_ci default NULL COMMENT '业务键值码',
  `cmpValue`         decimal(18,5) default 0.00 COMMENT '事件计算量值',
  `memoDes`          varchar(100)  collate utf8_unicode_ci default NULL COMMENT '备注',
  `crtOrgNo`         varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`           varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`          timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`         varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`           varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`          timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`evntRstTraceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='事件计算结果溯源明细';

CREATE UNIQUE INDEX uidx_evntCmpRstTrace ON evntCmpRstTrace(`cmpDte`,`evntId`,`cmpBatNo`,`busiKeyValue`);


-- 注释
--  A、evntRstTraceId,明细结果标识码，自动生成，主键唯一，属于技术键值
--  B、evntId，事件标识码,参考引用事件配置表
--  C、cmpDte，计算日期，非空,YYYYMMDD，由计算日期+事件标识id +计算批次号+业务键值码，形成唯一的业务主键
--  D、cmpBatNo,计算批次号，默认为0，按日为单位清0
--  E、busiKeyValue,业务键值码 计算数据明细键值组合，如卡/账号/机构号/商户号/客户号+交易日期

-- 事件计算结果溯源明细语句表
DROP TABLE IF EXISTS `evntCmpRstTrcSql`;

CREATE TABLE `evntCmpRstTrcSql` (
  `evntRstTrcSqlId`  int not null  auto_increment comment '明细语句结果标识码',
  `cmpDte`           varchar(8)    collate utf8_unicode_ci default NULL COMMENT '计算日期',
  `evntId`           int           not null COMMENT '事件标识码',
  `cmpBatNo`         varchar(10)   collate utf8_unicode_ci default NULL COMMENT '计算批次号',
  `traceSql`         text          collate utf8_unicode_ci default NULL COMMENT '溯源SQL',
  `paramCntConf`     text          collate utf8_unicode_ci default NULL COMMENT '参数内容配置',
  `dynVarCntConf`    text          collate utf8_unicode_ci default NULL COMMENT '动态变量内容配置',
  `memoDes`          varchar(100)  collate utf8_unicode_ci default NULL COMMENT '备注',
  `crtOrgNo`         varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`           varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`          timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`         varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`           varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`          timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`evntRstTrcSqlId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='事件计算结果溯源明细语句';

CREATE UNIQUE INDEX uidx_evntCmpRstTrcSql ON evntCmpRstTrcSql(`cmpDte`,`evntId`,`cmpBatNo`);


-- 注释
--  A、evntRstTrcSqlId,明细语句结果标识码，自动生成，主键唯一，属于技术键值
--  B、evntId，事件标识码,参考引用事件配置表
--  C、cmpDte，计算日期，非空,YYYYMMDD，由计算日期+事件标识id +批次号，形成唯一的业务主键
--  D、cmpBatNo,计算批次号，默认为0，按日为单位清0
--  E、assembleSql，聚合SQL 聚合SQL支持多条语句处理，多个维度处理,最后插入语句可能会有grou by和having分组聚合后限定词， ，如count(*) >#{xingming}
--  F、paramCntConf，参数内容配置 Json格式：{“属性参数变量名称1”:”3”,”属性参数变量名称2”:”XXXX”, “属性参数变量名称3”:”chmvar” ,…….}
--  G、traceSql，溯源Sql 追索聚合数据的溯源明细SQL，支持多条语句处理，此SQL的写法是，先计算聚合语句，然后参照聚合后结果，过滤溯源明细，放入溯源明细表中

-- 规则配置表
DROP TABLE IF EXISTS `ruleCnfig`;

CREATE TABLE `ruleCnfig` (
  `ruleId`           int not null auto_increment comment '规则标识码',
  `ruleSetId`        int default  NULL COMMENT '规则集标识码',
  `ruleNo`           varchar(30)   collate utf8_unicode_ci default NULL COMMENT '规则编号',
  `chnName`          varchar(100)   collate utf8_unicode_ci default NULL COMMENT '规则中文名称',
  `ruleBelongType`   varchar(2)    collate utf8_unicode_ci default NULL COMMENT '规则归属类型',
  `ruleCatlog`       varchar(2)    collate utf8_unicode_ci default NULL COMMENT '规则服务大类',
  `evntFormulaDes`   varchar(255)  collate utf8_unicode_ci default NULL COMMENT '规则公式描述',
  `ruleCmpPeriod`    varchar(2)    collate utf8_unicode_ci default NULL COMMENT '事件计算周期',
  `evntType`         varchar(10)   collate utf8_unicode_ci default NULL COMMENT '事件类型',
  `defaultSts`       varchar(2)    collate utf8_unicode_ci default NULL COMMENT '默认状态值',
  `validFlg`         int default NULL COMMENT '生效标识',
  `allowUpRptFlg`    varchar(2)    collate utf8_unicode_ci default NULL default NULL COMMENT '可上报标志',
  `validDte`         varchar(8)    collate utf8_unicode_ci default NULL COMMENT '生效日期',
  `cancelDte`        varchar(8)    collate utf8_unicode_ci default NULL COMMENT '失效日期',
  `ruleCmpSql`       text          collate utf8_unicode_ci default NULL COMMENT '规则计算SQL',
  `traceSql`         text          collate utf8_unicode_ci default NULL COMMENT '规则溯源SQL',
  `memoDes`          varchar(100) collate utf8_unicode_ci default NULL COMMENT '备注',
  `crtOrgNo`         varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`           varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`          timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`         varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`           varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`          timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`ruleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='事件配置';

CREATE UNIQUE INDEX uidx_ruleCnfig ON ruleCnfig(`ruleNo`,`validDte`);


-- 注释
--  A、ruleId ,规则标识码,自动生成，主键唯一，属于技术键值
--  B、ruleSetId，规则集标识码，来自规则集模型信息，暂是未设计时，默认全部为1
--  C、ruleNo,规则编号 与“生效日期”组合业务键值唯一索引
--  D、ruleBelongType，规则归属类型 ，00-用户,01-商户，来自公共代码,url，http://??COMMCODE=RULEBELONGTYPE
--  E、ruleCatlog,规则服务大类 00-欺诈、01-稳定性、02-黑名单、… 来自公共代码表,url，http://??COMMCODE=ruleCatlog
--  F、envtType,事件类型 00-登陆、01-注册、02-激活、03-提现、04-充值、05-密码修改、06-消费、07-绑卡、09-交易, 来自公共代码表,url，http://??COMMCODE=EVNTTYP
--  G、ruleCmpPeriod,事件计算周期 00-按年 01-按月 02-按日 03-小时 04-秒
--  H、defaultSts，默认状态值 00 未处理,01 可疑,02跟进中,03异常,04正常,05 关注 目前有：现异常和可疑，其它暂没用
--  I、validFlg，生效标识 0-失效 1-生效
--  J、allowUpRptFlg，可上报标志，00=不可上报,01=可上报，可不可以上报是业务人员人工决定的
--  K、ruleCmpSql，规则计算SQL支持多条语句处理，涉及到多个事件情况下，利用事件计算结果表多次拼接，按规则公式过滤数据。
--  L、traceSql，溯源Sql 追索规则计算结果的溯源明细SQL，支持多条语句处理，此SQL的写法是，先计算规则计算SQL，然后参照规则后结果，过滤溯源明细，放入溯源明细表中


-- 规则基本参数内容配置表
DROP TABLE IF EXISTS `ruleParamContent`;

CREATE TABLE `ruleParamContent` (
  `paramCntId`    int not null auto_increment comment '参数内容标识码',
  `ruleId`        int not null COMMENT '规则标识码',
  `paramCntConf`  text   collate utf8_unicode_ci default NULL COMMENT '参数内容配置',
  `crtOrgNo`      varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`        varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`       timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`      varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`        varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`       timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`paramCntId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='规则基本参数内容配置';

CREATE UNIQUE INDEX uidx_ruleParamContent ON ruleParamContent(`ruleId`);

-- 注释
--  A、 paramCntId ,参数内容标识码,自动生成，主键唯一，属于技术键值
--  B、ruleId,规则标识码 唯一 业务主键
--  C、paramCntConf,参数内容配置 Json格式：{“属性参数变量名称1”:”3”,”属性参数变量名称2”:”XXXX”, “属性参数变量名称3”:”chmvar” ,…….}


-- 规则动态变量配置表
DROP TABLE IF EXISTS `evntDynVarConf`;

CREATE TABLE `evntDynVarConf` (
  `dynVarId`      int not null auto_increment comment '动态变量标识码',
  `ruleId`        int not null COMMENT '规则标识码',
  `name`          varchar(30) collate utf8_unicode_ci default NULL COMMENT '动态变量名称',
  `chnName`       varchar(50) collate utf8_unicode_ci default NULL COMMENT '动态变量中文名称',
  `seqNo`         int not null COMMENT '序号',
  `inputType`     int default  NULL COMMENT '输入类型',
  `multiSelFlg`   int default  NULL COMMENT '多选标识',
  `dataType`      int default  NULL COMMENT '数据类型',
  `required`      int default  NULL COMMENT '必输标识',
  `defaultValue`  varchar(200) collate utf8_unicode_ci default NULL COMMENT '缺省值',
  `readOnly`      int default NULL COMMENT '只读标识',
  `minValue`      int default NULL COMMENT '最小值(长度)',
  `maxValue`      int default NULL COMMENT '最大值(长度)',
  `selectContent` varchar(100) collate utf8_unicode_ci default NULL COMMENT '选择资源',
  `validFlg`      int default NULL COMMENT '生效标识',
  `crtOrgNo`      varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`        varchar(30) collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`       timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`      varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`        varchar(30) collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`       timestamp NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`dynVarId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='规则动态变量配置';

CREATE UNIQUE INDEX uidx_evntDynVarConf ON evntDynVarConf(`ruleId`,`name`,`seqNo`);

-- 注释
--  A、dynVarId,参数标识码，自动生成，主键唯一，属于技术键值
--  B、ruleId，规则标识ID+动态变量名称+序号，唯一，业务主键
--  C、seqNo，序号，标识动态变量的界面顺序，可以不连续
--  D、inputType,输入类型 0-文本 1-机构单选+文本 2-机构多选+文本 3-日期+文本 4-下拉列表单选+文本 5-下拉列表多选+文本
--  E、multiSelFlg,多选标识 0-单选 1-复选
--  F、dataType,数据类型 0-字符型 1-数字型
--  G、required,必输标识，0-不必输 1-必输
--  H、readOnly，只读标识 0-非只读 1-只读
--  I、minValue，最小值(长度)，如果是数字型，此值为最小值，如果是字符型，此值为最小长度
--  J、maxValue，最大值(长度)，如果是数字型，此值为最大值，如果是字符型，此值为最大值
--  K、selectContent，选择资源，以空值，json格式、url的获取资源的形式存在，主要是针对下来和树类型，json||[{"NAME":,"VALUE":"Q13Q132"},]或者URL||HTTP://ASDASDFASDF?'
--  L、validFlg，生效标识 0-失效 1-生效





-- 规则计算结果表
DROP TABLE IF EXISTS `ruleCmpRst`;

CREATE TABLE `ruleCmpRst` (
  `ruleRstId`        int not null  auto_increment comment '结果标识码',
  `cmpDte`           varchar(8)    collate utf8_unicode_ci default NULL COMMENT '计算日期',
  `ruleSetId`        int default  NULL COMMENT '规则集标识码',
  `ruleId`           int not null  comment '规则标识码',
  `cmpBatNo`         varchar(10)   collate utf8_unicode_ci default NULL COMMENT '计算批次号',
  `ruleBelongType`   varchar(2)    collate utf8_unicode_ci default NULL COMMENT '规则归属类型',
  `rstSts`           varchar(2)    collate utf8_unicode_ci default NULL COMMENT '默认状态值',
  `rstBelongTo`      varchar(30)  collate utf8_unicode_ci default NULL COMMENT '结果归属物',
  `evntCount`        int           default NULL COMMENT '事件总数',
  `evntSumAmt`       decimal(18,5)  collate utf8_unicode_ci default NULL COMMENT '事件总金额',
  `upRptFlg`         varchar(2)    collate utf8_unicode_ci default NULL default NULL COMMENT '可上报标志',
  `evntCountSet`     varchar(255)  collate utf8_unicode_ci default NULL COMMENT '事件总数结果组合',
  `evntSumAmtSet`    varchar(255)  collate utf8_unicode_ci default NULL COMMENT '事件金额组合',
  `memoDes`          varchar(100)  collate utf8_unicode_ci default NULL COMMENT '备注',
  `crtOrgNo`         varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`           varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`          timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`         varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`           varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`          timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`ruleRstId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='规则计算结果';

CREATE UNIQUE INDEX uidx_ruleCmpRst ON ruleCmpRst(`cmpDte`,`ruleSetId`,`ruleId`,`cmpBatNo`,`ruleBelongType`,`rstBelongTo`);


-- 注释
--  A、ruleRstId,结果标识码，自动生成，主键唯一，属于技术键值
--  B、ruleId，规则标识码,参考引用规则配置表
--  C、cmpDte，计算日期，非空,YYYYMMDD，计算日期+规则集标识ID+规则标识id +规则计算批次号+归属对象类型+结果归属物，形成唯一业务主键
--  D、cmpBatNo,计算批次号，默认为0，按日为单位清0
--  E、ruleBelongType，规则归属类型 ，00-用户,01-商户，来自公共代码,url，http://??COMMCODE=RULEBELONGTYPE
--  F、rstSts，状态值 可前台修改 00 未处理,01 可疑,02跟进中,03异常,04正常,05 关注 目前有：现异常和可疑，其它暂没用
--  G、rstBelongTo,结果归属物 如归属对象类型是用戶，则为客户号；是商户号，则为商户号；是卡，则为卡号，是渠道，则为渠道号，等等
--  H、upRptFlg，上报标志，00=未确定,01=需上报,02=已上报
--  I、evntCountSet 事件总数结果组合 如登陆次数:33,密码修改次数:45,支付次数:6
--  J、evntSumAmtSet 事件金额组合 支付金额:600



-- 规则计算结果语句表
DROP TABLE IF EXISTS `ruleCmpRstSql`;

CREATE TABLE `ruleCmpRstSql` (
  `ruleRstSqlId`  int not null  auto_increment comment '结果语句标识码',
  `cmpDte`        varchar(8)    collate utf8_unicode_ci default NULL COMMENT '计算日期',
  `ruleSetId`        int default  NULL COMMENT '规则集标识码',
  `ruleId`           int not null  comment '规则标识码',
  `cmpBatNo`         varchar(10)   collate utf8_unicode_ci default NULL COMMENT '计算批次号',
  `ruleCmpSql`       text          collate utf8_unicode_ci default NULL COMMENT '规则计算SQL',
  `paramCntConf`  text          collate utf8_unicode_ci default NULL COMMENT '参数内容配置',
  `dynVarCntConf` text          collate utf8_unicode_ci default NULL COMMENT '动态变量内容配置',
  `memoDes`       varchar(100)  collate utf8_unicode_ci default NULL COMMENT '备注',
  `crtOrgNo`      varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`        varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`       timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`      varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`        varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`       timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`ruleRstSqlId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='事件计算结果语句';

CREATE UNIQUE INDEX uidx_ruleCmpRstSql ON ruleCmpRstSql(`cmpDte`,`ruleSetId`,`ruleId`,`cmpBatNo`);


-- 注释
--  A、evntRstSqlId,结果语句标识码，自动生成，主键唯一，属于技术键值
--  B、ruleId，规则标识码,参考引用规则配置表
--  C、cmpDte，计算日期，非空,YYYYMMDD，计算日期+规则集标识ID+规则标识id+规则计算批次号，形成业务主键唯一
--  D、cmpBatNo,计算批次号，默认为0，按日为单位清0
--  E、ruleCmpSql，规则计算SQL支持多条语句处理，涉及到多个事件情况下，利用事件计算结果表多次拼接，按规则公式过滤数据。
--  F、paramCntConf，参数内容配置 Json格式：{“属性参数变量名称1”:”3”,”属性参数变量名称2”:”XXXX”, “属性参数变量名称3”:”chmvar” ,…….}
--  G、dynVarCntConf 动态变量内容配置 Json格式：{“动态变量名称1”:”3”,”动态变量名称2”:”XXXX”, “动态变量名称3”:”chmvar” ,…….}



-- 规则计算结果明细表
DROP TABLE IF EXISTS `ruleCmpRstTrace`;

CREATE TABLE `ruleCmpRstTrace` (
  `ruleRstTraceId`   int not null  auto_increment comment '明细结果标识码',
  `cmpDte`           varchar(8)    collate utf8_unicode_ci default NULL COMMENT '计算日期',
  `ruleRstId`        int not null comment '结果标识码',
  `evntType`         varchar(10)   collate utf8_unicode_ci default NULL COMMENT '事件类型',
  `rstTraceSet`      text          collate utf8_unicode_ci default NULL COMMENT '结果明细组合',
  `memoDes`          varchar(100)  collate utf8_unicode_ci default NULL COMMENT '备注',
  `crtOrgNo`         varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`           varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`          timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`         varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`           varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`          timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`ruleRstTraceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='规则计算结果明细';

CREATE UNIQUE INDEX uidx_ruleCmpRstTrace ON ruleCmpRstTrace(`ruleRstId`);


-- 注释
--  A、ruleRstTraceId,明细结果标识码，自动生成，主键唯一，属于技术键值
--  B、ruleRstId 规则结果标识码 非空，业务唯一主键
--  C、envtType,事件类型 00-登陆、01-注册、02-激活、03-提现、04-充值、05-密码修改、06-消费、07-绑卡、09-交易, 来自公共代码表,url，http://??COMMCODE=EVNTTYP
--  D、cmpDte，计算日期，非空,YYYYMMDD
--  E、rstTraceSet,结果明细组合，用json格式，[{"事件ID":"AAAA","事件名称":"登陆次数","发生次数(金额)":"4"},{"事件ID":"BBBB","事件名称":"密码修改次数","发生次数(金额)":"8"}]


-- 规则计算结果明细语句表
DROP TABLE IF EXISTS `ruleCmpRstTrcSql`;

CREATE TABLE `ruleCmpRstTrcSql` (
  `ruleRstTrcSqlId`  int not null  auto_increment comment '明细语句结果标识码',
  `cmpDte`           varchar(8)    collate utf8_unicode_ci default NULL COMMENT '计算日期',
  `ruleRstId`        int not null comment '结果标识码',
  `traceSql`         text          collate utf8_unicode_ci default NULL COMMENT '溯源SQL',
  `paramCntConf`     text          collate utf8_unicode_ci default NULL COMMENT '参数内容配置',
  `dynVarCntConf`    text          collate utf8_unicode_ci default NULL COMMENT '动态变量内容配置',
  `memoDes`          varchar(100)  collate utf8_unicode_ci default NULL COMMENT '备注',
  `crtOrgNo`         varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建组织',
  `crtUsr`           varchar(30)   collate utf8_unicode_ci default NULL COMMENT '创建用戶',
  `crtTime`          timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updOrgNo`         varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改组织',
  `updUsr`           varchar(30)   collate utf8_unicode_ci default NULL COMMENT '修改用戶',
  `updTime`          timestamp     NOT NULL default CURRENT_TIMESTAMP  COMMENT '修改时间',
  PRIMARY KEY  (`ruleRstTrcSqlId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='规则计算结果明细语句';

CREATE UNIQUE INDEX uidx_ruleCmpRstTrcSql ON ruleCmpRstTrcSql(`ruleRstId`);


-- 注释
--  A、ruleRstTrcSqlId,明细语句结果标识码，自动生成，主键唯一，属于技术键值
--  B、ruleRstId 规则结果标识码 非空，业务唯一主键
--  C、cmpDte，计算日期，非空,YYYYMMDD
--  D、cmpBatNo,计算批次号，默认为0，按日为单位清0
--  E、traceSql，规则溯源SQL 追索规则计算结果的溯源明细SQL，支持多条语句处理，此SQL的写法是，先计算规则计算SQL，然后参照规则后结果，过滤溯源明细，放入溯源明细表中
--  F、paramCntConf，参数内容配置 Json格式：{“属性参数变量名称1”:”3”,”属性参数变量名称2”:”XXXX”, “属性参数变量名称3”:”chmvar” ,…….}
--  G、dynVarCntConf，动态变量内容配置 Json格式：{“动态变量名称1”:”3”,”动态变量名称2”:”XXXX”, “动态变量名称3”:”chmvar” ,…….}
