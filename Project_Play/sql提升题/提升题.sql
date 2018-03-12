
--……………………………………………………………………………… DAY 1………………………………………………………………………………
--修改日期格式

ALTER TABLE T01_Customer ALTER COLUMN Open_Dt DATE NOT NULL;
ALTER TABLE T01_Customer ALTER COLUMN Close_Dt DATE NOT NULL;

ALTER TABLE T01_Deposit_Acct ALTER COLUMN Open_Dt DATE NOT NULL;
ALTER TABLE T01_Deposit_Acct ALTER COLUMN Close_Dt DATE NOT NULL;

ALTER TABLE T01_Loan_Iou ALTER COLUMN Open_Dt DATE NOT NULL;
ALTER TABLE T01_Loan_Iou ALTER COLUMN Close_Dt DATE NOT NULL;

ALTER TABLE T01_Agmt_Bal_H ALTER COLUMN Start_Dt DATE NOT NULL;
ALTER TABLE T01_Agmt_Bal_H ALTER COLUMN End_Dt DATE NOT NULL;

--3、查询存款信息表、协议余额历史表，统计客户号1035797902下每个帐号在2011年12月的月日均（月日均等于当月每日余额累加除以当月天数）
--（展示字段：客户号、存款账号、开户机构、开户日期、2011.12月日均）

SELECT  
		T01_Deposit_Acct.Cust_Id					AS '客户号'
		,T01_Deposit_Acct.Deposit_Acct_No			AS '存款账号'
		,T01_Deposit_Acct.Open_Org_Id				AS '开户机构'
		,T01_Deposit_Acct.Open_Dt					AS '开户日期'
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

-- 3、	统计所有客户的贷款账户数、2011.12.31日的贷款余额、2011.12贷款月日均
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
		AND T01_Agmt_Bal_H.End_Dt > '2011/12/31';
--2011.12贷款月日均
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

--……………………………………………………………………………… DAY 2………………………………………………………………………………
--1、	查询客户表，统计每个机构2000年之前开户数、2000~2005开户数（含头不含尾）、
--		2005~2010开户数（含头不含尾）、2010之后开户数
--		展示字段：机构号、2000年之前开户数、2000~2005年开户数、2005~2010年开户数、2010年之后开户数

SELECT
		Open_Org_Id [机构号]
		,SUM(CASE WHEN YEAR(Open_Dt) < 2000 THEN 1 ELSE 0 END) [2000之前开户数]
		,SUM(CASE WHEN YEAR(Open_Dt) >= 2000 AND YEAR(Open_Dt) < 2005 THEN 1 ELSE 0 END) [2000~2005开户数]
		,SUM(CASE WHEN YEAR(Open_Dt) >= 2005 AND YEAR(Open_Dt) < 2010 THEN 1 ELSE 0 END) [2005~2010开户数]
		,SUM(CASE WHEN YEAR(Open_Dt) >= 2010 THEN 1 ELSE 0 END) [2010之后开户数]
FROM	
		T01_Customer
GROUP BY 
		Open_Org_Id;

--2、	查询客户表，按年份统计，每年、每个机构开户数占全年开户数的占比
--展示字段：年份、机构号、开户数、开户占比百分比（百分比）
SELECT 	
		YEAR(A.Open_Dt)					AS '年份'
        ,A.Open_Org_Id				 	AS '开户机构'
        ,COUNT(A.Cust_Id)				AS '开户数'
		,CAST(1.0*COUNT(A.Cust_Id)/B.开户总数 AS NUMERIC(18,4))	AS '开户数占比'
	
FROM
		t01_customer A
LEFT JOIN 
		(
		SELECT 	
				YEAR(Open_Dt)	AS '年份'
				,count(*)		AS '开户总数'
		FROM
				t01_customer
		GROUP BY 	
				YEAR(Open_Dt)
		) AS B
ON 
		YEAR(A.Open_Dt) = B.年份 
GROUP BY 	
		A.Open_Org_Id
        ,YEAR(A.Open_Dt)
        ,B.开户总数;

-- 3、	统计所有客户的客户号、存款账户数、2011.12.31日的存款余额、
--2011.12存款月日均、贷款账户数、2011.12.31日的贷款余额、2011.12贷款月日均
SELECT  DISTINCT 
		A.Cust_Id 									AS '客户号'
		,ISNULL(C_01.存款账号个数,'0')				AS '存款账户数'
		,ISNULL(C_02.余额,'0')						AS '[2011.12.31存款余额]'		
		,ISNULL(C_03.[2011年12月的月日均],'0')		AS '[2011.12存款月日均]'      
		,COUNT(D.IOU_No) 							AS '贷款账户数'
		,ISNULL(D_02.[2011.12.31贷款余额],'0')		AS '[2011.12.31贷款余额]'
		,ISNULL(D_03.[2011年12月的月日均],'0')		AS '[2011.12贷款月日均]'
FROM	T01_Customer A 	
		------------------------------------存款账户数--------------------------------------------------------
						LEFT JOIN 	(
									SELECT 
											Cust_Id
											,COUNT(Deposit_Acct_No)	AS '存款账号个数'
									FROM
											T01_Deposit_Acct 
									GROUP BY
											Cust_Id
									) C_01
						ON 			A.Cust_Id = C_01.Cust_Id
		-------------------------------2011.12.31日的存款余额-------------------------------------------------
                        LEFT JOIN 	(
									SELECT   
											Cust_Id AS 客户号
											,SUM(bal) AS 余额
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
						ON 			C_02.客户号 = A.Cust_Id
		------------------------------------2011.12存款月日均-------------------------------------------------
						LEFT JOIN   (
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
									) C_03
						ON			(A.Cust_Id = C_03.客户号)
		-----------------------------------------------贷款账户数--------------------------------------------
						LEFT JOIN 	T01_Loan_Iou D
						ON 			(A.Cust_Id = D.Cust_Id)
		----------------------------------------2011.12.31日的贷款余额---------------------------------------
						LEFT JOIN   (
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
									) D_02
						ON			(A.Cust_Id = D_02.客户号)
		----------------------------------------2011.12贷款月日均-------------------------------------------
						LEFT JOIN	(
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
						ON			(A.Cust_Id = D_03.客户号)
GROUP BY 
		A.Cust_Id
		,C_02.余额
        ,C_01.存款账号个数
		,C_03.[2011年12月的月日均] 
		,D_02.[2011.12.31贷款余额]
		,D_03.[2011年12月的月日均];

--……………………………………………………………………………… DAY 3………………………………………………………………………………
/** 1、	统计所有客户的2011.12.31日的存款余额、存款比上日余额、存款比上月余额、、存款比上年余额
备注：存款比上日余额 = 2011.12.31日的存款余额-2011.12.30日的存款余额
      存款比上月余额 = 2011.12.31日的存款余额-2011.11.30日的存款余额
      存款比上年余额 = 2011.12.31日的存款余额-2010.12.31日的存款余额
   只有2011.12.31这个日期可以写死，其他日期要通过2011.12.31这个日期来生成。  **/
		-----------------------------------以存款表为主表----------------------------------------
SELECT  DISTINCT
		MAIN.Cust_Id																AS '客户号'
		,MAIN.Deposit_Acct_No														AS '存款账号'
		,ISNULL(TABLE1.[2011.12.31余额],'0')										AS '2011.12.31余额'
		,ISNULL(TABLE1.[2011.12.31余额],'0')-ISNULL(TABLE2.[2011.12.30余额],'0')	AS '存款比上日余额'
		,ISNULL(TABLE1.[2011.12.31余额],'0')-ISNULL(TABLE3.[2011.11.30余额],'0')	AS '存款比上月余额'
		,ISNULL(TABLE1.[2011.12.31余额],'0')-ISNULL(TABLE4.[2010.12.31余额],'0')	AS '存款比上年余额'
FROM	T01_Deposit_Acct MAIN
		-----------------------所有客户的2011.12.31日的存款余额----------------------------
		LEFT JOIN	(					
					SELECT  
							T01_Deposit_Acct.Cust_Id				AS '客户号'
							,T01_Deposit_Acct.Deposit_Acct_No		AS '存款账号'
							,T01_Agmt_Bal_H.Bal						AS '2011.12.31余额'
					FROM	
							T01_Deposit_Acct
							,T01_Agmt_Bal_H
					WHERE   T01_Deposit_Acct.Deposit_Acct_No = T01_Agmt_Bal_H.Agmt_Id 
							AND T01_Agmt_Bal_H.Start_Dt <= '2011/12/31'
							AND T01_Agmt_Bal_H.End_Dt > '2011/12/31'
							AND T01_Agmt_Bal_H.Agmt_Type_Cd = 01
					) TABLE1
		ON			(
					MAIN.Cust_Id = TABLE1.客户号
					AND MAIN.Deposit_Acct_No = TABLE1.存款账号
					)
		-----------------------所有客户的2011.12.31日的上日余额---------------------------
		LEFT JOIN	(
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
					) TABLE2
		ON			(
					MAIN.Cust_Id = TABLE2.客户号
					AND MAIN.Deposit_Acct_No = TABLE2.存款账号
					)
		-----------------------所有客户的2011.12.31日的上月余额---------------------------
		LEFT JOIN	(
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
					) TABLE3
		ON			(
					MAIN.Cust_Id = TABLE3.客户号
					AND MAIN.Deposit_Acct_No = TABLE3.存款账号
					)
		-----------------------所有客户的2011.12.31日的上年余额---------------------------
		LEFT JOIN	(
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
					) TABLE4
		ON			(
					MAIN.Cust_Id = TABLE4.客户号
					AND MAIN.Deposit_Acct_No = TABLE4.存款账号
					)
GROUP BY
		MAIN.Cust_Id
		,MAIN.Deposit_Acct_No		
		,TABLE1.[2011.12.31余额]
		,TABLE2.[2011.12.30余额]
		,TABLE3.[2011.11.30余额]
		,TABLE4.[2010.12.31余额];

--2、	统计所有2011年存款年日均大于100的客户号、客户名称、存款账户数、2011年年日均
SELECT		
			T01_Customer.Cust_Id									AS '客户号'
			,TABLE2.存款账户数
			,TABLE1.[2011年年日均]
FROM		
			T01_Customer
			----------------------------查询存款账户数---------------------------------------
			LEFT JOIN
			(
				SELECT 
						T01_Deposit_Acct.Cust_Id					AS '客户号'
						,COUNT(T01_Deposit_Acct.Deposit_Acct_No)	AS '存款账户数'
				FROM	
						T01_Deposit_Acct
				GROUP BY 
						T01_Deposit_Acct.Cust_Id 
				) TABLE2
			ON	(TABLE2.客户号 = T01_Customer.Cust_Id)
			---------------------------查询2011年年日均---------------------------------------
			LEFT JOIN 
			(
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
							)/365							AS '2011年年日均'
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
				T01_Customer.Cust_Id = TABLE1.客户号
				)
WHERE		TABLE1.[2011年年日均] > 100
GROUP BY	
			T01_Customer.Cust_Id									
			,TABLE2.存款账户数
			,TABLE1.[2011年年日均];


--……………………………………………………………………………… DAY 4………………………………………………………………………………
--1、	统计所有2011年存款年日均和2011年贷款年日均都大于100的客户号、存款账户数、
--		2011年存款年日均、贷款账户数、2011年贷款年日均
SELECT		
			T01_Customer.Cust_Id									AS '客户号'
			,TABLE1.存款账户数
			,TABLE2.[2011年存款年日均]
			,TABLE3.贷款账户数
			,TABLE4.[2011年贷款年日均]
FROM		
			T01_Customer
			----------------------------查询存款账户数-------------------------------------------
			LEFT JOIN
			(
				SELECT 
						T01_Deposit_Acct.Cust_Id					AS '客户号'
						,COUNT(T01_Deposit_Acct.Deposit_Acct_No)	AS '存款账户数'
				FROM	
						T01_Deposit_Acct
				GROUP BY 
						T01_Deposit_Acct.Cust_Id 
				) TABLE1
			ON	(TABLE1.客户号 = T01_Customer.Cust_Id)
			---------------------------查询2011年存款年日均---------------------------------------
			LEFT JOIN 
			(
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
							)/365							AS '2011年存款年日均'
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
				T01_Customer.Cust_Id = TABLE2.客户号
				)
			----------------------------查询贷款账户数---------------------------------------
			LEFT JOIN
			(
				SELECT 
						T01_Loan_Iou.Cust_Id					AS '客户号'
						,COUNT(T01_Loan_Iou.IOU_No)				AS '贷款账户数'
				FROM	
						T01_Loan_Iou
				GROUP BY 
						T01_Loan_Iou.Cust_Id 
				) TABLE3
			ON	(TABLE3.客户号 = T01_Customer.Cust_Id)
			---------------------------查询2011年贷款年日均---------------------------------------
			LEFT JOIN 
			(
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
							)/365							AS '2011年贷款年日均'
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
				T01_Customer.Cust_Id = TABLE4.客户号
				)
WHERE		
			TABLE2.[2011年存款年日均] > 100
			AND TABLE4.[2011年贷款年日均] > 100
ORDER BY 
			TABLE1.客户号
			,TABLE1.存款账户数
			,TABLE2.[2011年存款年日均]
			,TABLE3.贷款账户数
			,TABLE4.[2011年贷款年日均];



/**2、	统计所有客户的客户号、
		存款标志（有存款账户的客户置为1、没存款账户的客户置为0）、
		贷款标志（有贷款借据的客户置为1、没贷款借据的客户置为0）、
		存款质量分类（2011年存款年日均>=10000置为优质、2011年存款年日均>=1000<10000
		置为良好、2011年存款年日均<1000置为普通）、
		2011年存款年日均、
		贷款质量分类（2011年贷款年日均>=10000置为优质、2011年贷款年日均>=1000<10000
		置为良好、2011年贷款年日均<1000置为普通）、
		2011年贷款年日均				**/
SELECT	
			Table1.Cust_Id
			,ISNULL(Table2.存款标志,'0')																AS '存款标志'
			,ISNULL(Table3.贷款标志,'0')																AS '贷款标志'
			,CAST(ISNULL(Table4.[2011年存款年日均],'0')	AS NUMERIC(18,2))								AS '2011年存款年日均'
			,(CASE	WHEN	ISNULL(Table4.[2011年存款年日均],'0') >= 10000 THEN '优质' 
					WHEN	ISNULL(Table4.[2011年存款年日均],'0') >= 1000
					AND		ISNULL(Table4.[2011年存款年日均],'0') < 10000  THEN '良好' 
					ELSE														'普通'	
					END)																				AS '存款质量分类'
			,CAST(ISNULL(TABLE5.[2011年贷款年日均],'0')	AS numeric(18,2))								AS '2011年贷款年日均'
			,(CASE	WHEN	ISNULL(Table5.[2011年贷款年日均],'0') >= 10000 THEN '优质' 
					WHEN	ISNULL(Table5.[2011年贷款年日均],'0') >= 1000
					AND		ISNULL(Table5.[2011年贷款年日均],'0') < 10000  THEN '良好' 
					ELSE														'普通'	
					END)																				AS '贷款质量分类'

FROM	
			T01_Customer Table1
		--------------------------------------------------查询存款标志------------------------------------------------
			LEFT JOIN
					(
					SELECT	
							T01_Deposit_Acct.Cust_Id													AS '客户号'
							,CASE WHEN T01_Deposit_Acct.Deposit_Acct_No IS NOT NULL THEN 1 ELSE 0 END		AS '存款标志'
					FROM	T01_Deposit_Acct 
					) Table2
			ON		(Table2.客户号 = Table1.Cust_Id)
		--------------------------------------------------查询贷款标志------------------------------------------------
			LEFT JOIN
					(
					SELECT	
							T01_Loan_Iou.Cust_Id														AS '客户号'
							,CASE WHEN T01_Loan_Iou.IOU_No IS NOT NULL THEN 1 ELSE 0 END				AS '贷款标志'
					FROM	T01_Loan_Iou
					) Table3
			ON		(Table3.客户号 = Table1.Cust_Id)
		----------------------------------------------查询2011年存款年日均-----------------------------------------------
			LEFT JOIN 
			(
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
							)/365							AS '2011年存款年日均'
							
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
				Table1.Cust_Id = Table4.客户号
				)
			---------------------------查询2011年贷款年日均---------------------------------------
			LEFT JOIN 
			(
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
							)/365							AS '2011年贷款年日均'
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
				Table1.Cust_Id = TABLE5.客户号
				)
GROUP BY
			Table1.Cust_Id
			,Table2.存款标志
			,Table3.贷款标志
			,Table4.[2011年存款年日均]
			,TABLE5.[2011年贷款年日均];


--……………………………………………………………………………… DAY 5………………………………………………………………………………
--1、	根据《事件表.xlsx》来建表，然后将excel中的数据导入到目标表中
CREATE TABLE 
		T01_EventsList
		(
			Event_Id			VARCHAR(30) NOT NULL			--事件编号	
			,Trade_Date			DATE		NOT NULL			--交易日期
			,Serial_Number		VARCHAR(20) NOT NULL			--交易流水号
			,System_Date		DATE		NOT NULL			--系统日期
			,System_Time		TIME		NOT NULL			--系统时间
			,Trade_Code			VARCHAR(6)	NOT NULL			--交易码
			,Event_Number		VARCHAR(20) NOT NULL			--账号
			,Trade_Amount		MONEY		NOT NULL			--交易金额
			,Fees				MONEY		NOT NULL			--交易手续费
			,PRIMARY KEY(Event_Id,System_Date,Event_Number)
		);

ALTER TABLE T01_EventsList ALTER COLUMN System_Time VARCHAR(12) NOT NULL;


/**
2、	根据客户表、存款信息表、事件表，统计
	每个客户2017年的客户号、
	交易账户数（客户下有多少个账户有交易就是多少）、
	当年有交易的天数（如果2017年有5天有过交易，则有交易天数为5）、
	当年有交易总月数（如果2017的1、3、5月有交易，则有交易总月数为3）、
	最大的月交易总金额（按月统计交易金额，存放最大的月交易金额）、
	最大月交易金额的月份（按月统计交易金额，存放交易金额最大的月份）、

	年总交易金额、
	年交易金额排名（按客户排名，如果总交易金额为0，则不参与排名，排名置为9999）、
	年总手续费、
	年总手续费排名（按客户排名，如果总手续费为0，则不参与排名，排名置为9999）**/

SELECT
		T01_Customer.Cust_Id													AS '客户号'
		,ISNULL(TABLE1.交易账户数,'0')											AS '交易账户数'
		,ISNULL(TABLE1.交易天数,'0')											AS '交易天数'
		,ISNULL(TABLE1.交易月数,'0')											AS '交易月数'
		,ISNULL(TABLE3.最大的月交易总金额,'0')									AS '最大的月交易总金额'
		,ISNULL(TABLE3.最大月交易金额的月份,'0')								AS '最大月交易金额的月份'
		,ISNULL(TABLE5.客户年总交易金额,'0')									AS '年总交易金额'
		,ISNULL(TABLE5.排名,'9999')												AS '排名'
		,ISNULL(TABLE6.年总手续费,'0')											AS '年总手续费'
		,ISNULL(TABLE6.排名,'9999')												AS '排名'
FROM
		T01_Customer 
		---------------------------------------------查询存款账户数,交易天数，交易月数----------------------------------------------------
			LEFT JOIN
			(SELECT 
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
				) TABLE1
			ON	(TABLE1.客户号 = T01_Customer.Cust_Id)
		-------------------------------------------------------------------------------------------------------------------------------
			LEFT JOIN
			(
			SELECT DISTINCT
					T01_Deposit_Acct.Cust_Id											AS '账号'
					,ISNULL(MAX(TABLE2.最大交易金额),'0')								AS '最大的月交易总金额'
					,ISNULL(TABLE2.月份,'0')											AS '最大月交易金额的月份'
			FROM 
					T01_Deposit_Acct
					--------------------------------------查询每个账户的最大交易金额，月份---------------------------------------------
					LEFT JOIN
					(
							SELECT 
									Event_Number											AS '账号' 
									,MAX(DISTINCT Trade_Amount)								AS '最大交易金额'
									,E2.月份												AS '月份'
							FROM
									T01_EventsList
									------------------------------查询月份--------------------------------------------------------------
									LEFT JOIN
									(
											SELECT	
													T01_EventsList.Event_Number				AS '账号'
													,MONTH(T01_EventsList.Trade_Date)		AS '月份'	
											FROM
													T01_EventsList	
									)	E2
									ON		(E2.账号 = T01_EventsList.Event_Number)
							GROUP BY
									Event_Number
									,E2.月份			
					) TABLE2
							ON	(T01_Deposit_Acct.Deposit_Acct_No = TABLE2.账号)
			GROUP BY
					T01_Deposit_Acct.Cust_Id
					,TABLE2.月份
			)	TABLE3
			ON (TABLE3.账号 = T01_Customer.Cust_Id)
			----------------------------------------年总交易金额、年交易金额排名-----------------------------------------------------------------
			LEFT JOIN
			(
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
			) TABLE5
			ON (TABLE5.客户号 = T01_Customer.Cust_Id)
			----------------------------------------年总手续费、年总手续费排名-----------------------------------------------------------------
			LEFT JOIN
			(
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
			) TABLE6
			ON (TABLE6.客户号 = T01_Customer.Cust_Id)
GROUP BY
		T01_Customer.Cust_Id													
		,TABLE1.交易账户数
		,TABLE1.交易天数
		,TABLE1.交易月数
		,TABLE3.最大的月交易总金额
		,TABLE3.最大月交易金额的月份
		,TABLE5.客户年总交易金额
		,TABLE5.排名
		,TABLE6.年总手续费
		,TABLE6.排名
ORDER BY 
		TABLE5.排名 
		




/**最大的月交易总金额（按月统计交易金额，存放最大的月交易金额）、
	最大月交易金额的月份（按月统计交易金额，存放交易金额最大的月份）、**/

SELECT 
		Event_Number
		,MAX(Trade_Amount)
		,STUFF((SELECT ','+MONTH(Trade_Date) FROM T01_EventsList FOR XML PATH('')),1,1,'')
FROM 
		T01_EventsList
GROUP BY
		Event_Number
		,MONTH(Trade_Date)



					

