# Reactable With Download CSV Button

A function that converts a simple tibble or dataframe into a reactable
with a download csv button

## Usage

``` r
reactable_with_download_csv_button(input_data, download_file_name = "download")
```

## Arguments

- input_data:

  Input simple dataframe or tibble with no nested data

- download_file_name:

  Name of the csv file when download csv button is clicked Default: NULL

## Value

A interactive table of \`input_data\` with a download csv button.
medical_data \<- tibble::tribble( ~unique_id, ~medications,
~medication_fixed, "1", "Medication 1", "Fixed Medication 1", "2",
"Medication 2", "Fixed Medication 2" )

medical_table \<- medical_data \|\> reactable_with_download_csv_button(
factor_columns = c("unique_id", "medications", "medication_fixed")
download_file_name = "download" )
