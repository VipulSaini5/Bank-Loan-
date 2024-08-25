select * from bank_loan_data

/* Total Loan Applications */

SELECT COUNT(ID) AS Total_loan_Applications FROM bank_loan_data


/* MTD Loan Applications */ 

SELECT COUNT(ID) AS MTD_Total_loan_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12 


/* PMTD Loan Applicatons */

SELECT COUNT(ID) AS PMTD_Total_loan_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 11


/* Total Funded Amount */

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data


/* MTD Funded Amount */

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


/* PMTD Funded Amount */

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


/* Total Received Amount */

SELECT SUM(total_payment) AS Total_Amount_Received FROM bank_loan_data


/* MTD Received Amount */

SELECT SUM(total_payment) AS MTD_Total_Amount_Received FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


/*PMTD Received Amount */

SELECT SUM(total_payment) AS PMTD_Total_Amount_Received FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


/* Average Interest Rate */

SELECT ROUND(AVG(int_rate), 4)*100 AS Avg_Interest_Rate FROM bank_loan_data


/* MTD Average Interest Rate */ 

SELECT ROUND(AVG(int_rate), 4)*100 AS MTD_Avg_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


/* PMTD Average Interst Rate */

SELECT ROUND(AVG(int_rate), 4)*100 AS PMTD_Avg_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


/* Average DTI */

SELECT ROUND(AVG(dti), 4)*100 AS Avg_DTI FROM bank_loan_data


/* MTD Average DTI */

SELECT ROUND(AVG(dti), 4)*100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


/* PMTD Average DTI */

SELECT ROUND(AVG(dti), 4)*100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


/* Good Loan Percentage */ 

SELECT 
	(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100)
	/
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data


/* Good Loan Applications */

SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


/* Good Loan Funded Amount */

SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


/* Good Loan Received Amount */

SELECT SUM(total_payment) AS Good_Loan_Received_Amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


/* Bad Loan Percentage */

SELECT 
	(COUNT(CASE WHEN loan_status = 'Charged off' THEN id END)*100.0)
	/
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data


/* Bad Loan Applications */

SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off'


/* Bad Loan Funded Amount */

SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'


/* Bad Loan Received Amount */

SELECT SUM(total_payment) AS Bad_Loan_Received_Amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'


/* Loan Status */

Select 
	loan_status,
	COUNT(id) AS LoanCount,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
	AVG(int_rate*100) AS Interest_Rate,
	AVG(dti*100) AS DTI 
FROM bank_loan_data
GROUP BY loan_status


/* Loan Status MTD */

SELECT 
	loan_status,
	SUM(total_payment) AS MTD_Total_Amount_Received,
	SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status


/* Monthly Trends */

SELECT 
	MONTH(issue_date),
	DATENAME(MONTH, issue_date) AS Month_Name,
	COUNT(Id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)


/* Regional Analysis */

SELECT 
	address_state,
	COUNT(Id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state 
ORDER BY COUNT(Id) DESC


/* Loan Term */

SELECT 
	term,
	COUNT(Id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term DESC


/* Employee Length */

SELECT 
	emp_length,
	COUNT(Id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY emp_length 
ORDER BY emp_length 


/* Loan Purpose */

SELECT 
	purpose,
	COUNT(Id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY purpose 
ORDER BY 2 DESC


/* Home Ownership */

SELECT 
	home_ownership,
	COUNT(Id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY home_ownership 
ORDER BY 2 DESC
