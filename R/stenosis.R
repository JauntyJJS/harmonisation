#' @title Get Max Stenosis Severity
#' @description Obtain the highest level of stenosis
#' severity from coronary vessel data.
#' @param vessel_data Input coronary vessel data
#' @param stenosis_severity_grp_column Column in
#' `vessel_data` indicating the severity level of the
#' different coronary vessels. Accepted severity levels are
#' \itemize{
#'   \item Normal (0\% stenosis)
#'   \item Minimal (1 to 24\% stenosis)
#'   \item Mild (25 to 49\% stenosis)
#'   \item Moderate (50 to 69\% stenosis)
#'   \item Severe (70 to 99\% stenosis)
#'   \item Occluded (100\% stenosis)
#' }
#' @return A text indicating the highest level of stenosis
#' severity from coronary vessel data.
#' @details From
#' \href{https://doi.org/10.1016/j.jcct.2022.07.002}{Cury et. al. (2022)},
#' the Society of Cardiovascular Computed Tomography (SCCT)
#' graded luminal stenosis as follows:
#' \itemize{
#'   \item Normal (0\% stenosis)
#'   \item Minimal (1 to 24\% stenosis)
#'   \item Mild (25 to 49\% stenosis)
#'   \item Moderate (50 to 69\% stenosis)
#'   \item Severe (70 to 99\% stenosis)
#'   \item Occluded (100\% stenosis)
#' }
#' @examples
#' occluded_coronary_vessel_data <- tibble::tribble(
#'   ~coronary_vessel, ~vessel_severity,
#'   "LM", "Normal",
#'   "LAD", "Severe",
#'   "LCX", "Minimal",
#'   "RCA", "Occluded"
#' )
#'
#' max_stenosis_severity <- get_max_stenosis_severity(
#'   occluded_coronary_vessel_data,
#'   "vessel_severity"
#' )
#'
#' max_stenosis_severity
#' @rdname get_max_stenosis_severity
#' @export
get_max_stenosis_severity <- function(
    vessel_data,
    stenosis_severity_grp_column) {

  # Assume grouping is Normal,
  # Minimal, Mild, Moderate, Severe, Occluded
  max_stenosis_severity <- dplyr::case_when(
    any(stringr::str_detect(
      string = vessel_data[[stenosis_severity_grp_column]],
      pattern = "Occluded"
    ), na.rm = TRUE) ~ "Occluded",
    any(stringr::str_detect(
      string = vessel_data[[stenosis_severity_grp_column]],
      pattern = "Severe"
    ), na.rm = TRUE) ~ "Severe",
    any(stringr::str_detect(
      string = vessel_data[[stenosis_severity_grp_column]],
      pattern = "Moderate"
    ), na.rm = TRUE) ~ "Moderate",
    any(stringr::str_detect(
      string = vessel_data[[stenosis_severity_grp_column]],
      pattern = "Mild"
    ), na.rm = TRUE) ~ "Mild",
    any(stringr::str_detect(
      string = vessel_data[[stenosis_severity_grp_column]],
      pattern = "Minimal"
    ), na.rm = TRUE) ~ "Minimal",
    any(stringr::str_detect(
      string = vessel_data[[stenosis_severity_grp_column]],
      pattern = "Normal"
    ), na.rm = TRUE) ~ "Normal",
    .default = NA_character_
  )

  if (is.na(max_stenosis_severity)) {
    severity_grp_bullets <- paste0(
      "* \"",
      c(
        "Normal", "Minimal", "Mild",
        "Moderate", "Severe", "Occluded"
      ),
      "\""
    ) |>
      glue::glue_collapse(sep = "\n")

    message <- glue::glue("
      Could not get max stenosis severity \\
      from input vessel data `vessel_data`, \\
      column `{stenosis_severity_grp_column}` \\
      as values are all empty. \\
      Ensure that column `{stenosis_severity_grp_column}` \\
      has at least one row with these severity group names.
      {severity_grp_bullets}
      ")

    warning(message, call. = TRUE, immediate. = FALSE)
  }

  return(max_stenosis_severity)
}

#' @title Summarise Vessel Segments Severity
#' @description Summarise vessel segments severity
#' by picking the highest level of stenosis severity
#' in the segments.
#' @param vessel_data Input coronary vessel data that
#' has only two columns `vessel_name_column` and
#' `stenosis_severity_grp_column`.
#' @param vessel_name_column Column in
#' `vessel_data` indicating the different vessel
#' segments.
#' @param stenosis_severity_grp_column Column in
#' `vessel_data` indicating the severity level of the
#' different coronary vessels. Accepted severity levels are
#' \itemize{
#'   \item Normal (0\% stenosis)
#'   \item Minimal (1 to 24\% stenosis)
#'   \item Mild (25 to 49\% stenosis)
#'   \item Moderate (50 to 69\% stenosis)
#'   \item Severe (70 to 99\% stenosis)
#'   \item Occluded (100\% stenosis)
#' }
#' @param vessel_segments_grp_name A text indicating
#' a group name for the vessel segments to be summarised.
#' Default: "LAD"
#' @param vessel_segments A character vector indicating
#' the vessel segments of interest to summarise. It
#' should be a value found in the column `vessel_name_column`.
#' Default: c("pLAD", "mLAD", "dLAD")
#' @return `vessel_data` with rows with the indicated
#' vessel segments in `vessel_segments` from column
#' `vessel_name_column` are removed. A new row with
#' the corresponding `vessel_segments_grp_name` and
#' summarised stenosis severity will be added.
#' @details From
#' \href{https://doi.org/10.1016/j.jcct.2022.07.002}{Cury et. al. (2022)},
#' the Society of Cardiovascular Computed Tomography (SCCT)
#' graded luminal stenosis as follows:
#' \itemize{
#'   \item Normal (0\% stenosis)
#'   \item Minimal (1 to 24\% stenosis)
#'   \item Mild (25 to 49\% stenosis)
#'   \item Moderate (50 to 69\% stenosis)
#'   \item Severe (70 to 99\% stenosis)
#'   \item Occluded (100\% stenosis)
#' }
#'
#' [get_max_stenosis_severity()] is used to obtain
#' the highest stenosis severity from the provided
#' vessel segments.
#'
#' @examples
#' occluded_vessel_segment_data <- tibble::tribble(
#'   ~coronary_vessel_segments, ~vessel_severity,
#'   "LM", "Normal",
#'   "pLAD", "Severe",
#'   "mLAD", "Minimal",
#'   "dLAD", "Occluded"
#' )
#'
#' stenosis_severity <- summarise_vessel_segments_severity(
#'   occluded_vessel_segment_data,
#'   "coronary_vessel_segments",
#'   "vessel_severity",
#'   "LAD",
#'   c("pLAD", "mLAD", "dLAD")
#' )
#'
#' stenosis_severity
#' @rdname summarise_vessel_segments_severity
#' @export
#' @importFrom rlang :=
summarise_vessel_segments_severity <- function(
    vessel_data,
    vessel_name_column,
    stenosis_severity_grp_column,
    vessel_segments_grp_name = "LAD",
    vessel_segments = c("pLAD", "mLAD", "dLAD")
) {
  vessel_segment_vec <- match(vessel_segments,
                              vessel_data[[vessel_name_column]])

  vessel_segment_vec <- vessel_segment_vec[!is.na(vessel_segment_vec)]

  if (isTRUE(length(vessel_segment_vec) == 0)) {

    vessel_segments_bullets <- paste0(
      "* \"",
      vessel_segments,
      "\""
    ) |>
      glue::glue_collapse(sep = "\n")

    message <- glue::glue("
      Could not get vessel_segments \\
      from input vessel data `vessel_data`, \\
      column `{vessel_name_column}`.
      Ensure that column `{vessel_name_column}` \\
      have these vessel_segments.
      {vessel_segments_bullets}
      ")

    warning(message, call. = TRUE, immediate. = FALSE)

    return(vessel_data)
  }

  first_vessel_segment_row <- vessel_segment_vec[1]

  vessel_segment_data <- vessel_data |>
    dplyr::slice(vessel_segment_vec)

  vessel_segment_severity <- vessel_segment_data |>
    get_max_stenosis_severity(
      stenosis_severity_grp_column = stenosis_severity_grp_column)

  vessel_data <- vessel_data |>
    dplyr::slice(-vessel_segment_vec) |>
    dplyr::add_row(
      !!vessel_name_column := vessel_segments_grp_name,
      !!stenosis_severity_grp_column := vessel_segment_severity,
      .before = first_vessel_segment_row
    )

  return(vessel_data)

}

#' @title Get number of vessels with high stenosis severity
#' @description Get the number of vessels with stenosis
#' severity of 50% or greater. Do note that LM is considered a vessel.
#' @param vessel_data Input coronary vessel data
#' @param vessel_name_column Column in
#' `vessel_data` indicating the different vessel
#' segments for LM, LAD, LCX and RCA.
#' @param stenosis_severity_grp_column Column in
#' `vessel_data` indicating the severity level of the
#' different coronary vessels. Accepted severity levels are
#' \itemize{
#'   \item Normal (0\% stenosis)
#'   \item Minimal (1 to 24\% stenosis)
#'   \item Mild (25 to 49\% stenosis)
#'   \item Moderate (50 to 69\% stenosis)
#'   \item Severe (70 to 99\% stenosis)
#'   \item Occluded (100\% stenosis)
#' }
#' @param lad_vessel_segments_grp_name Name of vessel
#' segment group to indicate left anterior descending
#' or LAD vessels.
#' Default: 'LAD'
#' @param lcx_vessel_segments_grp_name Name of vessel
#' segment group to indicate left circumflex
#' or LCX vessels.
#' Default: 'LCX'
#' @param rca_vessel_segments_grp_name Name of vessel
#' segment group to indicate right coronary artery
#' or RCA.
#' Default: 'RCA'
#' @param lad_vessel_segments Name of vessel
#' segments in the `vessel_name_column` to be
#' grouped as left anterior descending
#' or LAD vessels.
#' Default: c("pLAD", "mLAD", "dLAD", "Diag1",
#'            "Diag2", "Diag3", "Diag4",
#'            "Ramus1", "Ramus2")
#' @param lcx_vessel_segments Name of vessel
#' segments in the `vessel_name_column` to be
#' grouped as left circumflex
#' or LCX vessels.
#' Default: c("pLCX", "dLCX",
#'            "LPDA", "LPL",
#'            "OM1", "OM2", "OM3", "OM4", "OM5")
#' @param rca_vessel_segments Name of vessel
#' segments in the `vessel_name_column` to be
#' grouped as right coronary artery
#' or RCA.
#' Default: c("pRCA", "mRCA", "dRCA", "RPDA", "RPL")
#' @return An integer from 0 to 4
#' indicating the number of vessels with stenosis
#' severity of 50% or greater.
#' @details From
#' \href{https://doi.org/10.1016/j.jcct.2022.07.002}{Cury et. al. (2022)},
#' the Society of Cardiovascular Computed Tomography (SCCT)
#' graded luminal stenosis as follows:
#' \itemize{
#'   \item Normal (0\% stenosis)
#'   \item Minimal (1 to 24\% stenosis)
#'   \item Mild (25 to 49\% stenosis)
#'   \item Moderate (50 to 69\% stenosis)
#'   \item Severe (70 to 99\% stenosis)
#'   \item Occluded (100\% stenosis)
#' }
#' Do note that LM is considered a vessel.
#'
#' @examples
#' zero_vessel_disease_data <- tibble::tribble(
#'   ~coronary_vessel_segments, ~vessel_severity,
#'   "LM", "Normal",
#'   "pLAD", "Normal",
#'   "mLAD", "Normal",
#'   "dLAD", "Normal",
#'   "Diag1", "Normal",
#'   "Diag2", "Normal",
#'   "Ramus", "Normal",
#'   "pLCX", "Normal",
#'   "dLCX", "Normal",
#'   "OM1", "Normal",
#'   "OM2", "Normal",
#'   "pRCA", "Normal",
#'   "mRCA", "Normal",
#'   "dRCA", "Normal",
#'   "RPDA", "Normal",
#'   "RPL", "Normal")
#'
#' four_vessel_disease_data <- tibble::tribble(
#'   ~coronary_vessel_segments, ~vessel_severity,
#'   "LM", "Severe",
#'   "pLAD", "Severe",
#'   "mLAD", "Minimal",
#'   "dLAD", "Occluded",
#'   "Diag1", "Normal",
#'   "Diag2", "Normal",
#'   "Diag3", "Normal",
#'   "Diag4", "Normal",
#'   "pLCX", "Moderate",
#'   "dLCX", "Moderate",
#'   "OM1", "Normal",
#'   "OM2", "Normal",
#'   "pRCA", "Normal",
#'   "mRCA", "Severe",
#'   "dRCA", "Mild",
#'   "RPDA", "Normal",
#'   "RPL", "Normal")
#'
#'  zero_disease_vessel <- get_number_of_vessels_with_high_stenosis_severity(
#'    vessel_data = zero_vessel_disease_data,
#'    vessel_name_column = "coronary_vessel_segments",
#'    stenosis_severity_grp_column = "vessel_severity",
#'    lad_vessel_segments_grp_name = "LAD",
#'    lcx_vessel_segments_grp_name = "LCX",
#'    rca_vessel_segments_grp_name = "RCA",
#'    lad_vessel_segments = c("pLAD", "mLAD", "dLAD",
#'                            "Diag1", "Diag2", "Ramus"),
#'    lcx_vessel_segments = c("pLCX", "dLCX", "OM1", "OM2"),
#'    rca_vessel_segments = c("pRCA", "mRCA", "dRCA", "RPDA", "RPL")
#'    )
#'
#'  four_disease_vessels <- get_number_of_vessels_with_high_stenosis_severity(
#'    vessel_data = four_vessel_disease_data,
#'    vessel_name_column = "coronary_vessel_segments",
#'    stenosis_severity_grp_column = "vessel_severity",
#'    lad_vessel_segments_grp_name = "LAD",
#'    lcx_vessel_segments_grp_name = "LCX",
#'    rca_vessel_segments_grp_name = "RCA",
#'    lad_vessel_segments = c("pLAD", "mLAD", "dLAD",
#'                            "Diag1", "Diag2", "Ramus"),
#'    lcx_vessel_segments = c("pLCX", "dLCX", "OM1", "OM2"),
#'    rca_vessel_segments = c("pRCA", "mRCA", "dRCA", "RPDA", "RPL")
#'    )
#'
#'  zero_disease_vessel
#'
#'  four_disease_vessels
#'
#' @rdname get_number_of_vessels_with_high_stenosis_severity
#' @export
get_number_of_vessels_with_high_stenosis_severity <-  function(
    vessel_data,
    vessel_name_column,
    stenosis_severity_grp_column,
    lad_vessel_segments_grp_name = "LAD",
    lcx_vessel_segments_grp_name = "LCX",
    rca_vessel_segments_grp_name = "RCA",
    lad_vessel_segments = c("pLAD", "mLAD", "dLAD",
                            "Diag1", "Diag2", "Diag3", "Diag4",
                            "Ramus1", "Ramus2"),
    lcx_vessel_segments = c("pLCX", "dLCX",
                            "LPDA", "LPL",
                            "OM1", "OM2", "OM3", "OM4", "OM5"),
    rca_vessel_segments = c("pRCA", "mRCA", "dRCA",
                            "RPDA", "RPL")
) {

  vessel_data <- vessel_data |>
    summarise_vessel_segments_severity(
      vessel_name_column = vessel_name_column,
      stenosis_severity_grp_column = stenosis_severity_grp_column,
      vessel_segments_grp_name = lad_vessel_segments_grp_name,
      vessel_segments = lad_vessel_segments
    ) |>
    summarise_vessel_segments_severity(
      vessel_name_column = vessel_name_column,
      stenosis_severity_grp_column = stenosis_severity_grp_column,
      vessel_segments_grp_name = lcx_vessel_segments_grp_name,
      vessel_segments = lcx_vessel_segments
    ) |>
    summarise_vessel_segments_severity(
      vessel_name_column = vessel_name_column,
      stenosis_severity_grp_column = stenosis_severity_grp_column,
      vessel_segments_grp_name = rca_vessel_segments_grp_name,
      vessel_segments = rca_vessel_segments
    )

  stenosis_severity_grp_vec <- vessel_data[[stenosis_severity_grp_column]]

  number_of_occluded <- stenosis_severity_grp_vec |>
    stringr::str_count(pattern = "\\bOccluded\\b") |>
    sum(na.rm = TRUE)

  number_of_severe <- stenosis_severity_grp_vec |>
    stringr::str_count(pattern = "\\bSevere\\b") |>
    sum(na.rm = TRUE)

  number_of_moderate <- stenosis_severity_grp_vec |>
    stringr::str_count(pattern = "\\bModerate\\b") |>
    sum(na.rm = TRUE)

  number_of_vessel_severity <- c(number_of_occluded,
                                 number_of_severe,
                                 number_of_moderate) |>
    sum(na.rm = TRUE)

  return(number_of_vessel_severity)

}

#' @title Get Number Of Vessels With High Stenosis Severity (Excluding LM)
#' @description Get the number of vessels with stenosis
#' severity of 50% or greater. Do note that LM is not considered as a vessel.
#' @param vessel_data Input coronary vessel data
#' @param vessel_name_column Column in
#' `vessel_data` indicating the different vessel
#' segments for LM, LAD, LCX and RCA.
#' @param stenosis_severity_grp_column Column in
#' `vessel_data` indicating the severity level of the
#' different coronary vessels. Accepted severity levels are
#' \itemize{
#'   \item Normal (0\% stenosis)
#'   \item Minimal (1 to 24\% stenosis)
#'   \item Mild (25 to 49\% stenosis)
#'   \item Moderate (50 to 69\% stenosis)
#'   \item Severe (70 to 99\% stenosis)
#'   \item Occluded (100\% stenosis)
#' }
#' @param lad_vessel_segments_grp_name Name of vessel
#' segment group to indicate left anterior descending
#' or LAD vessels.
#' Default: 'LAD'
#' @param lcx_vessel_segments_grp_name Name of vessel
#' segment group to indicate left circumflex
#' or LCX vessels.
#' Default: 'LCX'
#' @param rca_vessel_segments_grp_name Name of vessel
#' segment group to indicate right coronary artery
#' or RCA.
#' Default: 'RCA'
#' @param lad_vessel_segments Name of vessel
#' segments in the `vessel_name_column` to be
#' grouped as left anterior descending
#' or LAD vessels.
#' Default: c("pLAD", "mLAD", "dLAD", "Diag1",
#'            "Diag2", "Diag3", "Diag4",
#'            "Ramus1", "Ramus2")
#' @param lcx_vessel_segments Name of vessel
#' segments in the `vessel_name_column` to be
#' grouped as left circumflex
#' or LCX vessels.
#' Default: c("pLCX", "dLCX",
#'            "LPDA", "LPL",
#'            "OM1", "OM2", "OM3", "OM4", "OM5")
#' @param rca_vessel_segments Name of vessel
#' segments in the `vessel_name_column` to be
#' grouped as right coronary artery
#' or RCA.
#' Default: c("pRCA", "mRCA", "dRCA", "RPDA", "RPL")
#' @return An integer from 0 to 3
#' indicating the number of vessels with stenosis
#' severity of 50% or greater.
#' @details From
#' \href{https://doi.org/10.1016/j.jcct.2022.07.002}{Cury et. al. (2022)},
#' the Society of Cardiovascular Computed Tomography (SCCT)
#' graded luminal stenosis as follows:
#' \itemize{
#'   \item Normal (0\% stenosis)
#'   \item Minimal (1 to 24\% stenosis)
#'   \item Mild (25 to 49\% stenosis)
#'   \item Moderate (50 to 69\% stenosis)
#'   \item Severe (70 to 99\% stenosis)
#'   \item Occluded (100\% stenosis)
#' }
#' Do note that LM is not considered as a vessel.
#'
#' @examples
#' zero_vessel_disease_data <- tibble::tribble(
#'   ~coronary_vessel_segments, ~vessel_severity,
#'   "LM", "Normal",
#'   "pLAD", "Normal",
#'   "mLAD", "Normal",
#'   "dLAD", "Normal",
#'   "Diag1", "Normal",
#'   "Diag2", "Normal",
#'   "Ramus", "Normal",
#'   "pLCX", "Normal",
#'   "dLCX", "Normal",
#'   "OM1", "Normal",
#'   "OM2", "Normal",
#'   "pRCA", "Normal",
#'   "mRCA", "Normal",
#'   "dRCA", "Normal",
#'   "RPDA", "Normal",
#'   "RPL", "Normal")
#'
#' four_vessel_disease_data <- tibble::tribble(
#'   ~coronary_vessel_segments, ~vessel_severity,
#'   "LM", "Severe",
#'   "pLAD", "Severe",
#'   "mLAD", "Minimal",
#'   "dLAD", "Occluded",
#'   "Diag1", "Normal",
#'   "Diag2", "Normal",
#'   "Diag3", "Normal",
#'   "Diag4", "Normal",
#'   "pLCX", "Moderate",
#'   "dLCX", "Moderate",
#'   "OM1", "Normal",
#'   "OM2", "Normal",
#'   "pRCA", "Normal",
#'   "mRCA", "Severe",
#'   "dRCA", "Mild",
#'   "RPDA", "Normal",
#'   "RPL", "Normal")
#'
#'  zero_disease_vessel <- get_number_of_vessels_with_high_stenosis_severity_exclude_LM(
#'    vessel_data = zero_vessel_disease_data,
#'    vessel_name_column = "coronary_vessel_segments",
#'    stenosis_severity_grp_column = "vessel_severity",
#'    lad_vessel_segments_grp_name = "LAD",
#'    lcx_vessel_segments_grp_name = "LCX",
#'    rca_vessel_segments_grp_name = "RCA",
#'    lad_vessel_segments = c("pLAD", "mLAD", "dLAD",
#'                            "Diag1", "Diag2", "Ramus"),
#'    lcx_vessel_segments = c("pLCX", "dLCX", "OM1", "OM2"),
#'    rca_vessel_segments = c("pRCA", "mRCA", "dRCA", "RPDA", "RPL")
#'    )
#'
#'  four_disease_vessels <- get_number_of_vessels_with_high_stenosis_severity_exclude_LM(
#'    vessel_data = four_vessel_disease_data,
#'    vessel_name_column = "coronary_vessel_segments",
#'    stenosis_severity_grp_column = "vessel_severity",
#'    lad_vessel_segments_grp_name = "LAD",
#'    lcx_vessel_segments_grp_name = "LCX",
#'    rca_vessel_segments_grp_name = "RCA",
#'    lad_vessel_segments = c("pLAD", "mLAD", "dLAD",
#'                            "Diag1", "Diag2", "Ramus"),
#'    lcx_vessel_segments = c("pLCX", "dLCX", "OM1", "OM2"),
#'    rca_vessel_segments = c("pRCA", "mRCA", "dRCA", "RPDA", "RPL")
#'    )
#'
#'  zero_disease_vessel
#'
#'  four_disease_vessels
#'
#' @rdname get_number_of_vessels_with_high_stenosis_severity_exclude_LM
#' @export
get_number_of_vessels_with_high_stenosis_severity_exclude_LM <-  function(
    vessel_data,
    vessel_name_column,
    stenosis_severity_grp_column,
    lad_vessel_segments_grp_name = "LAD",
    lcx_vessel_segments_grp_name = "LCX",
    rca_vessel_segments_grp_name = "RCA",
    lad_vessel_segments = c("pLAD", "mLAD", "dLAD",
                            "Diag1", "Diag2", "Diag3", "Diag4",
                            "Ramus1", "Ramus2"),
    lcx_vessel_segments = c("pLCX", "dLCX",
                            "LPDA", "LPL",
                            "OM1", "OM2", "OM3", "OM4", "OM5"),
    rca_vessel_segments = c("pRCA", "mRCA", "dRCA",
                            "RPDA", "RPL")
) {

  lad_vessel_data <- vessel_data |>
    dplyr::filter(
      .data[[vessel_name_column]] %in% lad_vessel_segments
    ) |>
    summarise_vessel_segments_severity(
      vessel_name_column = vessel_name_column,
      stenosis_severity_grp_column = stenosis_severity_grp_column,
      vessel_segments_grp_name = lad_vessel_segments_grp_name,
      vessel_segments = lad_vessel_segments
    )

  lcx_vessel_data <- vessel_data |>
    dplyr::filter(
      .data[[vessel_name_column]] %in% lcx_vessel_segments
    ) |>
    summarise_vessel_segments_severity(
      vessel_name_column = vessel_name_column,
      stenosis_severity_grp_column = stenosis_severity_grp_column,
      vessel_segments_grp_name = lcx_vessel_segments_grp_name,
      vessel_segments = lcx_vessel_segments
    )

  rca_vessel_data <- vessel_data |>
    dplyr::filter(
      .data[[vessel_name_column]] %in% rca_vessel_segments
    ) |>
    summarise_vessel_segments_severity(
      vessel_name_column = vessel_name_column,
      stenosis_severity_grp_column = stenosis_severity_grp_column,
      vessel_segments_grp_name = rca_vessel_segments_grp_name,
      vessel_segments = rca_vessel_segments
    )

  three_vessel_data <- dplyr::bind_rows(
    lad_vessel_data,
    lcx_vessel_data,
    rca_vessel_data
  )

  stenosis_severity_grp_vec <- three_vessel_data[[stenosis_severity_grp_column]]

  number_of_occluded <- stenosis_severity_grp_vec |>
    stringr::str_count(pattern = "\\bOccluded\\b") |>
    sum(na.rm = TRUE)

  number_of_severe <- stenosis_severity_grp_vec |>
    stringr::str_count(pattern = "\\bSevere\\b") |>
    sum(na.rm = TRUE)

  number_of_moderate <- stenosis_severity_grp_vec |>
    stringr::str_count(pattern = "\\bModerate\\b") |>
    sum(na.rm = TRUE)

  number_of_vessel_severity <- c(number_of_occluded,
                                 number_of_severe,
                                 number_of_moderate) |>
    sum(na.rm = TRUE)

  return(number_of_vessel_severity)

}

#' @title View Stenosis Summary
#' @description A wrapper function to display an
#' interactive table to see stenosis summary.
#' @param input_stenosis_summary Input stenosis summary.
#' It should contain one nested column representing a list
#' of stenosis data sets.
#' @param stenosis_data_column Input nested column name
#' from `input_stenosis_summary` indicating the
#' stenosis data sets.
#' @param download_file_name Name of the stenosis
#' summary csv file when the download button is clicked.
#' Default: stenosis_summarised_results
#' @return An interactive table of `input_stenosis_summary`
#' @examples
#' zero_vessel_disease_data <- tibble::tribble(
#'   ~coronary_vessel_segments, ~vessel_severity,
#'   "LM", "Normal",
#'   "pLAD", "Normal",
#'   "mLAD", "Normal",
#'   "dLAD", "Normal",
#'   "Diag1", "Normal",
#'   "Diag2", "Normal",
#'   "Ramus", "Normal",
#'   "pLCX", "Normal",
#'   "dLCX", "Normal",
#'   "OM1", "Normal",
#'   "OM2", "Normal",
#'   "pRCA", "Normal",
#'   "mRCA", "Normal",
#'   "dRCA", "Normal",
#'   "RPDA", "Normal",
#'   "RPL", "Normal")
#'
#' three_vessel_disease_data <- tibble::tribble(
#'   ~coronary_vessel_segments, ~vessel_severity,
#'   "LM", "Normal",
#'   "pLAD", "Severe",
#'   "mLAD", "Minimal",
#'   "dLAD", "Occluded",
#'   "Diag1", "Normal",
#'   "Diag2", "Normal",
#'   "Ramus", "Normal",
#'   "pLCX", "Moderate",
#'   "dLCX", "Moderate",
#'   "OM1", "Normal",
#'   "OM2", "Normal",
#'   "pRCA", "Normal",
#'   "mRCA", "Severe",
#'   "dRCA", "Mild",
#'   "RPDA", "Normal",
#'   "RPL", "Normal")
#'
#' stenosis_summary <- tibble::tibble(
#'   unique_id = c("1", "2"),
#'   stenosis_data = list(zero_vessel_disease_data,
#'                        three_vessel_disease_data),
#'   number_of_vessel_disease = c(0, 3)
#' )
#'
#' stenosis_table <- stenosis_summary |>
#'   view_stenosis_summary(
#'     stenosis_data_column = "stenosis_data"
#'   )
#' @rdname view_stenosis_summary
#' @export
view_stenosis_summary <- function(
    input_stenosis_summary,
    stenosis_data_column,
    download_file_name = "stenosis_summarised_results"
) {

  input_stenosis_summary <- input_stenosis_summary |>
    dplyr::mutate(
      dplyr::across(dplyr::where(is.factor),
                    ~ forcats::fct_na_value_to_level(.x, ""))
    )

  # Ensure file name is valid
  download_file_name <- download_file_name |>
    fs::path_sanitize()

  # Ensure that the element id is unique
  # Need some testing if it works
  reactable_element_id <- "reactable" |>
    paste(fs::path_file(fs::file_temp(pattern = "")),
          sep = "-")

  csv_download_file_name <- download_file_name |>
    paste0(".csv")
  reactable_api_command <- glue::glue(
    "Reactable.downloadDataCSV('{reactable_element_id}', \\
    '{csv_download_file_name}')"
  )
  stenosis_data_list <- input_stenosis_summary[[stenosis_data_column]]

  stenosis_data_column <- tibble::lst(
    !!stenosis_data_column := reactable::colDef(
      details = function(row_index) {
        htmltools::div(
          style = "padding: 1rem",
          reactable::reactable(
            data = stenosis_data_list[row_index][[1]],
            filterable = TRUE,
            defaultPageSize = 5)
        )
      }
    )
  )

  filter_list <- tibble::lst()

  factor_columns <- input_stenosis_summary |>
    dplyr::select_if(is.factor) |>
    names()

  if (length(factor_columns) != 0) {
    for (factor_column in factor_columns) {
      new_list = tibble::lst(
        !!factor_column := reactable::colDef(
          filterInput = create_dropdown_filter_render_function(reactable_element_id),
          # Exact match filter method
          filterMethod = reactable::JS("(rows, columnId, filterValue) => {
        return rows.filter(row => row.values[columnId] === filterValue)
      }")
        )
      )
      filter_list <- filter_list |>
        append(new_list)
    }
  } else {
    filter_list <- NULL
  }

  filter_list <- filter_list |>
    append(stenosis_data_column)


  stenosis_results_table <- input_stenosis_summary |>
    reactable::reactable(
      columns = filter_list,
      filterable = TRUE,
      defaultPageSize = 5,
      paginationType = "jump",
      elementId = reactable_element_id
    )

  results_table <- htmltools::browsable(
    htmltools::tagList(
      stenosis_results_table,
      htmltools::tags$button(
        htmltools::tagList(fontawesome::fa("download"),
                           "Download as CSV"),
        onclick = reactable_api_command
      )
    )
  )

  return(results_table)

}
