--SQL�Ż�

--�����õ�����ʱ��
-------------------------------��ʱ������˻���--------------------------------------------------
SELECT	* 
INTO	##MyTempTable1
FROM
		(
			SELECT	Cust_Id
					,COUNT(Deposit_Acct_No)	AS '����˺Ÿ���'
			FROM	
					T01_Deposit_Acct 
			GROUP BY	
					Cust_Id) AS Count_Deposit_Acct_No;
-------------------------------��ʱ��2011.12.31�յĴ�����--------------------------------------
SELECT	*
INTO	##MyTempTable2
FROM	(
		SELECT   
				Cust_Id						AS '�ͻ���'
				,SUM(bal)					AS '���'
				,Deposit_Acct_No			AS '����˺�'
		FROM 
				t01_agmt_bal_h
				,t01_deposit_acct
		WHERE 
				Start_Dt <= '2011-12-31' 
				AND End_Dt > '2011-12-31'
				AND  Deposit_Acct_No = Agmt_Id
		GROUP BY
				Cust_Id
				,Deposit_Acct_No
		) AS Bal_On_1231;
-------------------------------��ʱ��2011.12������վ�-------------------------------------------
SELECT	*
INTO	##MyTempTable3
FROM	(
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
				) AS AvgBal_On_12;
-------------------------------��ʱ��2011.12.31�յĴ������--------------------------------------
SELECT	*
INTO	##MyTempTable4
FROM	(
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
		) AS D_Bal_On_1231;
-------------------------------��ʱ��2011.12�������վ�-------------------------------------------
SELECT	*
INTO	##MyTempTable5
FROM	(
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
					THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart( DayOfYear,'2011/12/01'))
					WHEN   
							T01_Agmt_Bal_H.Start_Dt >= '2011/12/01'
							AND T01_Agmt_Bal_H.End_Dt < '2011/12/31'
					THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt))
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
		) AS D_AvgBal_On_12;

-------------------------------��ʱ��2011.12.31�յ����մ�����--------------------------------------
SELECT	*
INTO	##MyTempTable6
FROM	(
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
		)	AS TABEL1;
-------------------------------��ʱ��2011.12.31�յ����´�����--------------------------------------
SELECT	*
INTO	##MyTempTable7
FROM	(
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
		)	AS TABEL2;
-------------------------------��ʱ��2011.12.31�յ����������--------------------------------------
SELECT	*
INTO	##MyTempTable8
FROM	(
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
		)	AS TABEL3;

-------------------------------��ʱ��2011�������վ�-----------------------------------------------
SELECT	*
INTO	##MyTempTable9
FROM	(
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
					THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart( DayOfYear,'2011/01/01'))
					WHEN   
							T01_Agmt_Bal_H.Start_Dt >= '2011/01/01'
							AND T01_Agmt_Bal_H.End_Dt <= '2011/12/31'
					THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt))
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
		) TABLE3;

-------------------------------��ʱ��2011��������վ�-----------------------------------------------
SELECT	*	
INTO	##MyTempTable10
FROM	(
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
					THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart( DayOfYear,'2011/01/01'))
					WHEN	T01_Agmt_Bal_H.Start_Dt >= '2011/01/01'
							AND T01_Agmt_Bal_H.End_Dt <= '2011/12/31'
					THEN	T01_Agmt_Bal_H.Bal*(datepart( DayOfYear,T01_Agmt_Bal_H.End_Dt)-datepart (DayOfYear,T01_Agmt_Bal_H.Start_Dt))
					WHEN	(T01_Agmt_Bal_H.Start_Dt BETWEEN '2011/01/01' AND '2011/12/31')
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
			) AS TABLE5;

-------------------------------��ʱ������־-----------------------------------------------
SELECT	*
INTO	##MyTempTable11
FROM	(
		SELECT	
				T01_Deposit_Acct.Cust_Id													AS '�ͻ���'
				,CASE WHEN T01_Deposit_Acct.Deposit_Acct_No IS NOT NULL THEN 1 ELSE 0 END		AS '����־'
		FROM	T01_Deposit_Acct 
		) TABLE11;
-------------------------------��ʱ�������־-----------------------------------------------
SELECT	*
INTO	##MyTempTable12
FROM	(
		SELECT	
				T01_Loan_Iou.Cust_Id														AS '�ͻ���'
				,CASE WHEN T01_Loan_Iou.IOU_No IS NOT NULL THEN 1 ELSE 0 END				AS '�����־'
		FROM	T01_Loan_Iou
		) TABLE12;

-------------------------------��ʱ������˻���,������������������-----------------------------------------------
SELECT	*
INTO	##MyTempTable13
FROM	(
		SELECT 
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
		) AS TB501;
-------------------------------��ʱ�����ܽ��׽��꽻�׽������-----------------------------------------------

SELECT	*
INTO	##MyTempTable14
FROM	(
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
		) AS TB503;
-------------------------------��ʱ�� ���������ѡ���������������-----------------------------------------------
SELECT	*
INTO	##MyTempTable15
FROM	(
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
		) AS TB504;
-------------------------------��ʱ�� ÿ���ͻ�������׽��·�-----------------------------------------------
SELECT  *
INTO	##MyTempTable16
FROM	(
		---��ѯ��ÿ���ͻ�������׽����˻����½����ܽ��·�-------------------------------------------------------
		SELECT *
		FROM
		(
		SELECT	
			RANK() OVER(PARTITION BY T01_Deposit_Acct.Cust_Id 
									ORDER BY 
									T3.�½����ܽ��		DESC
									,T3.�·�			DESC
									) id
			,T01_Deposit_Acct.Cust_Id												AS '�ͻ���'
			,T01_Deposit_Acct.Deposit_Acct_No										AS '�˺�'
			,ISNULL(T3.�½����ܽ��,'0')											AS '�½����ܽ��'
			,ISNULL(T3.�·�,'0')													AS '�·�'
		FROM
			T01_Deposit_Acct
			LEFT JOIN
			(
			----��ѯ��ÿ���˺ŵ�����׽����·�  һ���ͻ���Ӧ����˺ţ����� �ͻ���ÿ���ͻ���ͬ�˺ŵĽ��׽������ѡ���׽������һ��
			SELECT	T2.�˺�													AS '�˺�'
					,T2.�½����ܽ��										AS '�½����ܽ��'
					,T2.�·�												AS '�·�'
			FROM
				(
				-------------------����˳��1�����׽�2���½��ױ�����3���·� �Ӵ�С-----------------
				SELECT	RANK() OVER(PARTITION BY T1.�˺� 
								ORDER BY 
								T1.�½����ܽ��		DESC
								,T1.�˺��½��ױ���	DESC
								,T1.�·�			DESC
								) id
								,T1.*
				FROM
						(
						SELECT	
								Event_Number								AS '�˺�'
								,SUM(Trade_Amount)							AS '�½����ܽ��'
								,COUNT(Event_Id)							AS '�˺��½��ױ���'
								,MONTH(T01_EventsList.Trade_Date)			AS '�·�'
						FROM	
								T01_EventsList
						GROUP BY 
								Event_Number
								,MONTH(T01_EventsList.Trade_Date)
						)T1
		
				) T2
			WHERE T2.id=1
			) T3
			ON		T3.�˺� = T01_Deposit_Acct.Deposit_Acct_No
		)T4
		WHERE	T4.id = 1
		)AS TB502;

--������������������������������������������������������������ DAY 2������������������������������������������������������������

-- 3��	ͳ�����пͻ��Ŀͻ��š�����˻�����2011.12.31�յĴ����
--2011.12������վ��������˻�����2011.12.31�յĴ�����2011.12�������վ�

--------------------------------------�ܱ�---------------------------------------------------------
SELECT  DISTINCT 
		A.Cust_Id 												AS '�ͻ���'
		,ISNULL(##MyTempTable1.����˺Ÿ���,'0')				AS '����˻���'
		,ISNULL(##MyTempTable2.���,'0')						AS '[2011.12.31������]'
		,ISNULL(##MyTempTable3.[2011��12�µ����վ�],'0')		AS '[2011.12������վ�]' 
		,COUNT(D.IOU_No) 										AS '�����˻���'
		,ISNULL(##MyTempTable4.�����˺�,'0')					AS '[2011.12.31�������]'
		,ISNULL(##MyTempTable5.[2011��12�µ����վ�],'0')		AS '[2011.12�������վ�]'  
FROM	
		T01_Customer A 	
		LEFT JOIN 	##MyTempTable1								--����˻�����ʱ��
		ON 			A.Cust_Id = ##MyTempTable1.Cust_Id
		LEFT JOIN	##MyTempTable2								--2011.12.31�յĴ�����
		ON			A.Cust_Id = ##MyTempTable2.�ͻ���
		LEFT JOIN	##MyTempTable3								--2011.12������վ�
		ON			A.Cust_Id = ##MyTempTable3.�ͻ���
		LEFT JOIN 	T01_Loan_Iou D
		ON 			(A.Cust_Id = D.Cust_Id)
		LEFT JOIN	##MyTempTable4								--2011.12.31�յĴ������
		ON			A.Cust_Id = ##MyTempTable4.�ͻ���
		LEFT JOIN	##MyTempTable5								--2011.12�������վ�
		ON			A.Cust_Id = ##MyTempTable5.�ͻ���
GROUP BY 
		A.Cust_Id
		,##MyTempTable1.����˺Ÿ���
        ,##MyTempTable2.���
		,##MyTempTable3.[2011��12�µ����վ�]
		,##MyTempTable4.�����˺�
		,##MyTempTable5.[2011��12�µ����վ�];

--������������������������������������������������������������ DAY 3������������������������������������������������������������
/** 1��	ͳ�����пͻ���2011.12.31�յĴ�������������������������������������
��ע������������� = 2011.12.31�յĴ�����-2011.12.30�յĴ�����
      ����������� = 2011.12.31�յĴ�����-2011.11.30�յĴ�����
      ����������� = 2011.12.31�յĴ�����-2010.12.31�յĴ�����
   ֻ��2011.12.31������ڿ���д������������Ҫͨ��2011.12.31������������ɡ�  **/

--------------------------------------�ܱ�---------------------------------------------------------
SELECT 
		MAIN.Cust_Id																				AS '�ͻ���'
		,MAIN.Deposit_Acct_No																		AS '����˺�'
		,ISNULL(##MyTempTable2.���,'0')															AS '2011.12.31���'
		,ISNULL(##MyTempTable6.[2011.12.30���],'0')-ISNULL(##MyTempTable6.[2011.12.30���],'0')	AS '�����������'
		,ISNULL(##MyTempTable7.[2011.11.30���],'0')-ISNULL(##MyTempTable7.[2011.11.30���],'0')	AS '�����������'
		,ISNULL(##MyTempTable8.[2010.12.31���],'0')-ISNULL(##MyTempTable8.[2010.12.31���],'0')	AS '�����������'
FROM	T01_Deposit_Acct MAIN
		LEFT JOIN	##MyTempTable2
		ON			MAIN.Deposit_Acct_No = ##MyTempTable2.����˺�
					AND MAIN.Cust_Id = ##MyTempTable2.�ͻ���
		LEFT JOIN	##MyTempTable6
		ON			MAIN.Deposit_Acct_No = ##MyTempTable6.����˺�
					AND MAIN.Cust_Id = ##MyTempTable6.�ͻ���
		LEFT JOIN	##MyTempTable7
		ON			MAIN.Deposit_Acct_No = ##MyTempTable7.����˺�
					AND MAIN.Cust_Id = ##MyTempTable7.�ͻ���
		LEFT JOIN	##MyTempTable8
		ON			MAIN.Deposit_Acct_No = ##MyTempTable8.����˺�
					AND MAIN.Cust_Id = ##MyTempTable8.�ͻ���
GROUP BY	
		MAIN.Cust_Id
		,MAIN.Deposit_Acct_No
		,##MyTempTable2.���
		,##MyTempTable6.[2011.12.30���]
		,##MyTempTable7.[2011.11.30���]
		,##MyTempTable8.[2010.12.31���];

--2��	ͳ������2011�������վ�����100�Ŀͻ��š��ͻ����ơ�����˻�����2011�����վ�

--------------------------------------�ܱ�---------------------------------------------------------
SELECT
		T01_Customer.Cust_Id						AS '�ͻ���'
		,ISNULL(##MyTempTable1.����˺Ÿ���,'0')	AS '����˺Ÿ���'
		,ISNULL(##MyTempTable9.[2011�����վ�],'0')	AS '2011�����վ�'
FROM	
		T01_Customer
		LEFT JOIN	##MyTempTable1
		ON			T01_Customer.Cust_Id = ##MyTempTable1.Cust_Id
		LEFT JOIN	##MyTempTable9
		ON			T01_Customer.Cust_Id = ##MyTempTable9.�ͻ���
WHERE	##MyTempTable9.[2011�����վ�] > 100
GROUP BY
		T01_Customer.Cust_Id
		,##MyTempTable1.����˺Ÿ���
		,##MyTempTable9.[2011�����վ�];

--������������������������������������������������������������ DAY 4������������������������������������������������������������
--1��	ͳ������2011�������վ���2011��������վ�������100�Ŀͻ��š�����˻�����
--		2011�������վ��������˻�����2011��������վ�

--------------------------------------�ܱ�---------------------------------------------------------
SELECT
		T01_Customer.Cust_Id																AS '�ͻ���'
		,ISNULL(##MyTempTable1.����˺Ÿ���,'0')											AS '����˻���'
		,ISNULL(##MyTempTable9.[2011�����վ�],'0')											AS '2011�������վ�'
		,COUNT(D.IOU_No) 																	AS '�����˻���'
		,ISNULL(##MyTempTable10.[2011��������վ�],'0')										AS '2011��������վ�'
FROM		
		T01_Customer
		LEFT JOIN	##MyTempTable1
		ON			T01_Customer.Cust_Id = ##MyTempTable1.Cust_Id
		LEFT JOIN	##MyTempTable9
		ON			T01_Customer.Cust_Id = ##MyTempTable9.�ͻ���
		LEFT JOIN 	T01_Loan_Iou D
		ON 			(T01_Customer.Cust_Id = D.Cust_Id)
		LEFT JOIN	##MyTempTable10
		ON			T01_Customer.Cust_Id = ##MyTempTable10.�ͻ���
WHERE	
		##MyTempTable9.[2011�����վ�] > 100
		AND ##MyTempTable10.[2011��������վ�] > 100
GROUP BY	
		T01_Customer.Cust_Id	
		,##MyTempTable1.����˺Ÿ���
		,##MyTempTable9.[2011�����վ�]
		,##MyTempTable10.[2011��������վ�];

/**2��	ͳ�����пͻ��Ŀͻ��š�
		����־���д���˻��Ŀͻ���Ϊ1��û����˻��Ŀͻ���Ϊ0����
		�����־���д����ݵĿͻ���Ϊ1��û�����ݵĿͻ���Ϊ0����
		����������ࣨ2011�������վ�>=10000��Ϊ���ʡ�2011�������վ�>=1000<10000
		��Ϊ���á�2011�������վ�<1000��Ϊ��ͨ����
		2011�������վ���
		�����������ࣨ2011��������վ�>=10000��Ϊ���ʡ�2011��������վ�>=1000<10000
		��Ϊ���á�2011��������վ�<1000��Ϊ��ͨ����
		2011��������վ�				**/

--------------------------------------�ܱ�---------------------------------------------------------
SELECT	
		TB1.Cust_Id
		,ISNULL(##MyTempTable11.����־,'0')																AS '����־'
		,ISNULL(##MyTempTable12.�����־,'0')																AS '�����־'
		,ISNULL(##MyTempTable9.[2011�����վ�],'0')															AS '2011�������վ�'
		,(CASE	WHEN	ISNULL(##MyTempTable9.[2011�����վ�],'0') >= 10000 THEN '����' 
				WHEN	ISNULL(##MyTempTable9.[2011�����վ�],'0') >= 1000
				AND		ISNULL(##MyTempTable9.[2011�����վ�],'0') < 10000  THEN '����' 
				ELSE															'��ͨ'	
				END)																						AS '�����������'
		,ISNULL(##MyTempTable10.[2011��������վ�],'0')														AS '2011��������վ�'
		,(CASE	WHEN	ISNULL(##MyTempTable10.[2011��������վ�],'0') >= 10000 THEN '����' 
				WHEN	ISNULL(##MyTempTable10.[2011��������վ�],'0') >= 1000
				AND		ISNULL(##MyTempTable10.[2011��������վ�],'0') < 10000  THEN '����' 
				ELSE																 '��ͨ'	
				END)																						AS '������������'
FROM	T01_Customer TB1
		LEFT JOIN	##MyTempTable11
		ON			TB1.Cust_Id = ##MyTempTable11.�ͻ���
		LEFT JOIN	##MyTempTable12
		ON			TB1.Cust_Id = ##MyTempTable12.�ͻ���
		LEFT JOIN	##MyTempTable9
		ON			TB1.Cust_Id = ##MyTempTable9.�ͻ���
		LEFT JOIN	##MyTempTable10
		ON			TB1.Cust_Id = ##MyTempTable10.�ͻ���
GROUP BY
		TB1.Cust_Id
		,##MyTempTable11.����־
		,##MyTempTable12.�����־
		,##MyTempTable9.[2011�����վ�]
		,##MyTempTable10.[2011��������վ�]


--������������������������������������������������������������ DAY 5������������������������������������������������������������
/**
2��	���ݿͻ��������Ϣ���¼���ͳ��
	ÿ���ͻ�2017��Ŀͻ��š�
	�����˻������ͻ����ж��ٸ��˻��н��׾��Ƕ��٣���
	�����н��׵����������2017����5���й����ף����н�������Ϊ5����
	�����н��������������2017��1��3��5���н��ף����н���������Ϊ3����

	�����½����ܽ�����ͳ�ƽ��׽���������½��׽���
	����½��׽����·ݣ�����ͳ�ƽ��׽���Ž��׽�������·ݣ���

	���ܽ��׽�
	�꽻�׽�����������ͻ�����������ܽ��׽��Ϊ0���� ������������������Ϊ9999����
	���������ѡ�
	�������������������ͻ������������������Ϊ0���򲻲���������������Ϊ9999��**/


--------------------------------------�ܱ�---------------------------------------------------------
SELECT
		T01_Customer.Cust_Id
		,ISNULL(##MyTempTable13.�����˻���,'0')											AS '�����˻���'
		,ISNULL(##MyTempTable13.��������,'0')											AS '��������'
		,ISNULL(##MyTempTable13.��������,'0')											AS '��������'
		,ISNULL(##MyTempTable16.�½����ܽ��,'0')										AS '�����½��׽��'
		,ISNULL(##MyTempTable16.�·�,'0')												AS '����½��׽����·�'
		,ISNULL(##MyTempTable14.�ͻ����ܽ��׽��,'0')									AS '���ܽ��׽��'
		,ISNULL(##MyTempTable14.����,'9999')											AS '����'
		,ISNULL(##MyTempTable15.����������,'0')											AS '����������'
		,ISNULL(##MyTempTable15.����,'9999')											AS '����'
FROM		
		T01_Customer
		LEFT JOIN	##MyTempTable13
		ON			T01_Customer.Cust_Id = ##MyTempTable13.�ͻ���
		LEFT JOIN	##MyTempTable14
		ON			T01_Customer.Cust_Id = ##MyTempTable14.�ͻ���
		LEFT JOIN	##MyTempTable15
		ON			T01_Customer.Cust_Id = ##MyTempTable15.�ͻ���
		LEFT JOIN   ##MyTempTable16
		ON			T01_Customer.Cust_Id = ##MyTempTable16.�ͻ���;

/**	
���̣�			
�����½����ܽ�����ͳ�ƽ��׽���������½��׽���
����½��׽����·ݣ�����ͳ�ƽ��׽���Ž��׽�������·ݣ���
**/


--step��1
----��ѯ��ÿ���˺ŵ�����׽����·�  һ���ͻ���Ӧ����˺ţ����� �ͻ���ÿ���ͻ���ͬ�˺ŵĽ��׽������ѡ���׽������һ��
			SELECT	T2.�˺�													AS '�˺�'
					,T2.�½����ܽ��										AS '�½����ܽ��'
					,T2.�·�												AS '�·�'
			FROM
				(
				-------------------����˳��1�����׽�2���½��ױ�����3���·� �Ӵ�С-----------------
				SELECT	RANK() OVER(PARTITION BY T1.�˺� 
								ORDER BY 
								T1.�½����ܽ��		DESC
								,T1.�˺��½��ױ���	DESC
								,T1.�·�			DESC
								) id
								,T1.*
				FROM
						(
						SELECT	
								Event_Number								AS '�˺�'
								,SUM(Trade_Amount)							AS '�½����ܽ��'
								,COUNT(Event_Id)							AS '�˺��½��ױ���'
								,MONTH(T01_EventsList.Trade_Date)			AS '�·�'
						FROM	
								T01_EventsList
						GROUP BY 
								Event_Number
								,MONTH(T01_EventsList.Trade_Date)
						)T1
		
				) T2
			WHERE T2.id=1;
--step��2
---��ѯ��ÿ���ͻ�������׽����˻����½����ܽ��·�-------------------------------------------------------
		SELECT *
		FROM
		(
		SELECT	
			RANK() OVER(PARTITION BY T01_Deposit_Acct.Cust_Id 
									ORDER BY 
									T3.�½����ܽ��		DESC
									,T3.�·�			DESC
									) id
			,T01_Deposit_Acct.Cust_Id												AS '�ͻ���'
			,T01_Deposit_Acct.Deposit_Acct_No										AS '�˺�'
			,ISNULL(T3.�½����ܽ��,'0')											AS '�½����ܽ��'
			,ISNULL(T3.�·�,'0')													AS '�·�'
		FROM
			T01_Deposit_Acct
			LEFT JOIN
			(
			----��ѯ��ÿ���˺ŵ�����׽����·�  һ���ͻ���Ӧ����˺ţ����� �ͻ���ÿ���ͻ���ͬ�˺ŵĽ��׽������ѡ���׽������һ��
			SELECT	T2.�˺�													AS '�˺�'
					,T2.�½����ܽ��										AS '�½����ܽ��'
					,T2.�·�												AS '�·�'
			FROM
				(
				-------------------����˳��1�����׽�2���½��ױ�����3���·� �Ӵ�С-----------------
				SELECT	RANK() OVER(PARTITION BY T1.�˺� 
								ORDER BY 
								T1.�½����ܽ��		DESC
								,T1.�˺��½��ױ���	DESC
								,T1.�·�			DESC
								) id
								,T1.*
				FROM
						(
						SELECT	
								Event_Number								AS '�˺�'
								,SUM(Trade_Amount)							AS '�½����ܽ��'
								,COUNT(Event_Id)							AS '�˺��½��ױ���'
								,MONTH(T01_EventsList.Trade_Date)			AS '�·�'
						FROM	
								T01_EventsList
						GROUP BY 
								Event_Number
								,MONTH(T01_EventsList.Trade_Date)
						)T1
		
				) T2
			WHERE T2.id=1
			) T3
			ON		T3.�˺� = T01_Deposit_Acct.Deposit_Acct_No
		)T4
		WHERE	T4.id = 1;

