# SQL-_Nashville_Housing

# Nashville Housing Data Cleanup SQL Queries

This repository contains a set of SQL queries for cleaning and transforming data in the `Nashvillahousing` table. The queries are designed to address various data quality and formatting issues.

## Standardize Date Format

Converts the `SaleDate` column to a standardized date format.

```sql
-- SQL code for standardizing date format
SELECT SaleDateConvert, CAST(SaleDate AS date) AS SaleDate FROM dbo.Nashvillahousing;


Repository created by `[Fazal Diyan]`
