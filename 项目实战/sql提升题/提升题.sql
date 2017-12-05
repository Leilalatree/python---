
--������������������������������������������������������������ DAY 1������������������������������������������������������������
--�޸����ڸ�ʽ

ALTER TABLE T01_Customer ALTER COLUMN Open_Dt DATE NOT NULL;
ALTER TABLE T01_Customer ALTER COLUMN Close_Dt DATE NOT NULL;

ALTER TABLE T01_Deposit_Acct ALTER COLUMN Open_Dt DATE NOT NULL;
ALTER TABLE T01_Deposit_Acct ALTER COLUMN Close_Dt DATE NOT NULL;

ALTER TABLE T01_Loan_Iou ALTER COLUMN Open_Dt DATE NOT NULL;
ALTER TABLE T01_Loan_Iou ALTER COLUMN Close_Dt DATE NOT NULL;

ALTER TABLE T01_Agmt_Bal_H ALTER COLUMN Start_Dt DATE NOT NULL;
ALTER TABLE T01_Agmt_Bal_H ALTER COLUMN End_Dt DATE NOT NULL;

--3����ѯ�����Ϣ��Э�������ʷ��ͳ�ƿͻ���1035797902��ÿ���ʺ���2011��12�µ����վ������վ����ڵ���ÿ������ۼӳ��Ե���������
--��չʾ�ֶΣ��ͻ��š�����˺š������������������ڡ�2011.12���վ���

SELECT  
		T01_Deposit_Acct.Cust_Id					AS '�ͻ���'
		,T01_Deposit_Acct.Deposit_Acct_No			AS '����˺�'
		,T01_Deposit_Acct.Open_Org_Id				AS '��������'
		,T01_Deposit_Acct.Open_Dt					AS '��������'
		,SUM(
				CASE WHEN	
							T01_Agmt_Bal_H.End_Dt > '2011/12/31' 
							AND T01_Agmt_Bal_H.Start_Dt < '2011/12/01'
							THEN	T01_Agmt_Bal_H.Bal * 31
					 WHEN	
							T01_Agmt_Bal_H.Start_Dt < '2011/12/01' 
							AND (T01_Agmt_Bal_H.End_Dt BETWEEN '2011/12/01' AND '2011/12/31')
							THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart( DayOfYear,'2011/12/01'))
					 WHEN   
							T01_Agmt_Bal_H.Start_Dt >= '2011/12/01'
							AND T01_Agmt_Bal_H.End_Dt < '2011/12/31'
							THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt))
					 WHEN   
							(T01_Agmt_Bal_H.Start_Dt BETWEEN '2011/12/01' AND '2011/12/31')
							AND T01_Agmt_Bal_H.End_Dt > '2011/12/31'    
							THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,'2011/12/31')-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt)+1)
							 
				ELSE 0
				END
			)/31							AS '2011��12�µ����վ�'
FROM	
		T01_Deposit_Acct,T01_Agmt_Bal_H
WHERE   
		Cust_Id = 1035797902
		AND T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
		AND T01_Agmt_Bal_H.Start_Dt < '2012/01/01'
		AND T01_Agmt_Bal_H.End_Dt >= '2011/12/01'
GROUP BY 
		T01_Deposit_Acct.Cust_Id 
		,T01_Deposit_Acct.Deposit_Acct_No 
		,T01_Deposit_Acct.Open_Org_Id 
		,T01_Deposit_Acct.Open_Dt ;

-- 3��	ͳ�����пͻ��Ĵ����˻�����2011.12.31�յĴ�����2011.12�������վ�
SELECT
		T01_Loan_Iou.Cust_Id	AS '�ͻ���'
		,T01_Loan_Iou.IOU_No    AS '�����˺�'
		,T01_Agmt_Bal_H.Bal     AS '2011.12.31�������'	
FROM
		T01_Agmt_Bal_H
		,T01_Loan_Iou
WHERE
		T01_Agmt_Bal_H.Agmt_Id = T01_Loan_Iou.IOU_No
		AND T01_Agmt_Bal_H.Start_Dt <= '2011/12/31'
		AND T01_Agmt_Bal_H.End_Dt > '2011/12/31';
--2011.12�������վ�
SELECT  
		T01_Loan_Iou.Cust_Id			AS '�ͻ���'
		,SUM(
				CASE WHEN	
							T01_Agmt_Bal_H.End_Dt > '2011/12/31' 
							AND T01_Agmt_Bal_H.Start_Dt < '2011/12/01'
							THEN	T01_Agmt_Bal_H.Bal * 31
					 WHEN	
							T01_Agmt_Bal_H.Start_Dt < '2011/12/01' 
							AND (T01_Agmt_Bal_H.End_Dt BETWEEN '2011/12/01' AND '2011/12/31')
							THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart( DayOfYear,'2011/12/01'))
					 WHEN   
							T01_Agmt_Bal_H.Start_Dt >= '2011/12/01'
							AND T01_Agmt_Bal_H.End_Dt < '2011/12/31'
							THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt))
					 WHEN   
							(T01_Agmt_Bal_H.Start_Dt BETWEEN '2011/12/01' AND '2011/12/31')
							AND T01_Agmt_Bal_H.End_Dt > '2011/12/31'    
							THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,'2011/12/31')-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt)+1)
							 
				ELSE 0
				END
			)/31							AS '2011��12�µ����վ�'
FROM	
		T01_Loan_Iou,T01_Agmt_Bal_H
WHERE   
		T01_Loan_Iou.IOU_No = T01_Agmt_Bal_H.Agmt_Id 
		AND T01_Agmt_Bal_H.Start_Dt < '2012/01/01'
		AND T01_Agmt_Bal_H.End_Dt >= '2011/12/01'
GROUP BY 
		T01_Loan_Iou.Cust_Id 
		,T01_Loan_Iou.Acct_Stat_Cd		
		,T01_Loan_Iou.Open_Dt;

--������������������������������������������������������������ DAY 2������������������������������������������������������������
--1��	��ѯ�ͻ���ͳ��ÿ������2000��֮ǰ��������2000~2005����������ͷ����β����
--		2005~2010����������ͷ����β����2010֮�󿪻���
--		չʾ�ֶΣ������š�2000��֮ǰ��������2000~2005�꿪������2005~2010�꿪������2010��֮�󿪻���

SELECT
		Open_Org_Id [������]
		,SUM(CASE WHEN YEAR(Open_Dt) < 2000 THEN 1 ELSE 0 END) [2000֮ǰ������]
		,SUM(CASE WHEN YEAR(Open_Dt) >= 2000 AND YEAR(Open_Dt) < 2005 THEN 1 ELSE 0 END) [2000~2005������]
		,SUM(CASE WHEN YEAR(Open_Dt) >= 2005 AND YEAR(Open_Dt) < 2010 THEN 1 ELSE 0 END) [2005~2010������]
		,SUM(CASE WHEN YEAR(Open_Dt) >= 2010 THEN 1 ELSE 0 END) [2010֮�󿪻���]
FROM	
		T01_Customer
GROUP BY 
		Open_Org_Id;

--2��	��ѯ�ͻ��������ͳ�ƣ�ÿ�ꡢÿ������������ռȫ�꿪������ռ��
--չʾ�ֶΣ���ݡ������š�������������ռ�Ȱٷֱȣ��ٷֱȣ�
SELECT 	
		YEAR(A.Open_Dt)					AS '���'
        ,A.Open_Org_Id				 	AS '��������'
        ,COUNT(A.Cust_Id)				AS '������'
		,CAST(1.0*COUNT(A.Cust_Id)/B.�������� AS NUMERIC(18,4))	AS '������ռ��'
	
FROM
		t01_customer A
LEFT JOIN 
		(
		SELECT 	
				YEAR(Open_Dt)	AS '���'
				,count(*)		AS '��������'
		FROM
				t01_customer
		GROUP BY 	
				YEAR(Open_Dt)
		) AS B
ON 
		YEAR(A.Open_Dt) = B.��� 
GROUP BY 	
		A.Open_Org_Id
        ,YEAR(A.Open_Dt)
        ,B.��������;

-- 3��	ͳ�����пͻ��Ŀͻ��š�����˻�����2011.12.31�յĴ����
--2011.12������վ��������˻�����2011.12.31�յĴ�����2011.12�������վ�
SELECT  DISTINCT 
		A.Cust_Id 									AS '�ͻ���'
		,ISNULL(C_01.����˺Ÿ���,'0')				AS '����˻���'
		,ISNULL(C_02.���,'0')						AS '[2011.12.31������]'		
		,ISNULL(C_03.[2011��12�µ����վ�],'0')		AS '[2011.12������վ�]'      
		,COUNT(D.IOU_No) 							AS '�����˻���'
		,ISNULL(D_02.[2011.12.31�������],'0')		AS '[2011.12.31�������]'
		,ISNULL(D_03.[2011��12�µ����վ�],'0')		AS '[2011.12�������վ�]'
FROM	T01_Customer A 	
		------------------------------------����˻���--------------------------------------------------------
						LEFT JOIN 	(
									SELECT 
											Cust_Id
											,COUNT(Deposit_Acct_No)	AS '����˺Ÿ���'
									FROM
											T01_Deposit_Acct 
									GROUP BY
											Cust_Id
									) C_01
						ON 			A.Cust_Id = C_01.Cust_Id
		-------------------------------2011.12.31�յĴ�����-------------------------------------------------
                        LEFT JOIN 	(
									SELECT   
											Cust_Id AS �ͻ���
											,SUM(bal) AS ���
									FROM 
											t01_agmt_bal_h
                                            ,t01_deposit_acct
									WHERE 
											Start_Dt <= '2011-12-31' 
                                            AND End_Dt > '2011-12-31'
											AND  Deposit_Acct_No = Agmt_Id
									GROUP BY
											Cust_Id
									) C_02
						ON 			C_02.�ͻ��� = A.Cust_Id
		------------------------------------2011.12������վ�-------------------------------------------------
						LEFT JOIN   (
									SELECT  T01_Deposit_Acct.Cust_Id			AS '�ͻ���'
											,T01_Deposit_Acct.Deposit_Acct_No	AS '����˺�'
											,T01_Deposit_Acct.Open_Org_Id		AS '��������'
											,T01_Deposit_Acct.Open_Dt			AS '��������'
											,SUM(
													CASE WHEN	
																T01_Agmt_Bal_H.End_Dt > '2011/12/31' 
																AND T01_Agmt_Bal_H.Start_Dt < '2011/12/01'
																THEN	T01_Agmt_Bal_H.Bal * 31
														 WHEN	
																T01_Agmt_Bal_H.Start_Dt < '2011/12/01' 
																AND (T01_Agmt_Bal_H.End_Dt BETWEEN '2011/12/01' AND '2011/12/31')
																THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart( DayOfYear,'2011/12/01'))
														 WHEN   
																T01_Agmt_Bal_H.Start_Dt >= '2011/12/01'
																AND T01_Agmt_Bal_H.End_Dt < '2011/12/31'
																THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt))
														 WHEN   
																(T01_Agmt_Bal_H.Start_Dt BETWEEN '2011/12/01' AND '2011/12/31')
																AND T01_Agmt_Bal_H.End_Dt > '2011/12/31'    
																THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,'2011/12/31')-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt)+1)
							 
													ELSE 0
													END
												)/31							AS '2011��12�µ����վ�'
									FROM	T01_Deposit_Acct,T01_Agmt_Bal_H
									WHERE   T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
											AND T01_Agmt_Bal_H.Start_Dt < '2012/01/01'
											AND T01_Agmt_Bal_H.End_Dt >= '2011/12/01'
									GROUP BY T01_Deposit_Acct.Cust_Id 
											,T01_Deposit_Acct.Deposit_Acct_No 
											,T01_Deposit_Acct.Open_Org_Id 
											,T01_Deposit_Acct.Open_Dt
									) C_03
						ON			(A.Cust_Id = C_03.�ͻ���)
		-----------------------------------------------�����˻���--------------------------------------------
						LEFT JOIN 	T01_Loan_Iou D
						ON 			(A.Cust_Id = D.Cust_Id)
		----------------------------------------2011.12.31�յĴ������---------------------------------------
						LEFT JOIN   (
									SELECT
											T01_Loan_Iou.Cust_Id	AS '�ͻ���'
											,T01_Loan_Iou.IOU_No    AS '�����˺�'
											,T01_Agmt_Bal_H.Bal     AS '2011.12.31�������'
		
									FROM
											T01_Agmt_Bal_H
											,T01_Loan_Iou
									WHERE
											T01_Agmt_Bal_H.Agmt_Id = T01_Loan_Iou.IOU_No
											AND T01_Agmt_Bal_H.Start_Dt <= '2011/12/31'
											AND T01_Agmt_Bal_H.End_Dt > '2011/12/31'
									) D_02
						ON			(A.Cust_Id = D_02.�ͻ���)
		----------------------------------------2011.12�������վ�-------------------------------------------
						LEFT JOIN	(
									SELECT  
											T01_Loan_Iou.Cust_Id			AS '�ͻ���'
											,SUM(
													CASE WHEN	
																T01_Agmt_Bal_H.End_Dt > '2011/12/31' 
																AND T01_Agmt_Bal_H.Start_Dt < '2011/12/01'
																THEN	T01_Agmt_Bal_H.Bal * 31
														 WHEN	
																T01_Agmt_Bal_H.Start_Dt < '2011/12/01' 
																AND (T01_Agmt_Bal_H.End_Dt BETWEEN '2011/12/01' AND '2011/12/31')
																THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart( DayOfYear,'2011/12/01'))
														 WHEN   
																T01_Agmt_Bal_H.Start_Dt >= '2011/12/01'
																AND T01_Agmt_Bal_H.End_Dt < '2011/12/31'
																THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt))
														 WHEN   
																(T01_Agmt_Bal_H.Start_Dt BETWEEN '2011/12/01' AND '2011/12/31')
																AND T01_Agmt_Bal_H.End_Dt > '2011/12/31'    
																THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,'2011/12/31')-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt)+1)
							 
													ELSE 0
													END
												)/31							AS '2011��12�µ����վ�'
									FROM	
											T01_Loan_Iou,T01_Agmt_Bal_H
									WHERE   
											T01_Loan_Iou.IOU_No = T01_Agmt_Bal_H.Agmt_Id 
											AND T01_Agmt_Bal_H.Start_Dt < '2012/01/01'
											AND T01_Agmt_Bal_H.End_Dt >= '2011/12/01'
									GROUP BY 
											T01_Loan_Iou.Cust_Id 
											,T01_Loan_Iou.Acct_Stat_Cd		
											,T01_Loan_Iou.Open_Dt
									) D_03
						ON			(A.Cust_Id = D_03.�ͻ���)
GROUP BY 
		A.Cust_Id
		,C_02.���
        ,C_01.����˺Ÿ���
		,C_03.[2011��12�µ����վ�] 
		,D_02.[2011.12.31�������]
		,D_03.[2011��12�µ����վ�];

--������������������������������������������������������������ DAY 3������������������������������������������������������������
/** 1��	ͳ�����пͻ���2011.12.31�յĴ�������������������������������������
��ע������������� = 2011.12.31�յĴ�����-2011.12.30�յĴ�����
      ����������� = 2011.12.31�յĴ�����-2011.11.30�յĴ�����
      ����������� = 2011.12.31�յĴ�����-2010.12.31�յĴ�����
   ֻ��2011.12.31������ڿ���д������������Ҫͨ��2011.12.31������������ɡ�  **/
		-----------------------------------�Դ���Ϊ����----------------------------------------
SELECT  DISTINCT
		MAIN.Cust_Id																AS '�ͻ���'
		,MAIN.Deposit_Acct_No														AS '����˺�'
		,ISNULL(TABLE1.[2011.12.31���],'0')										AS '2011.12.31���'
		,ISNULL(TABLE1.[2011.12.31���],'0')-ISNULL(TABLE2.[2011.12.30���],'0')	AS '�����������'
		,ISNULL(TABLE1.[2011.12.31���],'0')-ISNULL(TABLE3.[2011.11.30���],'0')	AS '�����������'
		,ISNULL(TABLE1.[2011.12.31���],'0')-ISNULL(TABLE4.[2010.12.31���],'0')	AS '�����������'
FROM	T01_Deposit_Acct MAIN
		-----------------------���пͻ���2011.12.31�յĴ�����----------------------------
		LEFT JOIN	(					
					SELECT  
							T01_Deposit_Acct.Cust_Id				AS '�ͻ���'
							,T01_Deposit_Acct.Deposit_Acct_No		AS '����˺�'
							,T01_Agmt_Bal_H.Bal						AS '2011.12.31���'
					FROM	
							T01_Deposit_Acct
							,T01_Agmt_Bal_H
					WHERE   T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
							AND T01_Agmt_Bal_H.Start_Dt <= '2011/12/31'
							AND T01_Agmt_Bal_H.End_Dt > '2011/12/31'
							AND T01_Agmt_Bal_H.Agmt_Type_Cd = 01
					) TABLE1
		ON			(
					MAIN.Cust_Id = TABLE1.�ͻ���
					AND MAIN.Deposit_Acct_No = TABLE1.����˺�
					)
		-----------------------���пͻ���2011.12.31�յ��������---------------------------
		LEFT JOIN	(
					SELECT  
							T01_Deposit_Acct.Cust_Id				AS '�ͻ���'
							,T01_Deposit_Acct.Deposit_Acct_No		AS '����˺�'
							,T01_Agmt_Bal_H.Bal						AS '2011.12.30���'
					FROM	
							T01_Deposit_Acct
							,T01_Agmt_Bal_H
					WHERE   T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
							AND T01_Agmt_Bal_H.Start_Dt <=  DATEADD(DAY,-1,'2011/12/31') 
							AND T01_Agmt_Bal_H.End_Dt > DATEADD(DAY,-1,'2011/12/31') 
							AND T01_Agmt_Bal_H.Agmt_Type_Cd = 01					
					) TABLE2
		ON			(
					MAIN.Cust_Id = TABLE2.�ͻ���
					AND MAIN.Deposit_Acct_No = TABLE2.����˺�
					)
		-----------------------���пͻ���2011.12.31�յ��������---------------------------
		LEFT JOIN	(
					SELECT  
							T01_Deposit_Acct.Cust_Id				AS '�ͻ���'
							,T01_Deposit_Acct.Deposit_Acct_No		AS '����˺�'
							,T01_Agmt_Bal_H.Bal						AS '2011.11.30���'
					FROM	
							T01_Deposit_Acct
							,T01_Agmt_Bal_H
					WHERE   T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
							AND T01_Agmt_Bal_H.Start_Dt <= DATEADD(MONTH,-1,'2011/12/31')
							AND T01_Agmt_Bal_H.End_Dt > DATEADD(MONTH,-1,'2011/12/31')
							AND T01_Agmt_Bal_H.Agmt_Type_Cd = 01	
					) TABLE3
		ON			(
					MAIN.Cust_Id = TABLE3.�ͻ���
					AND MAIN.Deposit_Acct_No = TABLE3.����˺�
					)
		-----------------------���пͻ���2011.12.31�յ��������---------------------------
		LEFT JOIN	(
					SELECT  
							T01_Deposit_Acct.Cust_Id				AS '�ͻ���'
							,T01_Deposit_Acct.Deposit_Acct_No		AS '����˺�'
							,T01_Agmt_Bal_H.Bal						AS '2010.12.31���'
					FROM	
							T01_Deposit_Acct
							,T01_Agmt_Bal_H
					WHERE   
							T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
							AND T01_Agmt_Bal_H.Start_Dt <= DATEADD(YEAR,-1,'2011/12/31')
							AND T01_Agmt_Bal_H.End_Dt > DATEADD(YEAR,-1,'2011/12/31')
							AND T01_Agmt_Bal_H.Agmt_Type_Cd = 01
					) TABLE4
		ON			(
					MAIN.Cust_Id = TABLE4.�ͻ���
					AND MAIN.Deposit_Acct_No = TABLE4.����˺�
					)
GROUP BY
		MAIN.Cust_Id
		,MAIN.Deposit_Acct_No		
		,TABLE1.[2011.12.31���]
		,TABLE2.[2011.12.30���]
		,TABLE3.[2011.11.30���]
		,TABLE4.[2010.12.31���];

--2��	ͳ������2011�������վ�����100�Ŀͻ��š��ͻ����ơ�����˻�����2011�����վ�
SELECT		
			T01_Customer.Cust_Id									AS '�ͻ���'
			,TABLE2.����˻���
			,TABLE1.[2011�����վ�]
FROM		
			T01_Customer
			----------------------------��ѯ����˻���---------------------------------------
			LEFT JOIN
			(
				SELECT 
						T01_Deposit_Acct.Cust_Id					AS '�ͻ���'
						,COUNT(T01_Deposit_Acct.Deposit_Acct_No)	AS '����˻���'
				FROM	
						T01_Deposit_Acct
				GROUP BY 
						T01_Deposit_Acct.Cust_Id 
				) TABLE2
			ON	(TABLE2.�ͻ��� = T01_Customer.Cust_Id)
			---------------------------��ѯ2011�����վ�---------------------------------------
			LEFT JOIN 
			(
				SELECT  
						T01_Deposit_Acct.Cust_Id					AS '�ͻ���'
						,SUM(
								CASE WHEN	
											T01_Agmt_Bal_H.End_Dt > '2011/12/31' 
											AND T01_Agmt_Bal_H.Start_Dt < '2011/01/01'
											THEN	T01_Agmt_Bal_H.Bal * 365
									 WHEN	
											T01_Agmt_Bal_H.Start_Dt < '2011/01/01'
											AND (T01_Agmt_Bal_H.End_Dt BETWEEN '2011/01/01' AND '2011/12/31')
											THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart( DayOfYear,'2011/01/01'))
									 WHEN   
											T01_Agmt_Bal_H.Start_Dt >= '2011/01/01'
											AND T01_Agmt_Bal_H.End_Dt <= '2011/12/31'
											THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt))
									 WHEN   
											(T01_Agmt_Bal_H.Start_Dt BETWEEN '2011/01/01' AND '2011/12/31')
											AND T01_Agmt_Bal_H.End_Dt > '2011/12/31'    
											THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,'2011/12/31')-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt)+1)
							 
								ELSE 0
								END
							)/365							AS '2011�����վ�'
				FROM	
						T01_Deposit_Acct,T01_Agmt_Bal_H
				WHERE   
						T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
						AND T01_Agmt_Bal_H.Start_Dt < '2012/01/01'
						AND T01_Agmt_Bal_H.End_Dt	>= '2011/01/01'
				GROUP BY 
						T01_Deposit_Acct.Cust_Id 
			) TABLE1
			ON (
				T01_Customer.Cust_Id = TABLE1.�ͻ���
				)
WHERE		TABLE1.[2011�����վ�] > 100
GROUP BY	
			T01_Customer.Cust_Id									
			,TABLE2.����˻���
			,TABLE1.[2011�����վ�];


--������������������������������������������������������������ DAY 4������������������������������������������������������������
--1��	ͳ������2011�������վ���2011��������վ�������100�Ŀͻ��š�����˻�����
--		2011�������վ��������˻�����2011��������վ�
SELECT		
			T01_Customer.Cust_Id									AS '�ͻ���'
			,TABLE1.����˻���
			,TABLE2.[2011�������վ�]
			,TABLE3.�����˻���
			,TABLE4.[2011��������վ�]
FROM		
			T01_Customer
			----------------------------��ѯ����˻���-------------------------------------------
			LEFT JOIN
			(
				SELECT 
						T01_Deposit_Acct.Cust_Id					AS '�ͻ���'
						,COUNT(T01_Deposit_Acct.Deposit_Acct_No)	AS '����˻���'
				FROM	
						T01_Deposit_Acct
				GROUP BY 
						T01_Deposit_Acct.Cust_Id 
				) TABLE1
			ON	(TABLE1.�ͻ��� = T01_Customer.Cust_Id)
			---------------------------��ѯ2011�������վ�---------------------------------------
			LEFT JOIN 
			(
				SELECT  
						T01_Deposit_Acct.Cust_Id					AS '�ͻ���'
						,SUM(
								CASE WHEN	
											T01_Agmt_Bal_H.End_Dt > '2011/12/31' 
											AND T01_Agmt_Bal_H.Start_Dt < '2011/01/01'
											THEN	T01_Agmt_Bal_H.Bal * 365
									 WHEN	
											T01_Agmt_Bal_H.Start_Dt < '2011/01/01'
											AND (T01_Agmt_Bal_H.End_Dt BETWEEN '2011/01/01' AND '2011/12/31')
											THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart( DayOfYear,'2011/01/01'))
									 WHEN   
											T01_Agmt_Bal_H.Start_Dt >= '2011/01/01'
											AND T01_Agmt_Bal_H.End_Dt <= '2011/12/31'
											THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt))
									 WHEN   
											(T01_Agmt_Bal_H.Start_Dt BETWEEN '2011/01/01' AND '2011/12/31')
											AND T01_Agmt_Bal_H.End_Dt > '2011/12/31'    
											THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,'2011/12/31')-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt)+1)
							 
								ELSE 0
								END
							)/365							AS '2011�������վ�'
				FROM	
						T01_Deposit_Acct,T01_Agmt_Bal_H
				WHERE   
						T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
						AND T01_Agmt_Bal_H.Start_Dt < '2012/01/01'
						AND T01_Agmt_Bal_H.End_Dt	>= '2011/01/01'
				GROUP BY 
						T01_Deposit_Acct.Cust_Id 
			) TABLE2
			ON (
				T01_Customer.Cust_Id = TABLE2.�ͻ���
				)
			----------------------------��ѯ�����˻���---------------------------------------
			LEFT JOIN
			(
				SELECT 
						T01_Loan_Iou.Cust_Id					AS '�ͻ���'
						,COUNT(T01_Loan_Iou.IOU_No)				AS '�����˻���'
				FROM	
						T01_Loan_Iou
				GROUP BY 
						T01_Loan_Iou.Cust_Id 
				) TABLE3
			ON	(TABLE3.�ͻ��� = T01_Customer.Cust_Id)
			---------------------------��ѯ2011��������վ�---------------------------------------
			LEFT JOIN 
			(
				SELECT  
						T01_Loan_Iou.Cust_Id					AS '�ͻ���'
						,SUM(
								CASE WHEN	
											T01_Agmt_Bal_H.End_Dt > '2011/12/31' 
											AND T01_Agmt_Bal_H.Start_Dt < '2011/01/01'
											THEN	T01_Agmt_Bal_H.Bal * 365
									 WHEN	
											T01_Agmt_Bal_H.Start_Dt < '2011/01/01'
											AND (T01_Agmt_Bal_H.End_Dt BETWEEN '2011/01/01' AND '2011/12/31')
											THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart( DayOfYear,'2011/01/01'))
									 WHEN   
											T01_Agmt_Bal_H.Start_Dt >= '2011/01/01'
											AND T01_Agmt_Bal_H.End_Dt <= '2011/12/31'
											THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt))
									 WHEN   
											(T01_Agmt_Bal_H.Start_Dt BETWEEN '2011/01/01' AND '2011/12/31')
											AND T01_Agmt_Bal_H.End_Dt > '2011/12/31'    
											THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,'2011/12/31')-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt)+1)
							 
								ELSE 0
								END
							)/365							AS '2011��������վ�'
				FROM	
						T01_Loan_Iou,T01_Agmt_Bal_H
				WHERE   
						T01_Loan_Iou.IOU_No = T01_Agmt_Bal_H.Agmt_Id 
						AND T01_Agmt_Bal_H.Start_Dt < '2012/01/01'
						AND T01_Agmt_Bal_H.End_Dt	>= '2011/01/01'
				GROUP BY 
						T01_Loan_Iou.Cust_Id 
			) TABLE4
			ON (
				T01_Customer.Cust_Id = TABLE4.�ͻ���
				)
WHERE		
			TABLE2.[2011�������վ�] > 100
			AND TABLE4.[2011��������վ�] > 100
ORDER BY 
			TABLE1.�ͻ���
			,TABLE1.����˻���
			,TABLE2.[2011�������վ�]
			,TABLE3.�����˻���
			,TABLE4.[2011��������վ�];



/**2��	ͳ�����пͻ��Ŀͻ��š�
		����־���д���˻��Ŀͻ���Ϊ1��û����˻��Ŀͻ���Ϊ0����
		�����־���д����ݵĿͻ���Ϊ1��û�����ݵĿͻ���Ϊ0����
		����������ࣨ2011�������վ�>=10000��Ϊ���ʡ�2011�������վ�>=1000<10000
		��Ϊ���á�2011�������վ�<1000��Ϊ��ͨ����
		2011�������վ���
		�����������ࣨ2011��������վ�>=10000��Ϊ���ʡ�2011��������վ�>=1000<10000
		��Ϊ���á�2011��������վ�<1000��Ϊ��ͨ����
		2011��������վ�				**/
SELECT	
			Table1.Cust_Id
			,ISNULL(Table2.����־,'0')																AS '����־'
			,ISNULL(Table3.�����־,'0')																AS '�����־'
			,CAST(ISNULL(Table4.[2011�������վ�],'0')	AS NUMERIC(18,2))								AS '2011�������վ�'
			,(CASE	WHEN	ISNULL(Table4.[2011�������վ�],'0') >= 10000 THEN '����' 
					WHEN	ISNULL(Table4.[2011�������վ�],'0') >= 1000
					AND		ISNULL(Table4.[2011�������վ�],'0') < 10000  THEN '����' 
					ELSE														'��ͨ'	
					END)																				AS '�����������'
			,CAST(ISNULL(TABLE5.[2011��������վ�],'0')	AS numeric(18,2))								AS '2011��������վ�'
			,(CASE	WHEN	ISNULL(Table5.[2011��������վ�],'0') >= 10000 THEN '����' 
					WHEN	ISNULL(Table5.[2011��������վ�],'0') >= 1000
					AND		ISNULL(Table5.[2011��������վ�],'0') < 10000  THEN '����' 
					ELSE														'��ͨ'	
					END)																				AS '������������'

FROM	
			T01_Customer Table1
		--------------------------------------------------��ѯ����־------------------------------------------------
			LEFT JOIN
					(
					SELECT	
							T01_Deposit_Acct.Cust_Id													AS '�ͻ���'
							,CASE WHEN T01_Deposit_Acct.Deposit_Acct_No IS NOT NULL THEN 1 ELSE 0 END		AS '����־'
					FROM	T01_Deposit_Acct 
					) Table2
			ON		(Table2.�ͻ��� = Table1.Cust_Id)
		--------------------------------------------------��ѯ�����־------------------------------------------------
			LEFT JOIN
					(
					SELECT	
							T01_Loan_Iou.Cust_Id														AS '�ͻ���'
							,CASE WHEN T01_Loan_Iou.IOU_No IS NOT NULL THEN 1 ELSE 0 END				AS '�����־'
					FROM	T01_Loan_Iou
					) Table3
			ON		(Table3.�ͻ��� = Table1.Cust_Id)
		----------------------------------------------��ѯ2011�������վ�-----------------------------------------------
			LEFT JOIN 
			(
				SELECT  
						T01_Deposit_Acct.Cust_Id					AS '�ͻ���'
						,SUM(
								CASE WHEN	
											T01_Agmt_Bal_H.End_Dt > '2011/12/31' 
											AND T01_Agmt_Bal_H.Start_Dt < '2011/01/01'
											THEN	T01_Agmt_Bal_H.Bal * 365
									 WHEN	
											T01_Agmt_Bal_H.Start_Dt < '2011/01/01'
											AND (T01_Agmt_Bal_H.End_Dt BETWEEN '2011/01/01' AND '2011/12/31')
											THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart( DayOfYear,'2011/01/01'))
									 WHEN   
											T01_Agmt_Bal_H.Start_Dt >= '2011/01/01'
											AND T01_Agmt_Bal_H.End_Dt <= '2011/12/31'
											THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt))
									 WHEN   
											(T01_Agmt_Bal_H.Start_Dt BETWEEN '2011/01/01' AND '2011/12/31')
											AND T01_Agmt_Bal_H.End_Dt > '2011/12/31'    
											THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,'2011/12/31')-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt)+1)
							 
								ELSE 0
								END
							)/365							AS '2011�������վ�'
							
				FROM	
						T01_Deposit_Acct,T01_Agmt_Bal_H
				WHERE   
						T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
						AND T01_Agmt_Bal_H.Start_Dt < '2012/01/01'
						AND T01_Agmt_Bal_H.End_Dt	>= '2011/01/01'
				GROUP BY 
						T01_Deposit_Acct.Cust_Id 
			) Table4
			ON (
				Table1.Cust_Id = Table4.�ͻ���
				)
			---------------------------��ѯ2011��������վ�---------------------------------------
			LEFT JOIN 
			(
				SELECT  
						T01_Loan_Iou.Cust_Id					AS '�ͻ���'
						,SUM(
								CASE WHEN	
											T01_Agmt_Bal_H.End_Dt > '2011/12/31' 
											AND T01_Agmt_Bal_H.Start_Dt < '2011/01/01'
											THEN	T01_Agmt_Bal_H.Bal * 365
									 WHEN	
											T01_Agmt_Bal_H.Start_Dt < '2011/01/01'
											AND (T01_Agmt_Bal_H.End_Dt BETWEEN '2011/01/01' AND '2011/12/31')
											THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart( DayOfYear,'2011/01/01'))
									 WHEN   
											T01_Agmt_Bal_H.Start_Dt >= '2011/01/01'
											AND T01_Agmt_Bal_H.End_Dt <= '2011/12/31'
											THEN   T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt))
									 WHEN   
											(T01_Agmt_Bal_H.Start_Dt BETWEEN '2011/01/01' AND '2011/12/31')
											AND T01_Agmt_Bal_H.End_Dt > '2011/12/31'    
											THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,'2011/12/31')-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt)+1)
							 
								ELSE 0
								END
							)/365							AS '2011��������վ�'
				FROM	
						T01_Loan_Iou,T01_Agmt_Bal_H
				WHERE   
						T01_Loan_Iou.IOU_No = T01_Agmt_Bal_H.Agmt_Id 
						AND T01_Agmt_Bal_H.Start_Dt < '2012/01/01'
						AND T01_Agmt_Bal_H.End_Dt	>= '2011/01/01'
				GROUP BY 
						T01_Loan_Iou.Cust_Id 
			) TABLE5
			ON (
				Table1.Cust_Id = TABLE5.�ͻ���
				)
GROUP BY
			Table1.Cust_Id
			,Table2.����־
			,Table3.�����־
			,Table4.[2011�������վ�]
			,TABLE5.[2011��������վ�];


--������������������������������������������������������������ DAY 5������������������������������������������������������������
--1��	���ݡ��¼���.xlsx��������Ȼ��excel�е����ݵ��뵽Ŀ�����
CREATE TABLE 
		T01_EventsList
		(
			Event_Id			VARCHAR(30) NOT NULL			--�¼����	
			,Trade_Date			DATE		NOT NULL			--��������
			,Serial_Number		VARCHAR(20) NOT NULL			--������ˮ��
			,System_Date		DATE		NOT NULL			--ϵͳ����
			,System_Time		TIME		NOT NULL			--ϵͳʱ��
			,Trade_Code			VARCHAR(6)	NOT NULL			--������
			,Event_Number		VARCHAR(20) NOT NULL			--�˺�
			,Trade_Amount		MONEY		NOT NULL			--���׽��
			,Fees				MONEY		NOT NULL			--����������
			,PRIMARY KEY(Event_Id,System_Date,Event_Number)
		);

ALTER TABLE T01_EventsList ALTER COLUMN System_Time VARCHAR(12) NOT NULL;


/**
2��	���ݿͻ��������Ϣ���¼���ͳ��
	ÿ���ͻ�2017��Ŀͻ��š�
	�����˻������ͻ����ж��ٸ��˻��н��׾��Ƕ��٣���
	�����н��׵����������2017����5���й����ף����н�������Ϊ5����
	�����н��������������2017��1��3��5���н��ף����н���������Ϊ3����
	�����½����ܽ�����ͳ�ƽ��׽���������½��׽���
	����½��׽����·ݣ�����ͳ�ƽ��׽���Ž��׽�������·ݣ���

	���ܽ��׽�
	�꽻�׽�����������ͻ�����������ܽ��׽��Ϊ0���򲻲���������������Ϊ9999����
	���������ѡ�
	�������������������ͻ������������������Ϊ0���򲻲���������������Ϊ9999��**/

SELECT
		T01_Customer.Cust_Id													AS '�ͻ���'
		,ISNULL(TABLE1.�����˻���,'0')											AS '�����˻���'
		,ISNULL(TABLE1.��������,'0')											AS '��������'
		,ISNULL(TABLE1.��������,'0')											AS '��������'
		,ISNULL(TABLE3.�����½����ܽ��,'0')									AS '�����½����ܽ��'
		,ISNULL(TABLE3.����½��׽����·�,'0')								AS '����½��׽����·�'
		,ISNULL(TABLE5.�ͻ����ܽ��׽��,'0')									AS '���ܽ��׽��'
		,ISNULL(TABLE5.����,'9999')												AS '����'
		,ISNULL(TABLE6.����������,'0')											AS '����������'
		,ISNULL(TABLE6.����,'9999')												AS '����'
FROM
		T01_Customer 
		---------------------------------------------��ѯ����˻���,������������������----------------------------------------------------
			LEFT JOIN
			(SELECT 
					T01_Deposit_Acct.Cust_Id									AS '�ͻ���'
					,COUNT(DISTINCT Event_Number)								AS '�����˻���'
					,COUNT(DISTINCT E1.Trade_Date)								AS '��������'
					,COUNT(DISTINCT MONTH(E1.Trade_Date))						AS '��������'
			FROM 
					T01_Deposit_Acct
					LEFT JOIN
							T01_EventsList E1
					ON	(T01_Deposit_Acct.Deposit_Acct_No = E1.Event_Number)
			GROUP BY
					T01_Deposit_Acct.Cust_Id
				) TABLE1
			ON	(TABLE1.�ͻ��� = T01_Customer.Cust_Id)
		-------------------------------------------------------------------------------------------------------------------------------
			LEFT JOIN
			(
			SELECT DISTINCT
					T01_Deposit_Acct.Cust_Id											AS '�˺�'
					,ISNULL(MAX(TABLE2.����׽��),'0')								AS '�����½����ܽ��'
					,ISNULL(TABLE2.�·�,'0')											AS '����½��׽����·�'
			FROM 
					T01_Deposit_Acct
					--------------------------------------��ѯÿ���˻�������׽��·�---------------------------------------------
					LEFT JOIN
					(
							SELECT 
									Event_Number											AS '�˺�' 
									,MAX(DISTINCT Trade_Amount)								AS '����׽��'
									,E2.�·�												AS '�·�'
							FROM
									T01_EventsList
									------------------------------��ѯ�·�--------------------------------------------------------------
									LEFT JOIN
									(
											SELECT	
													T01_EventsList.Event_Number				AS '�˺�'
													,MONTH(T01_EventsList.Trade_Date)		AS '�·�'	
											FROM
													T01_EventsList	
									)	E2
									ON		(E2.�˺� = T01_EventsList.Event_Number)
							GROUP BY
									Event_Number
									,E2.�·�			
					) TABLE2
							ON	(T01_Deposit_Acct.Deposit_Acct_No = TABLE2.�˺�)
			GROUP BY
					T01_Deposit_Acct.Cust_Id
					,TABLE2.�·�
			)	TABLE3
			ON (TABLE3.�˺� = T01_Customer.Cust_Id)
			----------------------------------------���ܽ��׽��꽻�׽������-----------------------------------------------------------------
			LEFT JOIN
			(
					SELECT 
							T01_Deposit_Acct.Cust_Id														AS '�ͻ���'
							,ISNULL(SUM(TABLE4.���ܽ��׽��),'0')											AS '�ͻ����ܽ��׽��'
							,CASE	WHEN SUM(TABLE4.���ܽ��׽��) = '0'		THEN '9999'
									WHEN SUM(TABLE4.���ܽ��׽��) IS NULL	THEN '9999'
									ELSE RANK()over(order by SUM(TABLE4.���ܽ��׽��)DESC)
									END																		AS '����'	
					FROM
							T01_Deposit_Acct
							LEFT JOIN
							(
								SELECT 
										Event_Number														AS '�˺�'
										,SUM(Trade_Amount)													AS '���ܽ��׽��'			 
								FROM 
										T01_EventsList
								GROUP BY
										Event_Number

							)	TABLE4
							ON (TABLE4.�˺� = T01_Deposit_Acct.Deposit_Acct_No)
					GROUP BY
							T01_Deposit_Acct.Cust_Id
			) TABLE5
			ON (TABLE5.�ͻ��� = T01_Customer.Cust_Id)
			----------------------------------------���������ѡ���������������-----------------------------------------------------------------
			LEFT JOIN
			(
					SELECT 
							T01_Deposit_Acct.Cust_Id														AS '�ͻ���'
							,ISNULL(SUM(TABLE_FEES.����������),'0')											AS '����������'
							,CASE	WHEN SUM(TABLE_FEES.����������) = '0'		THEN '9999'
									WHEN SUM(TABLE_FEES.����������) IS NULL	THEN '9999'
									ELSE RANK()over(order by SUM(TABLE_FEES.����������)DESC)
									END																		AS '����'	
					FROM
							T01_Deposit_Acct
							LEFT JOIN
							(
								SELECT 
										Event_Number														AS '�˺�'
										,SUM(Fees)															AS '����������'			 
								FROM 
										T01_EventsList
								GROUP BY
										Event_Number

							)	TABLE_FEES
							ON (TABLE_FEES.�˺� = T01_Deposit_Acct.Deposit_Acct_No)
					GROUP BY
							T01_Deposit_Acct.Cust_Id
			) TABLE6
			ON (TABLE6.�ͻ��� = T01_Customer.Cust_Id)
GROUP BY
		T01_Customer.Cust_Id													
		,TABLE1.�����˻���
		,TABLE1.��������
		,TABLE1.��������
		,TABLE3.�����½����ܽ��
		,TABLE3.����½��׽����·�
		,TABLE5.�ͻ����ܽ��׽��
		,TABLE5.����
		,TABLE6.����������
		,TABLE6.����
ORDER BY 
		TABLE5.���� 
		




/**�����½����ܽ�����ͳ�ƽ��׽���������½��׽���
	����½��׽����·ݣ�����ͳ�ƽ��׽���Ž��׽�������·ݣ���**/

SELECT 
		Event_Number
		,MAX(Trade_Amount)
		,STUFF((SELECT ','+MONTH(Trade_Date) FROM T01_EventsList FOR XML PATH('')),1,1,'')
FROM 
		T01_EventsList
GROUP BY
		Event_Number
		,MONTH(Trade_Date)



					

