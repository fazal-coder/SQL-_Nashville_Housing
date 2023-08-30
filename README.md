# SQL-_Nashville_Housing

# Nashville Housing Data Cleanup SQL Queries

This repository contains a set of SQL queries for cleaning and transforming data in the `Nashvillahousing` table. The queries are designed to address various data quality and formatting issues.

## Standardize Date Format:
Converts the SaleDate column to a standardized date format using CAST.

## Populate Property Address Data:
Fills in missing PropertyAddress values by joining the table with itself based on `ParcelID` and copying non-null addresses.

- **Breaking out PropertyAddress:**
Splits the `PropertyAddress` column into `Address` and `City` using `SUBSTRING` and `CHARINDEX`, and stores them in new columns.

Breaking out OwnerAddress:


```sql
-- SQL code for standardizing date format
SELECT SaleDateConvert, CAST(SaleDate AS date) AS SaleDate FROM dbo.Nashvillahousing;


Repository created by `[Fazal Diyan]`
