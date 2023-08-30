-- Cleaning Data in SQL Queries

SELECT * FROM [dbo].[Nashvillahousing]

----------------------------------------------------------

-- Standardize Date Format

SELECT SaleDateConvert,CAST(SaleDate AS date) As SaleDate FROM dbo.Nashvillahousing

--Add one Extra Column
ALTER TABLE dbo.Nashvillahousing
ADD SaleDateConvert Date;

--Then Put Convert SalesDate Values
UPDATE dbo.Nashvillahousing
SET SaleDateConvert = CAST(SaleDate AS date)


------------------------------------------------------------

-- Populate Property Address Data


SELECT * FROM dbo.Nashvillahousing
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID


SELECT a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM dbo.Nashvillahousing a
JOIN dbo.Nashvillahousing b ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM dbo.Nashvillahousing a
JOIN dbo.Nashvillahousing b ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL
---------------------------------------------------

--Breaking out PropertyAddress into Individual Columns (Address, City, State)

SELECT 
SUBSTRING(a.PropertyAddress,1, CHARINDEX(',', a.PropertyAddress) - 1) AS Address,
SUBSTRING(a.PropertyAddress, CHARINDEX(',', a.PropertyAddress) + 1, LEN(PropertyAddress)) AS City
FROM dbo.Nashvillahousing a


--Add Column in table name is PropertySplitAddress
ALTER TABLE Nashvillahousing
Add PropertySplitAddress Nvarchar(255);

--Update Column name is PropertySplitAddress
UPDATE Nashvillahousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress) - 1);

--Add Column in table name is PropertySplitCity
ALTER TABLE Nashvillahousing
ADD PropertySplitCity NVARCHAR(255);

--Update Column name is PropertySplitCity
UPDATE Nashvillahousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress));



SELECT 
PARSENAME(REPLACE(n.OwnerAddress, ',', '.'), 3) AS OwnerAddress,
PARSENAME(REPLACE(n.OwnerAddress, ',', '.'), 2) AS OwnerCity,
PARSENAME(REPLACE(n.OwnerAddress, ',', '.'), 1) AS Ownerstate
FROM dbo.Nashvillahousing n

--Add Column in table name is OwnersplitAddress
ALTER TABLE Nashvillahousing
ADD OwnersplitAddress NVARCHAR(255);

--Update Data in Column name is OwnersplitAddress
UPDATE Nashvillahousing
SET OwnersplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)



--Add Column in table name is OwnersplitCity
ALTER TABLE Nashvillahousing
ADD OwnersplitCity NVARCHAR(255);



--Update Data in Column name is OwnersplitCity
UPDATE Nashvillahousing
SET OwnersplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) 




--Add Column in table name is OwnersplitState
ALTER TABLE Nashvillahousing
ADD OwnersplitState NVARCHAR(255);



--Update Data in Column name is OwnersplitState
UPDATE Nashvillahousing
SET OwnersplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) 


----------------------------------------------------------------------------
--Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), Count(SoldAsVacant) AS total_count
From dbo.Nashvillahousing
Group by SoldAsVacant
order by 2

SELECT DISTINCT(SoldAsVacant)
FROM Nashvillahousing

--There Two ways to Update N as NO and Y as Yes in Column

SELECT SoldAsVacant, CASE 
						WHEN SoldAsVacant ='Y' THEN 'Yes'
						WHEN SoldAsVacant = 'N' THEN 'No'
						ELSE SoldAsVacant
					 END AS Sold_as_Vacant
						FROM Nashvillahousing n
WHERE n.SoldAsVacant ='Y' OR n.SoldAsVacant ='N' 

--Frist Update Query 
UPDATE Nashvillahousing
SET SoldAsVacant = 'No'
WHERE SoldAsVacant = 'N'

UPDATE Nashvillahousing
SET SoldAsVacant = 'Yes'
WHERE SoldAsVacant = 'Y'


--Second Update Query
UPDATE Nashvillahousing
SET SoldAsVacant = CASE 
						WHEN SoldAsVacant ='Y' THEN 'Yes'
						WHEN SoldAsVacant = 'N' THEN 'No'
						ELSE SoldAsVacant
					    END 
						FROM Nashvillahousing n





--------------------------------------------------------------------------------
--Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From Nashvillahousing
--order by ParcelID
)

--SELECT all duplicates

Select *
From RowNumCTE
Where row_num <> 1
Order by PropertyAddress

--Delete Duplicate Rows in table

DELETE From RowNumCTE
Where row_num <> 1


------------------------------------------------------------------------

-- Delete Unused Columns

ALTER TABLE Nashvillahousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate


