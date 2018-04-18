--SQL优化

--所有用到的临时表
-------------------------------临时表：存款账户数--------------------------------------------------
SELECT	* 
INTO	##MyTempTable1
FROM
		(
			SELECT	Cust_Id
					,COUNT(Deposit_Acct_No)	AS '存款账号个数'
			FROM	
					T01_Deposit_Acct 
			GROUP BY	
					Cust_Id) AS Count_Deposit_Acct_No;
-------------------------------临时表：2011.12.31日的存款余额--------------------------------------
SELECT	*
INTO	##MyTempTable2
FROM	(
		SELECT   
				Cust_Id						AS '客户号'
				,SUM(bal)					AS '余额'
				,Deposit_Acct_No			AS '存款账号'
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
-------------------------------临时表：2011.12存款月日均-------------------------------------------
SELECT	*
INTO	##MyTempTable3
FROM	(
		SELECT  T01_Deposit_Acct.Cust_Id			AS '客户号'
				,T01_Deposit_Acct.Deposit_Acct_No	AS '存款账号'
				,T01_Deposit_Acct.Open_Org_Id		AS '开户机构'
				,T01_Deposit_Acct.Open_Dt			AS '开户日期'
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
					)/31							AS '2011年12月的月日均'
		FROM	T01_Deposit_Acct,T01_Agmt_Bal_H
		WHERE   T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
				AND T01_Agmt_Bal_H.Start_Dt < '2012/01/01'
				AND T01_Agmt_Bal_H.End_Dt >= '2011/12/01'
		GROUP BY T01_Deposit_Acct.Cust_Id 
				,T01_Deposit_Acct.Deposit_Acct_No 
				,T01_Deposit_Acct.Open_Org_Id 
				,T01_Deposit_Acct.Open_Dt
				) AS AvgBal_On_12;
-------------------------------临时表：2011.12.31日的贷款余额--------------------------------------
SELECT	*
INTO	##MyTempTable4
FROM	(
		SELECT
				T01_Loan_Iou.Cust_Id	AS '客户号'
				,T01_Loan_Iou.IOU_No    AS '贷款账号'
				,T01_Agmt_Bal_H.Bal     AS '2011.12.31贷款余额'
		FROM
				T01_Agmt_Bal_H
				,T01_Loan_Iou
		WHERE
				T01_Agmt_Bal_H.Agmt_Id = T01_Loan_Iou.IOU_No
				AND T01_Agmt_Bal_H.Start_Dt <= '2011/12/31'
				AND T01_Agmt_Bal_H.End_Dt > '2011/12/31'			
		) AS D_Bal_On_1231;
-------------------------------临时表：2011.12贷款月日均-------------------------------------------
SELECT	*
INTO	##MyTempTable5
FROM	(
		SELECT  
				T01_Loan_Iou.Cust_Id			AS '客户号'
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
					)/31							AS '2011年12月的月日均'
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

-------------------------------临时表：2011.12.31日的上日存款余额--------------------------------------
SELECT	*
INTO	##MyTempTable6
FROM	(
		SELECT  
				T01_Deposit_Acct.Cust_Id				AS '客户号'
				,T01_Deposit_Acct.Deposit_Acct_No		AS '存款账号'
				,T01_Agmt_Bal_H.Bal						AS '2011.12.30余额'
		FROM	
				T01_Deposit_Acct
				,T01_Agmt_Bal_H
		WHERE   T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
				AND T01_Agmt_Bal_H.Start_Dt <=  DATEADD(DAY,-1,'2011/12/31') 
				AND T01_Agmt_Bal_H.End_Dt > DATEADD(DAY,-1,'2011/12/31') 
				AND T01_Agmt_Bal_H.Agmt_Type_Cd = 01					
		)	AS TABEL1;
-------------------------------临时表：2011.12.31日的上月存款余额--------------------------------------
SELECT	*
INTO	##MyTempTable7
FROM	(
		SELECT  
				T01_Deposit_Acct.Cust_Id				AS '客户号'
				,T01_Deposit_Acct.Deposit_Acct_No		AS '存款账号'
				,T01_Agmt_Bal_H.Bal						AS '2011.11.30余额'
		FROM	
				T01_Deposit_Acct
				,T01_Agmt_Bal_H
		WHERE   T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
				AND T01_Agmt_Bal_H.Start_Dt <= DATEADD(MONTH,-1,'2011/12/31')
				AND T01_Agmt_Bal_H.End_Dt > DATEADD(MONTH,-1,'2011/12/31')
				AND T01_Agmt_Bal_H.Agmt_Type_Cd = 01					
		)	AS TABEL2;
-------------------------------临时表：2011.12.31日的上年存款余额--------------------------------------
SELECT	*
INTO	##MyTempTable8
FROM	(
		SELECT  
				T01_Deposit_Acct.Cust_Id				AS '客户号'
				,T01_Deposit_Acct.Deposit_Acct_No		AS '存款账号'
				,T01_Agmt_Bal_H.Bal						AS '2010.12.31余额'
		FROM	
				T01_Deposit_Acct
				,T01_Agmt_Bal_H
		WHERE   
				T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
				AND T01_Agmt_Bal_H.Start_Dt <= DATEADD(YEAR,-1,'2011/12/31')
				AND T01_Agmt_Bal_H.End_Dt > DATEADD(YEAR,-1,'2011/12/31')
				AND T01_Agmt_Bal_H.Agmt_Type_Cd = 01			
		)	AS TABEL3;

-------------------------------临时表：2011年存款年日均-----------------------------------------------
SELECT	*
INTO	##MyTempTable9
FROM	(
		SELECT  
				T01_Deposit_Acct.Cust_Id					AS '客户号'
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
					)/365							AS '2011年年日均'
		FROM	
				T01_Deposit_Acct,T01_Agmt_Bal_H
		WHERE   
				T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
				AND T01_Agmt_Bal_H.Start_Dt < '2012/01/01'
				AND T01_Agmt_Bal_H.End_Dt	>= '2011/01/01'
		GROUP BY 
				T01_Deposit_Acct.Cust_Id 
		) TABLE3;

-------------------------------临时表：2011年贷款年日均-----------------------------------------------
SELECT	*	
INTO	##MyTempTable10
FROM	(
		SELECT  
				T01_Loan_Iou.Cust_Id					AS '客户号'
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
					)/365							AS '2011年贷款年日均'
			FROM	
					T01_Loan_Iou,T01_Agmt_Bal_H
			WHERE   
					T01_Loan_Iou.IOU_No = T01_Agmt_Bal_H.Agmt_Id 
					AND T01_Agmt_Bal_H.Start_Dt < '2012/01/01'
					AND T01_Agmt_Bal_H.End_Dt	>= '2011/01/01'
			GROUP BY 
					T01_Loan_Iou.Cust_Id 
			) AS TABLE5;

-------------------------------临时表：存款标志-----------------------------------------------
SELECT	*
INTO	##MyTempTable11
FROM	(
		SELECT	
				T01_Deposit_Acct.Cust_Id													AS '客户号'
				,CASE WHEN T01_Deposit_Acct.Deposit_Acct_No IS NOT NULL THEN 1 ELSE 0 END		AS '存款标志'
		FROM	T01_Deposit_Acct 
		) TABLE11;
-------------------------------临时表：贷款标志-----------------------------------------------
SELECT	*
INTO	##MyTempTable12
FROM	(
		SELECT	
				T01_Loan_Iou.Cust_Id														AS '客户号'
				,CASE WHEN T01_Loan_Iou.IOU_No IS NOT NULL THEN 1 ELSE 0 END				AS '贷款标志'
		FROM	T01_Loan_Iou
		) TABLE12;

-------------------------------临时表：存款账户数,交易天数，交易月数-----------------------------------------------
SELECT	*
INTO	##MyTempTable13
FROM	(
		SELECT 
				T01_Deposit_Acct.Cust_Id									AS '客户号'
				,COUNT(DISTINCT Event_Number)								AS '交易账户数'
				,COUNT(DISTINCT E1.Trade_Date)								AS '交易天数'
				,COUNT(DISTINCT MONTH(E1.Trade_Date))						AS '交易月数'
		FROM 
				T01_Deposit_Acct
				LEFT JOIN
						T01_EventsList E1
				ON	(T01_Deposit_Acct.Deposit_Acct_No = E1.Event_Number)
		GROUP BY
				T01_Deposit_Acct.Cust_Id
		) AS TB501;
-------------------------------临时表：年总交易金额、年交易金额排名-----------------------------------------------

SELECT	*
INTO	##MyTempTable14
FROM	(
		SELECT 
				T01_Deposit_Acct.Cust_Id														AS '客户号'
				,ISNULL(SUM(TABLE4.年总交易金额),'0')											AS '客户年总交易金额'
				,CASE	WHEN SUM(TABLE4.年总交易金额) = '0'		THEN '9999'
						WHEN SUM(TABLE4.年总交易金额) IS NULL	THEN '9999'
						ELSE RANK()over(order by SUM(TABLE4.年总交易金额)DESC)
						END																		AS '排名'	
		FROM
				T01_Deposit_Acct
				LEFT JOIN
				(
					SELECT 
							Event_Number														AS '账号'
							,SUM(Trade_Amount)													AS '年总交易金额'			 
					FROM 
							T01_EventsList
					GROUP BY
							Event_Number
				)	TABLE4
				ON (TABLE4.账号 = T01_Deposit_Acct.Deposit_Acct_No)
		GROUP BY
				T01_Deposit_Acct.Cust_Id
		) AS TB503;
-------------------------------临时表： 年总手续费、年总手续费排名-----------------------------------------------
SELECT	*
INTO	##MyTempTable15
FROM	(
		SELECT 
				T01_Deposit_Acct.Cust_Id														AS '客户号'
				,ISNULL(SUM(TABLE_FEES.年总手续费),'0')											AS '年总手续费'
				,CASE	WHEN SUM(TABLE_FEES.年总手续费) = '0'		THEN '9999'
						WHEN SUM(TABLE_FEES.年总手续费) IS NULL	THEN '9999'
						ELSE RANK()over(order by SUM(TABLE_FEES.年总手续费)DESC)
						END																		AS '排名'	
		FROM
				T01_Deposit_Acct
				LEFT JOIN
				(
				SELECT 
						Event_Number														AS '账号'
						,SUM(Fees)															AS '年总手续费'			 
				FROM 
						T01_EventsList
				GROUP BY
						Event_Number

				)	TABLE_FEES
				ON (TABLE_FEES.账号 = T01_Deposit_Acct.Deposit_Acct_No)
		GROUP BY
				T01_Deposit_Acct.Cust_Id
		) AS TB504;
-------------------------------临时表： 每个客户的最大交易金额，月份-----------------------------------------------
SELECT  *
INTO	##MyTempTable16
FROM	(
		---查询到每个客户的最大交易金额的账户，月交易总金额，月份-------------------------------------------------------
		SELECT *
		FROM
		(
		SELECT	
			RANK() OVER(PARTITION BY T01_Deposit_Acct.Cust_Id 
									ORDER BY 
									T3.月交易总金额		DESC
									,T3.月份			DESC
									) id
			,T01_Deposit_Acct.Cust_Id												AS '客户号'
			,T01_Deposit_Acct.Deposit_Acct_No										AS '账号'
			,ISNULL(T3.月交易总金额,'0')											AS '月交易总金额'
			,ISNULL(T3.月份,'0')													AS '月份'
		FROM
			T01_Deposit_Acct
			LEFT JOIN
			(
			----查询到每个账号的最大交易金额和月份  一个客户对应多个账号，根据 客户对每个客户不同账号的交易金额排序，选交易金额最大的一个
			SELECT	T2.账号													AS '账号'
					,T2.月交易总金额										AS '月交易总金额'
					,T2.月份												AS '月份'
			FROM
				(
				-------------------排名顺序，1、交易金额，2、月交易笔数，3、月份 从大到小-----------------
				SELECT	RANK() OVER(PARTITION BY T1.账号 
								ORDER BY 
								T1.月交易总金额		DESC
								,T1.账号月交易笔数	DESC
								,T1.月份			DESC
								) id
								,T1.*
				FROM
						(
						SELECT	
								Event_Number								AS '账号'
								,SUM(Trade_Amount)							AS '月交易总金额'
								,COUNT(Event_Id)							AS '账号月交易笔数'
								,MONTH(T01_EventsList.Trade_Date)			AS '月份'
						FROM	
								T01_EventsList
						GROUP BY 
								Event_Number
								,MONTH(T01_EventsList.Trade_Date)
						)T1
		
				) T2
			WHERE T2.id=1
			) T3
			ON		T3.账号 = T01_Deposit_Acct.Deposit_Acct_No
		)T4
		WHERE	T4.id = 1
		)AS TB502;

--……………………………………………………………………………… DAY 2………………………………………………………………………………

-- 3、	统计所有客户的客户号、存款账户数、2011.12.31日的存款余额、
--2011.12存款月日均、贷款账户数、2011.12.31日的贷款余额、2011.12贷款月日均

--------------------------------------总表---------------------------------------------------------
SELECT  DISTINCT 
		A.Cust_Id 												AS '客户号'
		,ISNULL(##MyTempTable1.存款账号个数,'0')				AS '存款账户数'
		,ISNULL(##MyTempTable2.余额,'0')						AS '[2011.12.31存款余额]'
		,ISNULL(##MyTempTable3.[2011年12月的月日均],'0')		AS '[2011.12存款月日均]' 
		,COUNT(D.IOU_No) 										AS '贷款账户数'
		,ISNULL(##MyTempTable4.贷款账号,'0')					AS '[2011.12.31贷款余额]'
		,ISNULL(##MyTempTable5.[2011年12月的月日均],'0')		AS '[2011.12贷款月日均]'  
FROM	
		T01_Customer A 	
		LEFT JOIN 	##MyTempTable1								--存款账户数临时表
		ON 			A.Cust_Id = ##MyTempTable1.Cust_Id
		LEFT JOIN	##MyTempTable2								--2011.12.31日的存款余额
		ON			A.Cust_Id = ##MyTempTable2.客户号
		LEFT JOIN	##MyTempTable3								--2011.12存款月日均
		ON			A.Cust_Id = ##MyTempTable3.客户号
		LEFT JOIN 	T01_Loan_Iou D
		ON 			(A.Cust_Id = D.Cust_Id)
		LEFT JOIN	##MyTempTable4								--2011.12.31日的贷款余额
		ON			A.Cust_Id = ##MyTempTable4.客户号
		LEFT JOIN	##MyTempTable5								--2011.12贷款月日均
		ON			A.Cust_Id = ##MyTempTable5.客户号
GROUP BY 
		A.Cust_Id
		,##MyTempTable1.存款账号个数
        ,##MyTempTable2.余额
		,##MyTempTable3.[2011年12月的月日均]
		,##MyTempTable4.贷款账号
		,##MyTempTable5.[2011年12月的月日均];

--……………………………………………………………………………… DAY 3………………………………………………………………………………
/** 1、	统计所有客户的2011.12.31日的存款余额、存款比上日余额、存款比上月余额、、存款比上年余额
备注：存款比上日余额 = 2011.12.31日的存款余额-2011.12.30日的存款余额
      存款比上月余额 = 2011.12.31日的存款余额-2011.11.30日的存款余额
      存款比上年余额 = 2011.12.31日的存款余额-2010.12.31日的存款余额
   只有2011.12.31这个日期可以写死，其他日期要通过2011.12.31这个日期来生成。  **/

--------------------------------------总表---------------------------------------------------------
SELECT 
		MAIN.Cust_Id																				AS '客户号'
		,MAIN.Deposit_Acct_No																		AS '存款账号'
		,ISNULL(##MyTempTable2.余额,'0')															AS '2011.12.31余额'
		,ISNULL(##MyTempTable6.[2011.12.30余额],'0')-ISNULL(##MyTempTable6.[2011.12.30余额],'0')	AS '存款比上日余额'
		,ISNULL(##MyTempTable7.[2011.11.30余额],'0')-ISNULL(##MyTempTable7.[2011.11.30余额],'0')	AS '存款比上月余额'
		,ISNULL(##MyTempTable8.[2010.12.31余额],'0')-ISNULL(##MyTempTable8.[2010.12.31余额],'0')	AS '存款比上年余额'
FROM	T01_Deposit_Acct MAIN
		LEFT JOIN	##MyTempTable2
		ON			MAIN.Deposit_Acct_No = ##MyTempTable2.存款账号
					AND MAIN.Cust_Id = ##MyTempTable2.客户号
		LEFT JOIN	##MyTempTable6
		ON			MAIN.Deposit_Acct_No = ##MyTempTable6.存款账号
					AND MAIN.Cust_Id = ##MyTempTable6.客户号
		LEFT JOIN	##MyTempTable7
		ON			MAIN.Deposit_Acct_No = ##MyTempTable7.存款账号
					AND MAIN.Cust_Id = ##MyTempTable7.客户号
		LEFT JOIN	##MyTempTable8
		ON			MAIN.Deposit_Acct_No = ##MyTempTable8.存款账号
					AND MAIN.Cust_Id = ##MyTempTable8.客户号
GROUP BY	
		MAIN.Cust_Id
		,MAIN.Deposit_Acct_No
		,##MyTempTable2.余额
		,##MyTempTable6.[2011.12.30余额]
		,##MyTempTable7.[2011.11.30余额]
		,##MyTempTable8.[2010.12.31余额];

--2、	统计所有2011年存款年日均大于100的客户号、客户名称、存款账户数、2011年年日均

--------------------------------------总表---------------------------------------------------------
SELECT
		T01_Customer.Cust_Id						AS '客户号'
		,ISNULL(##MyTempTable1.存款账号个数,'0')	AS '存款账号个数'
		,ISNULL(##MyTempTable9.[2011年年日均],'0')	AS '2011年年日均'
FROM	
		T01_Customer
		LEFT JOIN	##MyTempTable1
		ON			T01_Customer.Cust_Id = ##MyTempTable1.Cust_Id
		LEFT JOIN	##MyTempTable9
		ON			T01_Customer.Cust_Id = ##MyTempTable9.客户号
WHERE	##MyTempTable9.[2011年年日均] > 100
GROUP BY
		T01_Customer.Cust_Id
		,##MyTempTable1.存款账号个数
		,##MyTempTable9.[2011年年日均];

--……………………………………………………………………………… DAY 4………………………………………………………………………………
--1、	统计所有2011年存款年日均和2011年贷款年日均都大于100的客户号、存款账户数、
--		2011年存款年日均、贷款账户数、2011年贷款年日均

--------------------------------------总表---------------------------------------------------------
SELECT
		T01_Customer.Cust_Id																AS '客户号'
		,ISNULL(##MyTempTable1.存款账号个数,'0')											AS '存款账户数'
		,ISNULL(##MyTempTable9.[2011年年日均],'0')											AS '2011年存款年日均'
		,COUNT(D.IOU_No) 																	AS '贷款账户数'
		,ISNULL(##MyTempTable10.[2011年贷款年日均],'0')										AS '2011年贷款年日均'
FROM		
		T01_Customer
		LEFT JOIN	##MyTempTable1
		ON			T01_Customer.Cust_Id = ##MyTempTable1.Cust_Id
		LEFT JOIN	##MyTempTable9
		ON			T01_Customer.Cust_Id = ##MyTempTable9.客户号
		LEFT JOIN 	T01_Loan_Iou D
		ON 			(T01_Customer.Cust_Id = D.Cust_Id)
		LEFT JOIN	##MyTempTable10
		ON			T01_Customer.Cust_Id = ##MyTempTable10.客户号
WHERE	
		##MyTempTable9.[2011年年日均] > 100
		AND ##MyTempTable10.[2011年贷款年日均] > 100
GROUP BY	
		T01_Customer.Cust_Id	
		,##MyTempTable1.存款账号个数
		,##MyTempTable9.[2011年年日均]
		,##MyTempTable10.[2011年贷款年日均];

/**2、	统计所有客户的客户号、
		存款标志（有存款账户的客户置为1、没存款账户的客户置为0）、
		贷款标志（有贷款借据的客户置为1、没贷款借据的客户置为0）、
		存款质量分类（2011年存款年日均>=10000置为优质、2011年存款年日均>=1000<10000
		置为良好、2011年存款年日均<1000置为普通）、
		2011年存款年日均、
		贷款质量分类（2011年贷款年日均>=10000置为优质、2011年贷款年日均>=1000<10000
		置为良好、2011年贷款年日均<1000置为普通）、
		2011年贷款年日均				**/

--------------------------------------总表---------------------------------------------------------
SELECT	
		TB1.Cust_Id
		,ISNULL(##MyTempTable11.存款标志,'0')																AS '存款标志'
		,ISNULL(##MyTempTable12.贷款标志,'0')																AS '贷款标志'
		,ISNULL(##MyTempTable9.[2011年年日均],'0')															AS '2011年存款年日均'
		,(CASE	WHEN	ISNULL(##MyTempTable9.[2011年年日均],'0') >= 10000 THEN '优质' 
				WHEN	ISNULL(##MyTempTable9.[2011年年日均],'0') >= 1000
				AND		ISNULL(##MyTempTable9.[2011年年日均],'0') < 10000  THEN '良好' 
				ELSE															'普通'	
				END)																						AS '存款质量分类'
		,ISNULL(##MyTempTable10.[2011年贷款年日均],'0')														AS '2011年贷款年日均'
		,(CASE	WHEN	ISNULL(##MyTempTable10.[2011年贷款年日均],'0') >= 10000 THEN '优质' 
				WHEN	ISNULL(##MyTempTable10.[2011年贷款年日均],'0') >= 1000
				AND		ISNULL(##MyTempTable10.[2011年贷款年日均],'0') < 10000  THEN '良好' 
				ELSE																 '普通'	
				END)																						AS '贷款质量分类'
FROM	T01_Customer TB1
		LEFT JOIN	##MyTempTable11
		ON			TB1.Cust_Id = ##MyTempTable11.客户号
		LEFT JOIN	##MyTempTable12
		ON			TB1.Cust_Id = ##MyTempTable12.客户号
		LEFT JOIN	##MyTempTable9
		ON			TB1.Cust_Id = ##MyTempTable9.客户号
		LEFT JOIN	##MyTempTable10
		ON			TB1.Cust_Id = ##MyTempTable10.客户号
GROUP BY
		TB1.Cust_Id
		,##MyTempTable11.存款标志
		,##MyTempTable12.贷款标志
		,##MyTempTable9.[2011年年日均]
		,##MyTempTable10.[2011年贷款年日均]


--……………………………………………………………………………… DAY 5………………………………………………………………………………
/**
2、	根据客户表、存款信息表、事件表，统计
	每个客户2017年的客户号、
	交易账户数（客户下有多少个账户有交易就是多少）、
	当年有交易的天数（如果2017年有5天有过交易，则有交易天数为5）、
	当年有交易总月数（如果2017的1、3、5月有交易，则有交易总月数为3）、

	最大的月交易总金额（按月统计交易金额，存放最大的月交易金额）、
	最大月交易金额的月份（按月统计交易金额，存放交易金额最大的月份）、

	年总交易金额、
	年交易金额排名（按客户排名，如果总交易金额为0，则 不参与排名，排名置为9999）、
	年总手续费、
	年总手续费排名（按客户排名，如果总手续费为0，则不参与排名，排名置为9999）**/


--------------------------------------总表---------------------------------------------------------
SELECT
		T01_Customer.Cust_Id
		,ISNULL(##MyTempTable13.交易账户数,'0')											AS '交易账户数'
		,ISNULL(##MyTempTable13.交易天数,'0')											AS '交易天数'
		,ISNULL(##MyTempTable13.交易月数,'0')											AS '交易月数'
		,ISNULL(##MyTempTable16.月交易总金额,'0')										AS '最大的月交易金额'
		,ISNULL(##MyTempTable16.月份,'0')												AS '最大月交易金额的月份'
		,ISNULL(##MyTempTable14.客户年总交易金额,'0')									AS '年总交易金额'
		,ISNULL(##MyTempTable14.排名,'9999')											AS '排名'
		,ISNULL(##MyTempTable15.年总手续费,'0')											AS '年总手续费'
		,ISNULL(##MyTempTable15.排名,'9999')											AS '排名'
FROM		
		T01_Customer
		LEFT JOIN	##MyTempTable13
		ON			T01_Customer.Cust_Id = ##MyTempTable13.客户号
		LEFT JOIN	##MyTempTable14
		ON			T01_Customer.Cust_Id = ##MyTempTable14.客户号
		LEFT JOIN	##MyTempTable15
		ON			T01_Customer.Cust_Id = ##MyTempTable15.客户号
		LEFT JOIN   ##MyTempTable16
		ON			T01_Customer.Cust_Id = ##MyTempTable16.客户号;

/**	
过程：			
最大的月交易总金额（按月统计交易金额，存放最大的月交易金额）、
最大月交易金额的月份（按月统计交易金额，存放交易金额最大的月份）、
**/


--step：1
----查询到每个账号的最大交易金额和月份  一个客户对应多个账号，根据 客户对每个客户不同账号的交易金额排序，选交易金额最大的一个
			SELECT	T2.账号													AS '账号'
					,T2.月交易总金额										AS '月交易总金额'
					,T2.月份												AS '月份'
			FROM
				(
				-------------------排名顺序，1、交易金额，2、月交易笔数，3、月份 从大到小-----------------
				SELECT	RANK() OVER(PARTITION BY T1.账号 
								ORDER BY 
								T1.月交易总金额		DESC
								,T1.账号月交易笔数	DESC
								,T1.月份			DESC
								) id
								,T1.*
				FROM
						(
						SELECT	
								Event_Number								AS '账号'
								,SUM(Trade_Amount)							AS '月交易总金额'
								,COUNT(Event_Id)							AS '账号月交易笔数'
								,MONTH(T01_EventsList.Trade_Date)			AS '月份'
						FROM	
								T01_EventsList
						GROUP BY 
								Event_Number
								,MONTH(T01_EventsList.Trade_Date)
						)T1
		
				) T2
			WHERE T2.id=1;
--step：2
---查询到每个客户的最大交易金额的账户，月交易总金额，月份-------------------------------------------------------
		SELECT *
		FROM
		(
		SELECT	
			RANK() OVER(PARTITION BY T01_Deposit_Acct.Cust_Id 
									ORDER BY 
									T3.月交易总金额		DESC
									,T3.月份			DESC
									) id
			,T01_Deposit_Acct.Cust_Id												AS '客户号'
			,T01_Deposit_Acct.Deposit_Acct_No										AS '账号'
			,ISNULL(T3.月交易总金额,'0')											AS '月交易总金额'
			,ISNULL(T3.月份,'0')													AS '月份'
		FROM
			T01_Deposit_Acct
			LEFT JOIN
			(
			----查询到每个账号的最大交易金额和月份  一个客户对应多个账号，根据 客户对每个客户不同账号的交易金额排序，选交易金额最大的一个
			SELECT	T2.账号													AS '账号'
					,T2.月交易总金额										AS '月交易总金额'
					,T2.月份												AS '月份'
			FROM
				(
				-------------------排名顺序，1、交易金额，2、月交易笔数，3、月份 从大到小-----------------
				SELECT	RANK() OVER(PARTITION BY T1.账号 
								ORDER BY 
								T1.月交易总金额		DESC
								,T1.账号月交易笔数	DESC
								,T1.月份			DESC
								) id
								,T1.*
				FROM
						(
						SELECT	
								Event_Number								AS '账号'
								,SUM(Trade_Amount)							AS '月交易总金额'
								,COUNT(Event_Id)							AS '账号月交易笔数'
								,MONTH(T01_EventsList.Trade_Date)			AS '月份'
						FROM	
								T01_EventsList
						GROUP BY 
								Event_Number
								,MONTH(T01_EventsList.Trade_Date)
						)T1
		
				) T2
			WHERE T2.id=1
			) T3
			ON		T3.账号 = T01_Deposit_Acct.Deposit_Acct_No
		)T4
		WHERE	T4.id = 1;

