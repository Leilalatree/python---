CREATE TABLE T01_Customer
(
Cust_Id			VARCHAR(30) PRIMARY KEY NOT NULL,
Open_Org_Id		VARCHAR(4) NOT NULL,
Open_Teller_Id	VARCHAR(10) NOT NULL,
Open_Dt			VARCHAR(8) NOT NULL,
Close_Org_Id	VARCHAR(4) NOT NULL,
Close_Teller_Id	VARCHAR(10)  NOT NULL,
Close_Dt	VARCHAR(8) NOT NULL,
)
;
ALTER TABLE T01_Customer ALTER COLUMN Open_Dt VARCHAR(12) NOT NULL
ALTER TABLE T01_Customer ALTER COLUMN Close_Dt VARCHAR(12) NOT NULL

SELECT * FROM T01_Customer
;

CREATE TABLE T01_Deposit_Acct
(
Deposit_Acct_No      CHAR(30) PRIMARY KEY NOT NULL,
Currency_Cd		     CHAR(3) NOT NULL,
Acct_Type_Cd	     CHAR(4) NOT NULL,
Cust_Id 		     CHAR(30) NOT NULL,
Belong_Acct_Org_Id	 CHAR(4) NOT NULL,
Biz_Cd				 CHAR(21) NOT NULL,
Subject_Cd 			 CHAR(6) NOT NULL,
Open_Dt				 VARCHAR(8) NOT NULL,
Open_Org_Id 		 CHAR(4) NOT NULL,
Close_Dt		     VARCHAR(8) NOT NULL,
Close_Org_Id		 CHAR(4) NOT NULL,
Close_Teller_Id      CHAR(8) NOT NULL,
Acct_Stat_Cd         CHAR(2) NOT NULL,
)
;
ALTER TABLE T01_Deposit_Acct ALTER COLUMN Open_Dt VARCHAR(12) NOT NULL
ALTER TABLE T01_Deposit_Acct ALTER COLUMN Close_Dt VARCHAR(12) NOT NULL
SELECT * FROM T01_Deposit_Acct

CREATE TABLE T01_Agmt_Bal_H
(
Agmt_Id			CHAR(30) NOT NULL,
Agmt_Type_Cd	CHAR(2) NOT NULL,
Currency_Cd		CHAR(3) NOT NULL,
Bal				DECIMAL(18,6) NOT NULL,
Start_Dt		VARCHAR(8) NOT NULL,
End_Dt			VARCHAR(8) NOT NULL,
PRIMARY KEY (Agmt_Id,Start_Dt)
)
;
ALTER TABLE T01_Agmt_Bal_H ALTER COLUMN Start_Dt VARCHAR(12) NOT NULL
ALTER TABLE T01_Agmt_Bal_H ALTER COLUMN End_Dt VARCHAR(12) NOT NULL
SELECT * FROM T01_Agmt_Bal_H


CREATE TABLE T01_Loan_Iou
(
IOU_No CHAR(30) PRIMARY KEY NOT NULL,
Currency_Cd CHAR(3) NOT NULL,
Loan_Class_Cd CHAR(2) NOT NULL,
Cust_Id CHAR(30) NOT NULL,
Belong_Acct_Org_Id CHAR(4) NOT NULL,
Biz_Cd VARCHAR(21) NOT NULL,
Subject_Cd CHAR(6) NOT NULL,
Open_Dt				 VARCHAR(8) NOT NULL,
Open_Org_Id 		 CHAR(4) NOT NULL,
Close_Dt		     VARCHAR(8) NOT NULL,
Close_Org_Id		 CHAR(4) NOT NULL,
Close_Teller_Id      CHAR(8) NOT NULL,
Acct_Stat_Cd         CHAR(2) NOT NULL,
)
;
ALTER TABLE T01_Loan_Iou ALTER COLUMN Open_Dt	 VARCHAR(12) NOT NULL
ALTER TABLE T01_Loan_Iou ALTER COLUMN Close_Dt VARCHAR(12) NOT NULL
SELECT * FROM T01_Loan_Iou

--4、删除客户表中开户柜员号为空的数据 T01_Customer Open_Teller_Id

DELETE FROM T01_Customer WHERE Open_Teller_Id = '';

--1、	查询客户表中，所有在2011/12/01及之后开户的客户所有信息
SELECT * FROM T01_Customer WHERE YEAR(Open_Dt) >= 2011 
							 AND MONTH(Open_Dt) >= 12 OR YEAR(Open_Dt) >= 2012

SELECT * FROM T01_Customer WHERE Open_Dt >= '2011/12/01'

--2、	查询客户表中，所有在2011/12/01（含）~2011/12/25（含）之间开户的客户所有信息
SELECT * FROM T01_Customer WHERE Open_Dt BETWEEN '2011/12/01' AND  '2011/12/25'
--3、	查询客户表中，所有在2011/12/01、2011/12/20、2011/12/25这3天开户的客户所有信息
SELECT * FROM T01_Customer WHERE Open_Dt = '2011/12/01' OR Open_Dt ='2011/12/20' OR Open_Dt ='2011/12/25'
--4、	查询客户表中，所有不在2011/12/01这1天开户的客户所有信息
SELECT * FROM T01_Customer WHERE Open_Dt != '2011/12/01'
--5、	查询客户表中，所有不在2011/12/01、2011/12/20这2天开户的客户所有信息
SELECT * FROM T01_Customer WHERE Open_Dt != '2011/12/01' AND Open_Dt != '2011/12/20'
--6、	查询客户表中，所有在2011年12月开户且开户机构为7开头的客户信息（只要客户号、开户时间、开户机构这三个字段）
SELECT Cust_Id,Open_Dt,Open_Org_Id 
FROM T01_Customer 
WHERE Open_Dt BETWEEN '2011/12/01' AND  '2011/12/31' AND SUBSTRING(Open_Org_Id,1,1) = 7
--7、	查询客户表，客户号中含有数字“088”或者“188”的客户所有信息
SELECT * 
FROM T01_Customer 
WHERE Cust_Id LIKE '%088%' OR Cust_Id LIKE '%188%'
;

--1、	查询客户表，统计总共有多少条记录
SELECT COUNT(*) AS '记录个数'FROM T01_Customer

--2、	查询客户表，统计总共有多少个机构、多少个柜员（1个机构号只算1个，1个柜员号也只算1个）
SELECT COUNT(DISTINCT Open_Org_Id) AS '机构数'
	   ,COUNT(DISTINCT Open_Teller_Id) AS '柜员数'
		FROM T01_Customer

--3、	查询客户表，根据机构号分组，统计每个机构的最早开户日期、最晚开户日期
SELECT Open_Org_Id,MAX(Open_Dt),MIN(Open_Dt) 
FROM T01_Customer 
GROUP BY Open_Org_Id

SELECT MAX(Open_Dt),MIN(Open_Dt) FROM T01_Customer 

--4、	查询客户表，根据年份、机构号分组，统计每年、每个机构的开户数
SELECT	Open_Org_Id
		,substring(Open_Dt,1,4) AS '年份'
		,COUNT(Cust_Id) AS '开户个数'
FROM T01_Customer 
GROUP BY substring(Open_Dt,1,4),Open_Org_Id

--5、	查询客户表，统计每个机构的加权开户数（2000之前开户的1户算2户，2000~2005期间开户的1户算1.5户，2006开始及之后开户的算1户）
SELECT 
	Open_Org_Id
	,SUM(CASE	WHEN substring(Open_Dt,1,4) <2000 THEN 2
				WHEN substring(Open_Dt,1,4) BETWEEN 2000 AND 2005 THEN 1.5
				WHEN substring(Open_Dt,1,4) >2005 THEN 1 ELSE 0 END) AS '加权汇总'
FROM T01_Customer
GROUP BY Open_Org_Id



--1、	查询客户表，所有在2000年之后开户的客户所有信息，按开户机构（升序）、开户时间排序（降序）排序。
SELECT *
FROM T01_Customer
WHERE  YEAR(Open_Dt) >= 2000
ORDER BY Open_Org_Id,Open_Dt DESC 

--2、	查询客户表，给每个客户增加一个编号（根据开户日期排名，排名不能重复）

SELECT  ROW_NUMBER() OVER (ORDER BY Open_Dt ASC) AS 'Num',
	    T01_Customer.* 
FROM	T01_Customer

--3、	查询客户表，按年份统计、机构开户数的排名（根据开户数降序排名，排名不能重复，展示字段：年份、机构号、开户数、排名）
SELECT  YEAR(Open_Dt) AS '年份'
		,Open_Org_Id
		,COUNT(Cust_Id) AS '开户个数'
		,ROW_NUMBER() OVER (ORDER BY COUNT(Open_Org_Id) DESC ) AS '排名'
FROM	T01_Customer
GROUP BY YEAR(Open_Dt),Open_Org_Id

--1、	查询客户表、存款信息表，查询有存款的客户信息（展示字段：客户号、客户名称，记录必须唯一）
SELECT DISTINCT T01_Deposit_Acct.Cust_Id AS '客户号'
FROM			T01_Customer,T01_Deposit_Acct
WHERE			T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id 
				AND Acct_Stat_Cd = '1'
--2、	查询客户表、贷款信息表，查询无贷款的客户信息（展示字段：客户号、客户名称，记录必须唯一）
SELECT DISTINCT T01_Loan_Iou.Cust_Id AS '客户号'
FROM			T01_Customer,T01_Loan_Iou
WHERE			T01_Customer.Cust_Id NOT IN (SELECT DISTINCT T01_Loan_Iou.Cust_Id FROM T01_Loan_Iou)
				AND T01_Loan_Iou.Acct_Stat_Cd = '0'
--3、	查询客户表、存款信息表、贷款信息表，查询既有存款又有贷款的客户信息展示字段：客户号、客户名称，记录必须唯一）
SELECT DISTINCT	T01_Customer.Cust_Id AS '客户号'
FROM			T01_Customer,T01_Deposit_Acct,T01_Loan_Iou
WHERE			T01_Customer.Cust_Id IN (SELECT DISTINCT T01_Loan_Iou.Cust_Id 
										 FROM T01_Loan_Iou 
										 WHERE T01_Loan_Iou.Acct_Stat_Cd = '1')
				AND T01_Customer.Cust_Id IN (SELECT DISTINCT T01_Deposit_Acct.Cust_Id 
											 FROM T01_Deposit_Acct
											 WHERE T01_Deposit_Acct.Acct_Stat_Cd = '1')
				

--1、查询客户表、存款信息表，查询有存款的客户信息（展示字段：客户号、客户名称，账号、币种、开户日期）
SELECT  T01_Customer.Cust_Id AS '客户号'
		,T01_Customer.Open_Teller_Id AS '开户柜员号'
		,T01_Deposit_Acct.Deposit_Acct_No AS '账号'
		,T01_Deposit_Acct.Currency_Cd AS '币种'
		,T01_Deposit_Acct.Open_Dt AS '开户日期'
FROM	T01_Customer,T01_Deposit_Acct
WHERE	T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id
		AND  T01_Deposit_Acct.Acct_Stat_Cd = '1'

SELECT  T01_Deposit_Acct.Cust_Id AS '客户号'
		,T01_Deposit_Acct.Deposit_Acct_No AS '账号'
		,T01_Deposit_Acct.Currency_Cd AS '币种'
		,T01_Deposit_Acct.Open_Dt AS '开户日期'
FROM	T01_Deposit_Acct INNER JOIN T01_Customer
ON		(T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id)
		AND T01_Deposit_Acct.Acct_Stat_Cd = '1'

--2、查询客户表、存款信息表、贷款信息表，查询所有客户信息（展示字段：客户号、客户名称，
--													账号、币种、开户日期、开户日期、借据号、
--											贷款种类代码、所属账务机构，如果有null值则转换成空值）
SELECT  ISNULL(T01_Customer.Cust_Id,'') AS '客户号'
		--,T01_Deposit_Acct.Cust_Id AS '客户号'
		,ISNULL(T01_Deposit_Acct.Deposit_Acct_No,'') AS '账号'
		,ISNULL(T01_Deposit_Acct.Currency_Cd,'') AS '币种'
		,ISNULL(T01_Deposit_Acct.Open_Dt,'') AS '存款开户日期'
		--,T01_Loan_Iou.Cust_Id AS '客户号'
		,ISNULL(T01_Loan_Iou.Open_Dt,'') AS '贷款开户日期'
		,ISNULL(T01_Loan_Iou.IOU_No,'') AS '借据号'
		,ISNULL(T01_Loan_Iou.Loan_Class_Cd,'') AS '贷款种类代码'
		,ISNULL(T01_Loan_Iou.Belong_Acct_Org_Id,'') AS '所属账务机构'
FROM	T01_Customer FULL JOIN T01_Deposit_Acct
					 ON (T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id)
					 FULL JOIN T01_Loan_Iou
					 ON (T01_Customer.Cust_Id = T01_Loan_Iou.Cust_Id)
ORDER BY T01_Customer.Cust_Id

--1、查询客户表、存款信息表，查询有存款的客户信息（展示字段：客户号、客户名称，账号、币种、开户日期）
SELECT  T01_Customer.Cust_Id AS '客户号'
		,T01_Customer.Open_Teller_Id AS '开户柜员号'
		,T01_Deposit_Acct.Deposit_Acct_No AS '账号'
		,T01_Deposit_Acct.Currency_Cd AS '币种'
		,T01_Deposit_Acct.Open_Dt AS '开户日期'
FROM	T01_Customer,T01_Deposit_Acct
WHERE	T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id
		AND  T01_Deposit_Acct.Acct_Stat_Cd = '1'

SELECT  T01_Deposit_Acct.Cust_Id AS '客户号'
		,T01_Deposit_Acct.Deposit_Acct_No AS '账号'
		,T01_Deposit_Acct.Currency_Cd AS '币种'
		,T01_Deposit_Acct.Open_Dt AS '开户日期'
FROM	T01_Deposit_Acct INNER JOIN T01_Customer
ON		(T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id)
		AND T01_Deposit_Acct.Acct_Stat_Cd = '1'

--2、查询客户表、存款信息表、贷款信息表，查询所有客户信息（展示字段：客户号、客户名称，
--													账号、币种、开户日期、开户日期、借据号、
--											贷款种类代码、所属账务机构，如果有null值则转换成空值）
SELECT  ISNULL(T01_Customer.Cust_Id,'') AS '客户号'
		--,T01_Deposit_Acct.Cust_Id AS '客户号'
		,ISNULL(T01_Deposit_Acct.Deposit_Acct_No,'') AS '账号'
		,ISNULL(T01_Deposit_Acct.Currency_Cd,'') AS '币种'
		,ISNULL(T01_Deposit_Acct.Open_Dt,'') AS '存款开户日期'
		--,T01_Loan_Iou.Cust_Id AS '客户号'
		,ISNULL(T01_Loan_Iou.Open_Dt,'') AS '贷款开户日期'
		,ISNULL(T01_Loan_Iou.IOU_No,'') AS '借据号'
		,ISNULL(T01_Loan_Iou.Loan_Class_Cd,'') AS '贷款种类代码'
		,ISNULL(T01_Loan_Iou.Belong_Acct_Org_Id,'') AS '所属账务机构'
FROM	T01_Customer FULL JOIN T01_Deposit_Acct
					 ON (T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id)
					 FULL JOIN T01_Loan_Iou
					 ON (T01_Customer.Cust_Id = T01_Loan_Iou.Cust_Id)
ORDER BY T01_Customer.Cust_Id

--1、	查询客户表、存款信息表、贷款信息表，统计每个客户的存款账号个数、贷款借据个数
--（展示字段：客户号、客户姓名、存款账号个数、贷款借据个数，如果没有存款则存款账户个数置0，如果没有贷款则贷款借据号个数置0）
--,T01_Deposit_Acct,T01_Loan_Iou
SELECT  T01_Customer.Cust_Id AS '客户号'
		,COUNT(T01_Deposit_Acct.Deposit_Acct_No) AS '存款账号个数'
		,COUNT(T01_Loan_Iou.IOU_No) AS '贷款借据个数'
FROM	T01_Customer FULL JOIN T01_Deposit_Acct
					 ON (T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id)
					 FULL JOIN T01_Loan_Iou
					 ON (T01_Customer.Cust_Id = T01_Loan_Iou.Cust_Id)
GROUP BY T01_Customer.Cust_Id

--2、查询存款信息表、协议余额历史，统计客户号1035797902下每个帐号在2011.12.31这一天的余额
	--（展示字段：客户号、存款账号、开户机构、开户日期、2011.12.31余额）
SELECT  T01_Deposit_Acct.Cust_Id AS '客户号'
		,T01_Deposit_Acct.Deposit_Acct_No AS '存款账号'
		,T01_Deposit_Acct.Open_Org_Id AS '开户机构'
		,T01_Deposit_Acct.Open_Dt AS '开户日期'
		,T01_Agmt_Bal_H.Bal AS '2011.12.31余额'
FROM	T01_Deposit_Acct,T01_Agmt_Bal_H
WHERE   Cust_Id = 1035797902
		AND T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
		AND T01_Agmt_Bal_H.Start_Dt <= '2012/12/31'
		AND T01_Agmt_Bal_H.End_Dt > '2012/12/31'
		AND T01_Agmt_Bal_H.Agmt_Type_Cd = 01

SELECT *
FROM T01_Agmt_Bal_H

--3、查询存款信息表、协议余额历史表，统计客户号1035797902下每个帐号在2011年12月的月日均（月日均等于当月每日余额累加除以当月天数）
--（展示字段：客户号、存款账号、开户机构、开户日期、2011.12月日均）
SELECT  T01_Deposit_Acct.Cust_Id AS '客户号'
		,T01_Deposit_Acct.Deposit_Acct_No AS '存款账号'
		,T01_Deposit_Acct.Open_Org_Id AS '开户机构'
		,T01_Deposit_Acct.Open_Dt AS '开户日期'
		,SUM(T01_Agmt_Bal_H.Bal)/31 AS '2011.12月日均'
FROM	T01_Deposit_Acct,T01_Agmt_Bal_H
WHERE   Cust_Id = 1035797902
		AND T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
		AND T01_Agmt_Bal_H.Start_Dt >= '2011/12/01'
		AND T01_Agmt_Bal_H.Start_Dt <= '2011/12/31'
GROUP BY T01_Deposit_Acct.Cust_Id 
		,T01_Deposit_Acct.Deposit_Acct_No 
		,T01_Deposit_Acct.Open_Org_Id 
		,T01_Deposit_Acct.Open_Dt 
		
--4、	查询客户号为1049193052的2011.12.31贷款时点余额（客户有多少个贷款帐号在贷款信息表中，
	--  每个贷款帐号的余额在协议余额历史表中Agmt_Type_Cd=’02’）
SELECT  T01_Loan_Iou.Cust_Id AS '客户号'
		,T01_Loan_Iou.IOU_No AS '借据号'
		,T01_Agmt_Bal_H.Bal AS '2011.12.31贷款时点余额'
FROM	T01_Agmt_Bal_H,T01_Loan_Iou
WHERE   T01_Loan_Iou.Cust_Id = 1049193052
		AND T01_Loan_Iou.IOU_No  = T01_Agmt_Bal_H.Agmt_Id 
		AND T01_Agmt_Bal_H.Start_Dt <= '2012/12/31'
		AND T01_Agmt_Bal_H.End_Dt > '2012/12/31'
		AND T01_Agmt_Bal_H.Agmt_Type_Cd = 02
GROUP BY T01_Loan_Iou.Cust_Id
		 ,T01_Loan_Iou.IOU_No
		 ,T01_Agmt_Bal_H.Bal
