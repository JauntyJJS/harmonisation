# Summarise Vessel Segments Severity

Summarise vessel segments severity by picking the highest level of
stenosis severity in the segments.

## Usage

``` r
summarise_vessel_segments_severity(
  vessel_data,
  vessel_name_column,
  stenosis_severity_grp_column,
  vessel_segments_grp_name = "LAD",
  vessel_segments = c("pLAD", "mLAD", "dLAD")
)
```

## Arguments

- vessel_data:

  Input coronary vessel data that has only two columns
  \`vessel_name_column\` and \`stenosis_severity_grp_column\`.

- vessel_name_column:

  Column in \`vessel_data\` indicating the different vessel segments.

- stenosis_severity_grp_column:

  Column in \`vessel_data\` indicating the severity level of the
  different coronary vessels. Accepted severity levels are

  - Normal (0% stenosis)

  - Minimal (1 to 24% stenosis)

  - Mild (25 to 49% stenosis)

  - Moderate (50 to 69% stenosis)

  - Severe (70 to 99% stenosis)

  - Occluded (100% stenosis)

- vessel_segments_grp_name:

  A text indicating a group name for the vessel segments to be
  summarised. Default: "LAD"

- vessel_segments:

  A character vector indicating the vessel segments of interest to
  summarise. It should be a value found in the column
  \`vessel_name_column\`. Default: c("pLAD", "mLAD", "dLAD")

## Value

\`vessel_data\` with rows with the indicated vessel segments in
\`vessel_segments\` from column \`vessel_name_column\` are removed. A
new row with the corresponding \`vessel_segments_grp_name\` and
summarised stenosis severity will be added.

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

\[get_max_stenosis_severity()\] is used to obtain the highest stenosis
severity from the provided vessel segments.

## Examples

``` r
occluded_vessel_segment_data <- tibble::tribble(
  ~coronary_vessel_segments, ~vessel_severity,
  "LM", "Normal",
  "pLAD", "Severe",
  "mLAD", "Minimal",
  "dLAD", "Occluded"
)

stenosis_severity <- summarise_vessel_segments_severity(
  occluded_vessel_segment_data,
  "coronary_vessel_segments",
  "vessel_severity",
  "LAD",
  c("pLAD", "mLAD", "dLAD")
)

stenosis_severity
#> # A tibble: 2 × 2
#>   coronary_vessel_segments vessel_severity
#>   <chr>                    <chr>          
#> 1 LM                       Normal         
#> 2 LAD                      Occluded       
```
