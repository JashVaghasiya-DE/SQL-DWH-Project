/* 
====================================================================================
Stored Procedure:  Load Bronze Layer (Source -Y Bronze)
====================================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following actions:
  - Truncates the bronze tables before loading data.
  - Uses the 'BULK INSERT' command to load data from csv Files to bronze tables.
  Parameters : None.
  This stored procedure does not accept any parameters or return any values.
Usage Example:
  EXEC bronze.load_bronze;
====================================================================================
*/  
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 

	DECLARE @start_time  DATETIME, @end_time DATETIME, @start_batch_time DATETIME, @end_batch_time DATETIME;

	BEGIN TRY
		SET @start_batch_time = GETDATE();
		PRINT '=====================================';
		PRINT 'Loading the bronze layer...';
		PRINT '=====================================';

		PRINT '-------------------------------------';
		PRINT 'Loading CRM tables...';
		PRINT '-------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info 
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '>> ---------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info 
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '>> ---------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details 
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '>> ---------------------------';


		PRINT '-------------------------------------';
		PRINT 'Loading ERP tables...';
		PRINT '-------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12 
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '>> ---------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '>> ---------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '>> ---------------------------';
		SET @end_batch_time = GETDATE();
		PRINT 'Bronze Layer loading Completed!'
		PRINT '>> Total Duration to load bronze: ' + CAST(DATEDIFF(second, @start_batch_time, @end_batch_time) AS NVARCHAR) + ' seconds.';
		PRINT '>> ---------------------------';

	END TRY
	BEGIN CATCH
		PRINT '=========================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error State' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT 'Error Number'+ CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT '=========================================';
	END CATCH

END;
