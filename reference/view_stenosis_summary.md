# View Stenosis Summary

A wrapper function to display an interactive table to see stenosis
summary.

## Usage

``` r
view_stenosis_summary(
  input_stenosis_summary,
  stenosis_data_column,
  download_file_name = "stenosis_summarised_results"
)
```

## Arguments

- input_stenosis_summary:

  Input stenosis summary. It should contain one nested column
  representing a list of stenosis data sets.

- stenosis_data_column:

  Input nested column name from \`input_stenosis_summary\` indicating
  the stenosis data sets.

- download_file_name:

  Name of the stenosis summary csv file when the download button is
  clicked. Default: stenosis_summarised_results

## Value

An interactive table of \`input_stenosis_summary\`

## Examples

``` r
zero_vessel_disease_data <- tibble::tribble(
  ~coronary_vessel_segments, ~vessel_severity,
  "LM", "Normal",
  "pLAD", "Normal",
  "mLAD", "Normal",
  "dLAD", "Normal",
  "Diag1", "Normal",
  "Diag2", "Normal",
  "Ramus", "Normal",
  "pLCX", "Normal",
  "dLCX", "Normal",
  "OM1", "Normal",
  "OM2", "Normal",
  "pRCA", "Normal",
  "mRCA", "Normal",
  "dRCA", "Normal",
  "RPDA", "Normal",
  "RPL", "Normal")

three_vessel_disease_data <- tibble::tribble(
  ~coronary_vessel_segments, ~vessel_severity,
  "LM", "Normal",
  "pLAD", "Severe",
  "mLAD", "Minimal",
  "dLAD", "Occluded",
  "Diag1", "Normal",
  "Diag2", "Normal",
  "Ramus", "Normal",
  "pLCX", "Moderate",
  "dLCX", "Moderate",
  "OM1", "Normal",
  "OM2", "Normal",
  "pRCA", "Normal",
  "mRCA", "Severe",
  "dRCA", "Mild",
  "RPDA", "Normal",
  "RPL", "Normal")

stenosis_summary <- tibble::tibble(
  unique_id = c("1", "2"),
  stenosis_data = list(zero_vessel_disease_data,
                       three_vessel_disease_data),
  number_of_vessel_disease = c(0, 3)
)

stenosis_table <- stenosis_summary |>
  view_stenosis_summary(
    stenosis_data_column = "stenosis_data"
  )
```
