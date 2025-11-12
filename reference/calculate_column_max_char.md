# Calculate Column Maximum Character

Calculate the maximum number of characters for each column in the input
data frame or tibble, including the column name.

## Usage

``` r
calculate_column_max_char(data)
```

## Arguments

- data:

  Input tibble or data frame.

## Value

A numeric vector each value indicated the maximum number of characters
for each column of the input data frame or tibble.

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

column_max_char <- calculate_column_max_char(vessel_disease_data)

column_max_char
#> [1] 24 15
```
