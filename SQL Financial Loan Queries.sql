-- Total Applications Made:

SELECT COUNT (DISTINCT id) AS total_loan_applications
FROM bank_loan_data;

-- Calculating Month To Date:

SELECT COUNT (DISTINCT id) AS MTD_total_loan_applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- Calculating Previous Month On Month:

SELECT COUNT (DISTINCT id) AS PMTD_total_loan_applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 11

-- Total Funded Amount Of Loan Applications

SELECT SUM(loan_amount) AS total_funded_amount
FROM bank_loan_data

-- Total Funded Amount Of MTD Loan Applications

SELECT SUM(loan_amount) AS MTD_total_funded_amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- Total Funded Amount Of PMTD Loan Applications

SELECT SUM(loan_amount) AS PMTD_total_funded_amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 11

-- Total Recieved Amount:

SELECT SUM(total_payment) AS total_amount_recieved
FROM bank_loan_data
--WHERE MONTH(issue_date) = 11

-- Total MTD Recieved Amount:

SELECT SUM(total_payment) AS MTD_total_amount_recieved
FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- Total PMTD Recieved Amount:

SELECT SUM(total_payment) AS PMTD_total_amount_recieved
FROM bank_loan_data
WHERE MONTH(issue_date) = 11

-- Average Interest Rate:

SELECT ROUND(AVG(int_rate),4) * 100 AS avg_interest_rate
FROM bank_loan_data

-- MTD Average Interest Rate:

SELECT ROUND(AVG(int_rate),4) * 100 AS MTD_avg_interest_rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- PMTD Average Interest Rate:

SELECT ROUND(AVG(int_rate),4) * 100 AS PMTD_avg_interest_rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 11

-- MTD Average Debt To Income Ratio

SELECT ROUND(AVG(dti),4) * 100 AS MTD_average_debt_to_income_ratio
FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- PMTD Average Debt To Income Ratio

SELECT ROUND(AVG(dti),4) * 100 AS PMTD_average_debt_to_income_ratio
FROM bank_loan_data
WHERE MONTH(issue_date) = 11

-- Good Loan Application Percentage:

SELECT
      (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100) / COUNT(id) AS good_loan_percentage
FROM bank_loan_data

-- Good Loan Applications:

SELECT COUNT(id) AS good_loan_applications
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Funded Amount:

SELECT SUM(loan_amount) AS good_loan_funded_amount
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Total Received Amount:

SELECT SUM(total_payment) AS good_loan_recieved_amount
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Bad Loan Application Percentage:

SELECT
      (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100)  / COUNT(id) AS bad_loan_percentage
FROM bank_loan_data

-- Bad Loan Applications:

SELECT COUNT(id) AS bad_loan_applications
FROM bank_loan_data
WHERE loan_status = 'Charged Off'

-- Bad Loan Funded Amount:

SELECT SUM(loan_amount) AS bad_loan_funded_amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off' 

-- Bad Loan Total Received Amount:

SELECT SUM(total_payment) AS bad_loan_recieved_amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off' 

-- Loan Status

SELECT loan_status,
       COUNT(id) AS loan_count, 
	   SUM(loan_amount) AS total_funded_amount,
	   SUM(total_payment) AS total_payment_recieved,
	   AVG(int_rate * 100) AS avg_interest_rate,
	   AVG(dti * 100) AS avg_debt_to_income_ratio
FROM bank_loan_data
GROUP BY loan_status

-- MTD Loan Status

SELECT loan_status,
       COUNT(id) AS loan_count, 
	   SUM(loan_amount) AS MTD_total_funded_amount,
	   SUM(total_payment) AS MTD_total_payment_recieved,
	   AVG(int_rate * 100) AS MTD_avg_interest_rate,
	   AVG(dti * 100) AS MTD_avg_debt_to_income_ratio
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status

-- Loan Status By Month

SELECT MONTH(issue_date) AS month_number,
       DATENAME(MONTH, issue_date) AS month_name,
       COUNT(id) AS loan_count, 
	   SUM(loan_amount) AS total_funded_amount,
	   SUM(total_payment) AS total_payment_recieved
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date) 

-- Loan Status By State

SELECT address_state AS state,
       COUNT(id) AS total_loan_application,
	   SUM(loan_amount) AS total_funded_amount,
	   SUM(total_payment) AS total_payment_recieved
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

-- Loan Status By Term

SELECT term,
       COUNT(id) AS total_loan_application,
       SUM(loan_amount) AS total_funded_amount,
	   SUM(total_payment) AS total_payment_recieved
FROM bank_loan_data
GROUP BY term
ORDER BY term

-- Loan Status By Employee Length

SELECT emp_length AS employee_length,
       COUNT(id) AS total_loan_application,
       SUM(loan_amount) AS total_funded_amount,
	   SUM(total_payment) AS total_payment_recieved
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

-- Loan Status By Purpose

SELECT purpose AS loan_reason,
       COUNT(id) AS total_loan_application,
       SUM(loan_amount) AS total_funded_amount,
	   SUM(total_payment) AS total_payment_recieved
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose

-- Loan Status By Home Ownership

SELECT home_ownership AS home_status,
       COUNT(id) AS total_loan_application,
       SUM(loan_amount) AS total_funded_amount,
	   SUM(total_payment) AS total_payment_recieved
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership

-- Calculating Loan Status By Grade

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'B'
GROUP BY purpose
ORDER BY purpose

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'C'
GROUP BY purpose
ORDER BY purpose

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'D'
GROUP BY purpose
ORDER BY purpose

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'E'
GROUP BY purpose
ORDER BY purpose

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'F'
GROUP BY purpose
ORDER BY purpose

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'G'
GROUP BY purpose
ORDER BY purpose