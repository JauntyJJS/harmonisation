# get_max_stenosis_severity works with all missing severity

    Code
      max_stenosis_severity <- get_max_stenosis_severity(vessel_data = all_missing_vessel_data,
        stenosis_severity_grp_column = "vessel_severity")
    Condition
      Warning in `get_max_stenosis_severity()`:
      Could not get max stenosis severity from input vessel data `vessel_data`, column `vessel_severity` as values are all empty. Ensure that column `vessel_severity` has at least one row with these severity group names.
      * "Normal"
      * "Minimal"
      * "Mild"
      * "Moderate"
      * "Severe"
      * "Occluded"

