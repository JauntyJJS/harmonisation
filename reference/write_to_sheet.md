# Write To Excel Sheet

Write data to an excel sheet.

## Usage

``` r
write_to_sheet(sheet_name, data, workbook)
```

## Arguments

- sheet_name:

  A vector of characters representing sheet names for the Excel file.

- data:

  A list of tibble and data frame representing the data needed to output
  to the Excel file.

- workbook:

  A Workbook object created using \`openxlsx::createWorkbook\`.

## Examples

``` r
coronary_vessel_segments <- c(
  "LM", "pLAD", "mLAD", "dLAD",
  "pLCX", "dLCX", "pRCA", "mRCA", "dRCA"
)

vessel_severity <- c(
  "Severe", "Severe", "Minimal", "Occluded",
  "Moderate", "Moderate", "Normal", "Severe", "Mild"
)

vessel_disease_data <- data.frame(
  coronary_vessel_segments = coronary_vessel_segments,
  vessel_severity = vessel_severity
)

# Create a new workbook
my_workbook <- openxlsx::createWorkbook()

sheet_name = c("vessel disease")
output_data = vessel_disease_data

write_to_sheet(sheet_name = sheet_name,
               data = output_data,
               workbook = my_workbook)
```
