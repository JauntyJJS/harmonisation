##TODO understand snapshots

test_that("get_max_stenosis_severity works with occluded vessels", {
  occluded_coronary_vessel_data <- tibble::tribble(
    ~coronary_vessel, ~vessel_severity,
    "LM", "Normal",
    "LAD", "Severe",
    "LCX", "Minimal",
    "RCA", "Occluded"
  )

  max_stenosis_severity <- get_max_stenosis_severity(
    vessel_data = occluded_coronary_vessel_data,
    stenosis_severity_grp_column = "vessel_severity"
  )

  testthat::expect_equal(max_stenosis_severity, "Occluded")
})

test_that("get_max_stenosis_severity works with severe vessels", {
  severe_coronary_vessel_data <- tibble::tribble(
    ~coronary_vessel, ~vessel_severity,
    "LM", "Normal",
    "LAD", "Severe",
    "LCX", "Minimal",
    "RCA", "Moderate"
  )

  max_stenosis_severity <- get_max_stenosis_severity(
    vessel_data = severe_coronary_vessel_data,
    stenosis_severity_grp_column = "vessel_severity"
  )

  testthat::expect_equal(max_stenosis_severity, "Severe")
})

test_that("get_max_stenosis_severity works with moderate vessels", {
  moderate_coronary_vessel_data <- tibble::tribble(
    ~coronary_vessel, ~vessel_severity,
    "LM", "Moderate",
    "LAD", "Mild",
    "LCX", "Mild",
    "RCA", "Moderate"
  )

  max_stenosis_severity <- get_max_stenosis_severity(
    vessel_data = moderate_coronary_vessel_data,
    stenosis_severity_grp_column = "vessel_severity"
  )

  testthat::expect_equal(max_stenosis_severity, "Moderate")
})

test_that("get_max_stenosis_severity works with mild vessels", {
  mild_coronary_vessel_data <- tibble::tribble(
    ~coronary_vessel, ~vessel_severity,
    "LM", "Minimal",
    "LAD", "Mild",
    "LCX", "Normal",
    "RCA", "Normal"
  )

  max_stenosis_severity <- get_max_stenosis_severity(
    vessel_data = mild_coronary_vessel_data,
    stenosis_severity_grp_column = "vessel_severity"
  )

  testthat::expect_equal(max_stenosis_severity, "Mild")
})

test_that("get_max_stenosis_severity works with minimal vessels", {
  minimal_coronary_vessel_data <- tibble::tribble(
    ~coronary_vessel, ~vessel_severity,
    "LM", "Normal",
    "LAD", "Normal",
    "LCX", "Normal",
    "RCA", "Minimal"
  )

  max_stenosis_severity <- get_max_stenosis_severity(
    vessel_data = minimal_coronary_vessel_data,
    stenosis_severity_grp_column = "vessel_severity"
  )

  testthat::expect_equal(max_stenosis_severity, "Minimal")
})

test_that("get_max_stenosis_severity works with normal vessels", {
  normal_coronary_vessel_data <- tibble::tribble(
    ~coronary_vessel, ~vessel_severity,
    "LM", "Normal",
    "LAD", "Normal",
    "LCX", "Normal",
    "RCA", "Normal"
  )

  max_stenosis_severity <- get_max_stenosis_severity(
    vessel_data = normal_coronary_vessel_data,
    stenosis_severity_grp_column = "vessel_severity"
  )

  testthat::expect_equal(max_stenosis_severity, "Normal")
})

test_that("get_max_stenosis_severity works
          with some missing severity", {
  some_missing_vessel_data <-
    tibble::tribble(
      ~ coronary_vessel, ~ vessel_severity,
      "LM", "Normal",
      "LAD", NA,
      "LCX", "Normal",
      "RCA", "Normal"
  )

  max_stenosis_severity <- get_max_stenosis_severity(
    vessel_data = some_missing_vessel_data,
    stenosis_severity_grp_column = "vessel_severity"
  )

  testthat::expect_equal(max_stenosis_severity, "Normal")
})

test_that("get_max_stenosis_severity works with all missing severity", {
  all_missing_vessel_data <-
    tibble::tribble(
      ~ coronary_vessel, ~ vessel_severity,
      "LM", "",
      "LAD", NA,
      "LCX", NA,
      "RCA", NA
  )

  testthat::expect_snapshot(
    max_stenosis_severity <- get_max_stenosis_severity(
      vessel_data = all_missing_vessel_data,
      stenosis_severity_grp_column = "vessel_severity"
    )
  )

  testthat::expect_equal(max_stenosis_severity, NA_character_)
})

test_that("summarise_vessel_segments_severity
          works with valid data", {

  occluded_vessel_segment_data <- tibble::tribble(
    ~coronary_vessel_segments, ~vessel_severity,
    "LM", "Normal",
    "pLAD", "Severe",
    "mLAD", "Minimal",
    "dLAD", "Occluded"
  )

  expected_vessel_data <- tibble::tribble(
    ~coronary_vessel_segments, ~vessel_severity,
    "LM", "Normal",
    "LAD", "Occluded"
  )

  stenosis_severity <- summarise_vessel_segments_severity(
    occluded_vessel_segment_data,
    "coronary_vessel_segments",
    "vessel_severity",
    "LAD",
    c("pLAD", "mLAD", "dLAD")
  )

  testthat::expect_identical(stenosis_severity, expected_vessel_data)

})

test_that("summarise_vessel_segments_severity
          works with all missing data", {

  missing_vessel_segment_data <- tibble::tribble(
    ~ coronary_vessel_segments, ~ vessel_severity,
    "LM", "",
    "pLAD", NA,
    "mLAD", NA,
    "dLAD", ""
  )

  expected_vessel_data <- tibble::tribble(
    ~ coronary_vessel_segments, ~ vessel_severity,
    "LM", "",
    "LAD", NA
  )

  stenosis_severity <- summarise_vessel_segments_severity(
    missing_vessel_segment_data,
    "coronary_vessel_segments",
    "vessel_severity",
    "LAD",
    c("pLAD", "mLAD", "dLAD")
  ) |>
    suppressWarnings()

  testthat::expect_identical(stenosis_severity,
                             expected_vessel_data)

})

test_that("summarise_vessel_segments_severity
          works with invalid vessels", {

  invalid_vessel_segment_data <- tibble::tribble(
    ~ coronary_vessel_segments, ~ vessel_severity,
    "pLCX", "Minimal",
    "dLCX", "Normal"
  )

  stenosis_severity <- summarise_vessel_segments_severity(
    invalid_vessel_segment_data,
    "coronary_vessel_segments",
    "vessel_severity",
    "LAD",
    c("pLAD", "mLAD", "dLAD")
  ) |>
    suppressWarnings()

  testthat::expect_identical(stenosis_severity,
                             invalid_vessel_segment_data)

})

test_that("get_number_of_vessels_with_high_stenosis_severity
           works with three vessel disease data", {

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

  one_vessel_disease_data <- tibble::tribble(
    ~coronary_vessel_segments, ~vessel_severity,
    "LM", "Normal",
    "pLAD", "Normal",
    "mLAD", "Minimal",
    "dLAD", "Minimal",
    "Diag1", "Normal",
    "Diag2", "Normal",
    "Ramus", "Normal",
    "pLCX", "Normal",
    "dLCX", "Normal",
    "OM1", "Normal",
    "OM2", "Normal",
    "pRCA", "Normal",
    "mRCA", "Normal",
    "dRCA", "Severe",
    "RPDA", "Normal",
    "RPL", "Normal")

  two_vessel_disease_data <- tibble::tribble(
    ~coronary_vessel_segments, ~vessel_severity,
    "LM", "Moderate",
    "pLAD", "Normal",
    "mLAD", "Minimal",
    "dLAD", "Minimal",
    "Diag1", "Normal",
    "Diag2", "Normal",
    "Ramus", "Normal",
    "pLCX", "Severe",
    "dLCX", "Severe",
    "OM1", "Normal",
    "OM2", "Normal",
    "pRCA", "Normal",
    "mRCA", "Mild",
    "dRCA", "Mild",
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

  one_disease_vessel <- get_number_of_vessels_with_high_stenosis_severity(
    vessel_data = one_vessel_disease_data,
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

  two_disease_vessels <- get_number_of_vessels_with_high_stenosis_severity(
    vessel_data = two_vessel_disease_data,
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

  three_disease_vessels <- get_number_of_vessels_with_high_stenosis_severity(
    vessel_data = three_vessel_disease_data,
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

  testthat::expect_equal(zero_disease_vessel, 0)
  testthat::expect_equal(one_disease_vessel, 1)
  testthat::expect_equal(two_disease_vessels, 2)
  testthat::expect_equal(three_disease_vessels, 3)
  testthat::expect_equal(four_disease_vessels, 4)

})

test_that("get_number_of_vessels_with_high_stenosis_severity_exclude_LM works", {

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

  one_vessel_disease_data <- tibble::tribble(
    ~coronary_vessel_segments, ~vessel_severity,
    "LM", "Normal",
    "pLAD", "Normal",
    "mLAD", "Minimal",
    "dLAD", "Minimal",
    "Diag1", "Normal",
    "Diag2", "Normal",
    "Ramus", "Normal",
    "pLCX", "Normal",
    "dLCX", "Normal",
    "OM1", "Normal",
    "OM2", "Normal",
    "pRCA", "Normal",
    "mRCA", "Normal",
    "dRCA", "Severe",
    "RPDA", "Normal",
    "RPL", "Normal")

  two_vessel_disease_data <- tibble::tribble(
    ~coronary_vessel_segments, ~vessel_severity,
    "LM", "Mild",
    "pLAD", "Normal",
    "mLAD", "Minimal",
    "dLAD", "Minimal",
    "Diag1", "Normal",
    "Diag2", "Normal",
    "Ramus", "Normal",
    "pLCX", "Severe",
    "dLCX", "Severe",
    "OM1", "Normal",
    "OM2", "Normal",
    "pRCA", "Normal",
    "mRCA", "Moderate",
    "dRCA", "Moderate",
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

  zero_disease_vessel <- get_number_of_vessels_with_high_stenosis_severity_exclude_LM(
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

  one_disease_vessel <- get_number_of_vessels_with_high_stenosis_severity_exclude_LM(
    vessel_data = one_vessel_disease_data,
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

  two_disease_vessels <- get_number_of_vessels_with_high_stenosis_severity_exclude_LM(
    vessel_data = two_vessel_disease_data,
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

  three_disease_vessels <- get_number_of_vessels_with_high_stenosis_severity_exclude_LM(
    vessel_data = three_vessel_disease_data,
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

  four_disease_vessels <- get_number_of_vessels_with_high_stenosis_severity_exclude_LM(
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

  testthat::expect_equal(zero_disease_vessel, 0)
  testthat::expect_equal(one_disease_vessel, 1)
  testthat::expect_equal(two_disease_vessels, 2)
  testthat::expect_equal(three_disease_vessels, 3)
  # Should still be 3 as LM is ignored
  testthat::expect_equal(four_disease_vessels, 3)

})

test_that("view_stenosis_summary works", {

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
    stenosis_data = list(three_vessel_disease_data,
                         zero_vessel_disease_data),
    number_of_vessel_disease = forcats::fct(x = c("3", "0"),
                                            levels = c("0", "1", "2", "3"))
  )

  stenosis_table <- stenosis_summary |>
    view_stenosis_summary(
      stenosis_data_column = "stenosis_data"
    )

  # Test if the number_of_vessel_disease has a drop down in this order "All", "0", "3"

  testthat::expect_equal(
    c(
      stenosis_table[[1]]$x$tag$attribs$columns[[3]]$filterInput$children[[1]]$children[[1]],
      stenosis_table[[1]]$x$tag$attribs$columns[[3]]$filterInput$children[[2]]$children[[1]],
      stenosis_table[[1]]$x$tag$attribs$columns[[3]]$filterInput$children[[3]]$children[[1]]
    ),
    c("All", "0", "3")
  )

  testthat::expect_true(
    stenosis_table[[1]]$x$tag$attribs$columns[[3]]$filterInput$children[[3]]$children |>
      stringr::str_detect(
        pattern = "3"
      )
  )

  # Test if download button exists and has the correct file name
  testthat::expect_true(
    stenosis_table[[2]]$attribs$onclick |>
      stringr::str_detect(
        pattern = "Reactable.downloadDataCSV\\('reactable-.*', 'stenosis_summarised_results.csv'\\)"
      )
  )

})
