# Get Max Stenosis Severity

Obtain the highest level of stenosis severity from coronary vessel data.

## Usage

``` r
get_max_stenosis_severity(vessel_data, stenosis_severity_grp_column)
```

## Arguments

- vessel_data:

  Input coronary vessel data

- stenosis_severity_grp_column:

  Column in \`vessel_data\` indicating the severity level of the
  different coronary vessels. Accepted severity levels are

  - Normal (0% stenosis)

  - Minimal (1 to 24% stenosis)

  - Mild (25 to 49% stenosis)

  - Moderate (50 to 69% stenosis)

  - Severe (70 to 99% stenosis)

  - Occluded (100% stenosis)

## Value

A text indicating the highest level of stenosis severity from coronary
vessel data.

## Details

From [Cury et. al. (2022)](https://doi.org/10.1016/j.jcct.2022.07.002),
the Society of Cardiovascular Computed Tomography (SCCT) graded luminal
stenosis as follows:

- Normal (0% stenosis)

- Minimal (1 to 24% stenosis)

- Mild (25 to 49% stenosis)

- Moderate (50 to 69% stenosis)

- Severe (70 to 99% stenosis)

- Occluded (100% stenosis)

## Examples

``` r
occluded_coronary_vessel_data <- tibble::tribble(
  ~coronary_vessel, ~vessel_severity,
  "LM", "Normal",
  "LAD", "Severe",
  "LCX", "Minimal",
  "RCA", "Occluded"
)

max_stenosis_severity <- get_max_stenosis_severity(
  occluded_coronary_vessel_data,
  "vessel_severity"
)

max_stenosis_severity
#> [1] "Occluded"
```
