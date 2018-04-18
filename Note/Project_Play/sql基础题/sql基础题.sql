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

--4��ɾ���ͻ����п�����Ա��Ϊ�յ����� T01_Customer Open_Teller_Id

DELETE FROM T01_Customer WHERE Open_Teller_Id = '';

--1��	��ѯ�ͻ����У�������2011/12/01��֮�󿪻��Ŀͻ�������Ϣ
SELECT * FROM T01_Customer WHERE YEAR(Open_Dt) >= 2011 
							 AND MONTH(Open_Dt) >= 12 OR YEAR(Open_Dt) >= 2012

SELECT * FROM T01_Customer WHERE Open_Dt >= '2011/12/01'

--2��	��ѯ�ͻ����У�������2011/12/01������~2011/12/25������֮�俪���Ŀͻ�������Ϣ
SELECT * FROM T01_Customer WHERE Open_Dt BETWEEN '2011/12/01' AND  '2011/12/25'
--3��	��ѯ�ͻ����У�������2011/12/01��2011/12/20��2011/12/25��3�쿪���Ŀͻ�������Ϣ
SELECT * FROM T01_Customer WHERE Open_Dt = '2011/12/01' OR Open_Dt ='2011/12/20' OR Open_Dt ='2011/12/25'
--4��	��ѯ�ͻ����У����в���2011/12/01��1�쿪���Ŀͻ�������Ϣ
SELECT * FROM T01_Customer WHERE Open_Dt != '2011/12/01'
--5��	��ѯ�ͻ����У����в���2011/12/01��2011/12/20��2�쿪���Ŀͻ�������Ϣ
SELECT * FROM T01_Customer WHERE Open_Dt != '2011/12/01' AND Open_Dt != '2011/12/20'
--6��	��ѯ�ͻ����У�������2011��12�¿����ҿ�������Ϊ7��ͷ�Ŀͻ���Ϣ��ֻҪ�ͻ��š�����ʱ�䡢���������������ֶΣ�
SELECT Cust_Id,Open_Dt,Open_Org_Id 
FROM T01_Customer 
WHERE Open_Dt BETWEEN '2011/12/01' AND  '2011/12/31' AND SUBSTRING(Open_Org_Id,1,1) = 7
--7��	��ѯ�ͻ����ͻ����к������֡�088�����ߡ�188���Ŀͻ�������Ϣ
SELECT * 
FROM T01_Customer 
WHERE Cust_Id LIKE '%088%' OR Cust_Id LIKE '%188%'
;

--1��	��ѯ�ͻ���ͳ���ܹ��ж�������¼
SELECT COUNT(*) AS '��¼����'FROM T01_Customer

--2��	��ѯ�ͻ���ͳ���ܹ��ж��ٸ����������ٸ���Ա��1��������ֻ��1����1����Ա��Ҳֻ��1����
SELECT COUNT(DISTINCT Open_Org_Id) AS '������'
	   ,COUNT(DISTINCT Open_Teller_Id) AS '��Ա��'
		FROM T01_Customer

--3��	��ѯ�ͻ������ݻ����ŷ��飬ͳ��ÿ�����������翪�����ڡ�����������
SELECT Open_Org_Id,MAX(Open_Dt),MIN(Open_Dt) 
FROM T01_Customer 
GROUP BY Open_Org_Id

SELECT MAX(Open_Dt),MIN(Open_Dt) FROM T01_Customer 

--4��	��ѯ�ͻ���������ݡ������ŷ��飬ͳ��ÿ�ꡢÿ�������Ŀ�����
SELECT	Open_Org_Id
		,substring(Open_Dt,1,4) AS '���'
		,COUNT(Cust_Id) AS '��������'
FROM T01_Customer 
GROUP BY substring(Open_Dt,1,4),Open_Org_Id

--5��	��ѯ�ͻ���ͳ��ÿ�������ļ�Ȩ��������2000֮ǰ������1����2����2000~2005�ڼ俪����1����1.5����2006��ʼ��֮�󿪻�����1����
SELECT 
	Open_Org_Id
	,SUM(CASE	WHEN substring(Open_Dt,1,4) <2000 THEN 2
				WHEN substring(Open_Dt,1,4) BETWEEN 2000 AND 2005 THEN 1.5
				WHEN substring(Open_Dt,1,4) >2005 THEN 1 ELSE 0 END) AS '��Ȩ����'
FROM T01_Customer
GROUP BY Open_Org_Id



--1��	��ѯ�ͻ���������2000��֮�󿪻��Ŀͻ�������Ϣ�����������������򣩡�����ʱ�����򣨽�������
SELECT *
FROM T01_Customer
WHERE  YEAR(Open_Dt) >= 2000
ORDER BY Open_Org_Id,Open_Dt DESC 

--2��	��ѯ�ͻ�����ÿ���ͻ�����һ����ţ����ݿ����������������������ظ���

SELECT  ROW_NUMBER() OVER (ORDER BY Open_Dt ASC) AS 'Num',
	    T01_Customer.* 
FROM	T01_Customer

--3��	��ѯ�ͻ��������ͳ�ơ����������������������ݿ������������������������ظ���չʾ�ֶΣ���ݡ������š���������������
SELECT  YEAR(Open_Dt) AS '���'
		,Open_Org_Id
		,COUNT(Cust_Id) AS '��������'
		,ROW_NUMBER() OVER (ORDER BY COUNT(Open_Org_Id) DESC ) AS '����'
FROM	T01_Customer
GROUP BY YEAR(Open_Dt),Open_Org_Id

--1��	��ѯ�ͻ��������Ϣ����ѯ�д��Ŀͻ���Ϣ��չʾ�ֶΣ��ͻ��š��ͻ����ƣ���¼����Ψһ��
SELECT DISTINCT T01_Deposit_Acct.Cust_Id AS '�ͻ���'
FROM			T01_Customer,T01_Deposit_Acct
WHERE			T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id 
				AND Acct_Stat_Cd = '1'
--2��	��ѯ�ͻ���������Ϣ����ѯ�޴���Ŀͻ���Ϣ��չʾ�ֶΣ��ͻ��š��ͻ����ƣ���¼����Ψһ��
SELECT DISTINCT T01_Loan_Iou.Cust_Id AS '�ͻ���'
FROM			T01_Customer,T01_Loan_Iou
WHERE			T01_Customer.Cust_Id NOT IN (SELECT DISTINCT T01_Loan_Iou.Cust_Id FROM T01_Loan_Iou)
				AND T01_Loan_Iou.Acct_Stat_Cd = '0'
--3��	��ѯ�ͻ��������Ϣ��������Ϣ����ѯ���д�����д���Ŀͻ���Ϣչʾ�ֶΣ��ͻ��š��ͻ����ƣ���¼����Ψһ��
SELECT DISTINCT	T01_Customer.Cust_Id AS '�ͻ���'
FROM			T01_Customer,T01_Deposit_Acct,T01_Loan_Iou
WHERE			T01_Customer.Cust_Id IN (SELECT DISTINCT T01_Loan_Iou.Cust_Id 
										 FROM T01_Loan_Iou 
										 WHERE T01_Loan_Iou.Acct_Stat_Cd = '1')
				AND T01_Customer.Cust_Id IN (SELECT DISTINCT T01_Deposit_Acct.Cust_Id 
											 FROM T01_Deposit_Acct
											 WHERE T01_Deposit_Acct.Acct_Stat_Cd = '1')
				

--1����ѯ�ͻ��������Ϣ����ѯ�д��Ŀͻ���Ϣ��չʾ�ֶΣ��ͻ��š��ͻ����ƣ��˺š����֡��������ڣ�
SELECT  T01_Customer.Cust_Id AS '�ͻ���'
		,T01_Customer.Open_Teller_Id AS '������Ա��'
		,T01_Deposit_Acct.Deposit_Acct_No AS '�˺�'
		,T01_Deposit_Acct.Currency_Cd AS '����'
		,T01_Deposit_Acct.Open_Dt AS '��������'
FROM	T01_Customer,T01_Deposit_Acct
WHERE	T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id
		AND  T01_Deposit_Acct.Acct_Stat_Cd = '1'

SELECT  T01_Deposit_Acct.Cust_Id AS '�ͻ���'
		,T01_Deposit_Acct.Deposit_Acct_No AS '�˺�'
		,T01_Deposit_Acct.Currency_Cd AS '����'
		,T01_Deposit_Acct.Open_Dt AS '��������'
FROM	T01_Deposit_Acct INNER JOIN T01_Customer
ON		(T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id)
		AND T01_Deposit_Acct.Acct_Stat_Cd = '1'

--2����ѯ�ͻ��������Ϣ��������Ϣ����ѯ���пͻ���Ϣ��չʾ�ֶΣ��ͻ��š��ͻ����ƣ�
--													�˺š����֡��������ڡ��������ڡ���ݺš�
--											����������롢������������������nullֵ��ת���ɿ�ֵ��
SELECT  ISNULL(T01_Customer.Cust_Id,'') AS '�ͻ���'
		--,T01_Deposit_Acct.Cust_Id AS '�ͻ���'
		,ISNULL(T01_Deposit_Acct.Deposit_Acct_No,'') AS '�˺�'
		,ISNULL(T01_Deposit_Acct.Currency_Cd,'') AS '����'
		,ISNULL(T01_Deposit_Acct.Open_Dt,'') AS '��������'
		--,T01_Loan_Iou.Cust_Id AS '�ͻ���'
		,ISNULL(T01_Loan_Iou.Open_Dt,'') AS '���������'
		,ISNULL(T01_Loan_Iou.IOU_No,'') AS '��ݺ�'
		,ISNULL(T01_Loan_Iou.Loan_Class_Cd,'') AS '�����������'
		,ISNULL(T01_Loan_Iou.Belong_Acct_Org_Id,'') AS '�����������'
FROM	T01_Customer FULL JOIN T01_Deposit_Acct
					 ON (T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id)
					 FULL JOIN T01_Loan_Iou
					 ON (T01_Customer.Cust_Id = T01_Loan_Iou.Cust_Id)
ORDER BY T01_Customer.Cust_Id

--1����ѯ�ͻ��������Ϣ����ѯ�д��Ŀͻ���Ϣ��չʾ�ֶΣ��ͻ��š��ͻ����ƣ��˺š����֡��������ڣ�
SELECT  T01_Customer.Cust_Id AS '�ͻ���'
		,T01_Customer.Open_Teller_Id AS '������Ա��'
		,T01_Deposit_Acct.Deposit_Acct_No AS '�˺�'
		,T01_Deposit_Acct.Currency_Cd AS '����'
		,T01_Deposit_Acct.Open_Dt AS '��������'
FROM	T01_Customer,T01_Deposit_Acct
WHERE	T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id
		AND  T01_Deposit_Acct.Acct_Stat_Cd = '1'

SELECT  T01_Deposit_Acct.Cust_Id AS '�ͻ���'
		,T01_Deposit_Acct.Deposit_Acct_No AS '�˺�'
		,T01_Deposit_Acct.Currency_Cd AS '����'
		,T01_Deposit_Acct.Open_Dt AS '��������'
FROM	T01_Deposit_Acct INNER JOIN T01_Customer
ON		(T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id)
		AND T01_Deposit_Acct.Acct_Stat_Cd = '1'

--2����ѯ�ͻ��������Ϣ��������Ϣ����ѯ���пͻ���Ϣ��չʾ�ֶΣ��ͻ��š��ͻ����ƣ�
--													�˺š����֡��������ڡ��������ڡ���ݺš�
--											����������롢������������������nullֵ��ת���ɿ�ֵ��
SELECT  ISNULL(T01_Customer.Cust_Id,'') AS '�ͻ���'
		--,T01_Deposit_Acct.Cust_Id AS '�ͻ���'
		,ISNULL(T01_Deposit_Acct.Deposit_Acct_No,'') AS '�˺�'
		,ISNULL(T01_Deposit_Acct.Currency_Cd,'') AS '����'
		,ISNULL(T01_Deposit_Acct.Open_Dt,'') AS '��������'
		--,T01_Loan_Iou.Cust_Id AS '�ͻ���'
		,ISNULL(T01_Loan_Iou.Open_Dt,'') AS '���������'
		,ISNULL(T01_Loan_Iou.IOU_No,'') AS '��ݺ�'
		,ISNULL(T01_Loan_Iou.Loan_Class_Cd,'') AS '�����������'
		,ISNULL(T01_Loan_Iou.Belong_Acct_Org_Id,'') AS '�����������'
FROM	T01_Customer FULL JOIN T01_Deposit_Acct
					 ON (T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id)
					 FULL JOIN T01_Loan_Iou
					 ON (T01_Customer.Cust_Id = T01_Loan_Iou.Cust_Id)
ORDER BY T01_Customer.Cust_Id

--1��	��ѯ�ͻ��������Ϣ��������Ϣ��ͳ��ÿ���ͻ��Ĵ���˺Ÿ����������ݸ���
--��չʾ�ֶΣ��ͻ��š��ͻ�����������˺Ÿ����������ݸ��������û�д�������˻�������0�����û�д���������ݺŸ�����0��
--,T01_Deposit_Acct,T01_Loan_Iou
SELECT  T01_Customer.Cust_Id AS '�ͻ���'
		,COUNT(T01_Deposit_Acct.Deposit_Acct_No) AS '����˺Ÿ���'
		,COUNT(T01_Loan_Iou.IOU_No) AS '�����ݸ���'
FROM	T01_Customer FULL JOIN T01_Deposit_Acct
					 ON (T01_Customer.Cust_Id = T01_Deposit_Acct.Cust_Id)
					 FULL JOIN T01_Loan_Iou
					 ON (T01_Customer.Cust_Id = T01_Loan_Iou.Cust_Id)
GROUP BY T01_Customer.Cust_Id

--2����ѯ�����Ϣ��Э�������ʷ��ͳ�ƿͻ���1035797902��ÿ���ʺ���2011.12.31��һ������
	--��չʾ�ֶΣ��ͻ��š�����˺š������������������ڡ�2011.12.31��
SELECT  T01_Deposit_Acct.Cust_Id AS '�ͻ���'
		,T01_Deposit_Acct.Deposit_Acct_No AS '����˺�'
		,T01_Deposit_Acct.Open_Org_Id AS '��������'
		,T01_Deposit_Acct.Open_Dt AS '��������'
		,T01_Agmt_Bal_H.Bal AS '2011.12.31���'
FROM	T01_Deposit_Acct,T01_Agmt_Bal_H
WHERE   Cust_Id = 1035797902
		AND T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
		AND T01_Agmt_Bal_H.Start_Dt <= '2012/12/31'
		AND T01_Agmt_Bal_H.End_Dt > '2012/12/31'
		AND T01_Agmt_Bal_H.Agmt_Type_Cd = 01

SELECT *
FROM T01_Agmt_Bal_H

--3����ѯ�����Ϣ��Э�������ʷ��ͳ�ƿͻ���1035797902��ÿ���ʺ���2011��12�µ����վ������վ����ڵ���ÿ������ۼӳ��Ե���������
--��չʾ�ֶΣ��ͻ��š�����˺š������������������ڡ�2011.12���վ���
SELECT  T01_Deposit_Acct.Cust_Id AS '�ͻ���'
		,T01_Deposit_Acct.Deposit_Acct_No AS '����˺�'
		,T01_Deposit_Acct.Open_Org_Id AS '��������'
		,T01_Deposit_Acct.Open_Dt AS '��������'
		,SUM(T01_Agmt_Bal_H.Bal)/31 AS '2011.12���վ�'
FROM	T01_Deposit_Acct,T01_Agmt_Bal_H
WHERE   Cust_Id = 1035797902
		AND T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
		AND T01_Agmt_Bal_H.Start_Dt >= '2011/12/01'
		AND T01_Agmt_Bal_H.Start_Dt <= '2011/12/31'
GROUP BY T01_Deposit_Acct.Cust_Id 
		,T01_Deposit_Acct.Deposit_Acct_No 
		,T01_Deposit_Acct.Open_Org_Id 
		,T01_Deposit_Acct.Open_Dt 
		
--4��	��ѯ�ͻ���Ϊ1049193052��2011.12.31����ʱ�����ͻ��ж��ٸ������ʺ��ڴ�����Ϣ���У�
	--  ÿ�������ʺŵ������Э�������ʷ����Agmt_Type_Cd=��02����
SELECT  T01_Loan_Iou.Cust_Id AS '�ͻ���'
		,T01_Loan_Iou.IOU_No AS '��ݺ�'
		,T01_Agmt_Bal_H.Bal AS '2011.12.31����ʱ�����'
FROM	T01_Agmt_Bal_H,T01_Loan_Iou
WHERE   T01_Loan_Iou.Cust_Id = 1049193052
		AND T01_Loan_Iou.IOU_No  = T01_Agmt_Bal_H.Agmt_Id 
		AND T01_Agmt_Bal_H.Start_Dt <= '2012/12/31'
		AND T01_Agmt_Bal_H.End_Dt > '2012/12/31'
		AND T01_Agmt_Bal_H.Agmt_Type_Cd = 02
GROUP BY T01_Loan_Iou.Cust_Id
		 ,T01_Loan_Iou.IOU_No
		 ,T01_Agmt_Bal_H.Bal
