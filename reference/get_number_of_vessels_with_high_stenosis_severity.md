# Get number of vessels with high stenosis severity

Get the number of vessels with stenosis severity of 50

## Usage

``` r
get_number_of_vessels_with_high_stenosis_severity(
  vessel_data,
  vessel_name_column,
  stenosis_severity_grp_column,
  lad_vessel_segments_grp_name = "LAD",
  lcx_vessel_segments_grp_name = "LCX",
  rca_vessel_segments_grp_name = "RCA",
  lad_vessel_segments = c("pLAD", "mLAD", "dLAD", "Diag1", "Diag2", "Diag3", "Diag4",
    "Ramus1", "Ramus2"),
  lcx_vessel_segments = c("pLCX", "dLCX", "LPDA", "LPL", "OM1", "OM2", "OM3", "OM4",
    "OM5"),
  rca_vessel_segments = c("pRCA", "mRCA", "dRCA", "RPDA", "RPL")
)
```

## Arguments

- vessel_data:

  Input coronary vessel data

- vessel_name_column:

  Column in \`vessel_data\` indicating the different vessel segments for
  LM, LAD, LCX and RCA.

- stenosis_severity_grp_column:

  Column in \`vessel_data\` indicating the severity level of the
  different coronary vessels. Accepted severity levels are

  - Normal (0% stenosis)

  - Minimal (1 to 24% stenosis)

  - Mild (25 to 49% stenosis)

  - Moderate (50 to 69% stenosis)

  - Severe (70 to 99% stenosis)

  - Occluded (100% stenosis)

- lad_vessel_segments_grp_name:

  Name of vessel segment group to indicate left anterior descending or
  LAD vessels. Default: 'LAD'

- lcx_vessel_segments_grp_name:

  Name of vessel segment group to indicate left circumflex or LCX
  vessels. Default: 'LCX'

- rca_vessel_segments_grp_name:

  Name of vessel segment group to indicate right coronary artery or RCA.
  Default: 'RCA'

- lad_vessel_segments:

  Name of vessel segments in the \`vessel_name_column\` to be grouped as
  left anterior descending or LAD vessels. Default: c("pLAD", "mLAD",
  "dLAD", "Diag1", "Diag2", "Diag3", "Diag4", "Ramus1", "Ramus2")

- lcx_vessel_segments:

  Name of vessel segments in the \`vessel_name_column\` to be grouped as
  left circumflex or LCX vessels. Default: c("pLCX", "dLCX", "LPDA",
  "LPL", "OM1", "OM2", "OM3", "OM4", "OM5")

- rca_vessel_segments:

  Name of vessel segments in the \`vessel_name_column\` to be grouped as
  right coronary artery or RCA. Default: c("pRCA", "mRCA", "dRCA",
  "RPDA", "RPL")

## Value

An integer from 0 to 4 indicating the number of vessels with stenosis
severity of 50

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

Do note that LM is considered a vessel.

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

four_vessel_disease_data <- tibble::tribble(
  ~coronary_vessel_segments, ~vessel_severity,
  "LM", "Severe",
  "pLAD", "Severe",
  "mLAD", "Minimal",
  "dLAD", "Occluded",
  "Diag1", "Normal",
  "Diag2", "Normal",
  "Diag3", "Normal",
  "Diag4", "Normal",
  "pLCX", "Moderate",
  "dLCX", "Moderate",
  "OM1", "Normal",
  "OM2", "Normal",
  "pRCA", "Normal",
  "mRCA", "Severe",
  "dRCA", "Mild",
  "RPDA", "Normal",
  "RPL", "Normal")

 zero_disease_vessel <- get_number_of_vessels_with_high_stenosis_severity(
   vessel_data = zero_vessel_disease_data,
   vessel_name_column = "coronary_vessel_segments",
   stenosis_severity_grp_column = "vessel_severity",
   lad_vessel_segments_grp_name = "LAD",
   lcx_vessel_segments_grp_name = "LCX",
   rca_vessel_segments_grp_name = "RCA",
   lad_vessel_segments = c("pLAD", "mLAD", "dLAD",
                           "Diag1", "Diag2", "Ramus"),
   lcx_vessel_segments = c("pLCX", "dLCX", "OM1", "OM2"),
   rca_vessel_segments = c("pRCA", "mRCA", "dRCA", "RPDA", "RPL")
   )

 four_disease_vessels <- get_number_of_vessels_with_high_stenosis_severity(
   vessel_data = four_vessel_disease_data,
   vessel_name_column = "coronary_vessel_segments",
   stenosis_severity_grp_column = "vessel_severity",
   lad_vessel_segments_grp_name = "LAD",
   lcx_vessel_segments_grp_name = "LCX",
   rca_vessel_segments_grp_name = "RCA",
   lad_vessel_segments = c("pLAD", "mLAD", "dLAD",
                           "Diag1", "Diag2", "Ramus"),
   lcx_vessel_segments = c("pLCX", "dLCX", "OM1", "OM2"),
   rca_vessel_segments = c("pRCA", "mRCA", "dRCA", "RPDA", "RPL")
   )

 zero_disease_vessel
#> [1] 0

 four_disease_vessels
#> [1] 4
```
