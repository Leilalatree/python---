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
							 AND MONTH(Open_Dt) >= 12

SELECT CONVERT(varchar(100), Open_Dt, 12) FROM T01_Customer
SELECT * FROM T01_Customer WHERE CONVERT(varchar(100), Open_Dt, 12)
SELECT * FROM T01_Customer WHERE CONVERT(Open_Dt,'%Y%m%d')>= 20111201

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