# Add Cohort Name

Add cohort name as a new column in the dataset and move it to the first
column.

## Usage

``` r
add_cohort_name(input_data, cohort_name, cohort_name_column = "cohort_name")
```

## Arguments

- input_data:

  The input data as a data frame or tibble.

- cohort_name:

  A text indicating the name of the cohort

- cohort_name_column:

  A text indicating the column name used to represent the name of the
  cohort. Default: 'cohort_name'

## Value

A data frame with a new column called the input text
from\`cohort_name_column\` containing a character vector of the input
text from \`cohort_name\`.

## Details

An error will be raised if input \`cohort_name_column\` is already a
column name in \`input_data\`. Currently, no overriding of columns is
allowed.

## Examples

``` r

input_data <- tibble::tribble(
  ~column_a, ~column_b,
  1, "Yes",
  1, "No")

cohort_name = "Cohort 1"

result_data <- input_data |>
  add_cohort_name(cohort_name = "Cohort 1",
                  cohort_name_column = "cohorts")

result_data
#> # A tibble: 2 × 3
#>   cohorts  column_a column_b
#>   <chr>       <dbl> <chr>   
#> 1 Cohort 1        1 Yes     
#> 2 Cohort 1        1 No      
```
