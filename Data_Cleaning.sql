select *
from housing.dbo.Nashville


------------- Changing Sale Date by taking off time


SELECT
	SaleDate,
	CONVERT(Date,SaleDate)
FROM housing.dbo.Nashville

UPDATE housing.dbo.Nashville
SET SaleDate=CONVERT(Date,SaleDate)

select *
from housing.dbo.Nashville

ALTER TABLE housing.dbo.Nashville
ADD NewSaleDate Date;

UPDATE housing.dbo.Nashville
SET NewSaleDate=CONVERT(Date,SaleDate)

select *
from housing.dbo.Nashville




----------- Adding Property Address Data
---Checking for NULL values in Property Address Column


WHERE PropertyAddress IS NULL

select *
from housing.dbo.Nashville


SELECT 
	a.ParcelID,
	a.PropertyAddress,
	b.ParcelID,
	b.PropertyAddress,
	ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM housing.dbo.Nashville AS a
INNER JOIN housing.dbo.Nashville AS b
ON a.ParcelID=b.ParcelID
AND a.[UniqueID ]<>b.[UniqueID ]
WHERE a.PropertyAddress IS NULL
	
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM housing.dbo.Nashville AS a
INNER JOIN housing.dbo.Nashville AS b
ON a.ParcelID=b.ParcelID
AND a.[UniqueID ]<>b.[UniqueID ]
WHERE a.PropertyAddress IS NULL



------ Breaking out Address by Address, City, and State

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) - 1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) + 1,LEN(PropertyAddress)) AS City
FROM housing.dbo.Nashville

----- Create two new colunms for the split Address and City

ALTER TABLE housing.dbo.Nashville
ADD PropertyAddressSeperated Nvarchar(250);

UPDATE housing.dbo.Nashville
SET PropertyAddressSeperated = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) - 1)

ALTER TABLE housing.dbo.Nashville
ADD PropertyCitySeperated Nvarchar(250);

UPDATE housing.dbo.Nashville
SET PropertyCitySeperated = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) + 1,LEN(PropertyAddress))

---- Viewing updated table

SELECT OwnerAddress
FROM housing.dbo.Nashville


--- Seperating Owner Address by Address, City, and State

SELECT
PARSENAME(REPLACE(OwnerAddress, ',','.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',','.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)
FROM housing.dbo.Nashville

--- Adding new columns for Owner Address by Address, City, and State

ALTER TABLE housing.dbo.Nashville
ADD OwnerAddressSeperated Nvarchar(250);

UPDATE housing.dbo.Nashville
SET OwnerAddressSeperated = PARSENAME(REPLACE(OwnerAddress, ',','.'), 3)

ALTER TABLE housing.dbo.Nashville
ADD OwnerCitySeperated Nvarchar(250);

UPDATE housing.dbo.Nashville
SET OwnerCitySeperated = PARSENAME(REPLACE(OwnerAddress, ',','.'), 2)

ALTER TABLE housing.dbo.Nashville
ADD OwnerStateSeperated Nvarchar(250);

UPDATE housing.dbo.Nashville
SET OwnerStateSeperated = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)

-- Viewing updated Table

SELECT *
FROM housing.dbo.Nashville

-- Checking for duplicates





----------------- Make 'SoldAsVacant' column only 'Yes' or 'No'

SELECT 
	SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END

FROM housing.dbo.Nashville

UPDATE housing.dbo.Nashville
SET SoldAsVacant = 
	CASE 
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END

	-- Checking if only values for SoldAsVacant is 'Yes' or 'No'

SELECT DISTINCT(SoldAsVacant)
FROM housing.dbo.Nashville

----- DELETE unused columns

SELECT *
FROM  housing.dbo.Nashville


ALTER TABLE housing.dbo.Nashville
DROP COLUMN PropertyAddress, OwnerAddress, SaleDate