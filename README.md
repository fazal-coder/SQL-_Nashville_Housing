# SQL_Nashville_Housing

This section involves various data cleaning tasks for the  `Nashvillahousing` table.

- **Standardize Date Format:** Converts the SaleDate column to a standardized date format using CAST.

- **Populate Property Address Data:** Fills in missing PropertyAddress values by joining the table with itself based on `ParcelID` and copying non-null addresses.

- **Breaking out PropertyAddress:** Splits the `PropertyAddress` column into `Address` and `City` using `SUBSTRING` and `CHARINDEX`, and stores them in new columns.

- **Breaking out OwnerAddress:**  Similar to above, splits `OwnerAddress` into individual components (`OwnerAddress`, `OwnerCity`, `OwnerState`) using `PARSENAME` and `REPLACE`, and stores them in new columns.
  
- **Change Y and N to Yes and No:** Converts values in the `SoldAsVacant` column from 'Y' to 'Yes' and 'N' to 'No'.

- **Remove Duplicates:** Utilizes a Common Table Expression (CTE) with `ROW_NUMBER()` to identify and remove duplicate rows based on certain columns.

- **Delete Unused Columns:** Drops specified columns (`OwnerAddress`, `TaxDistrict`, `PropertyAddress`, `SaleDate`) from the table.



                                                                                                                                               **Diyan**
