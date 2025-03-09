test_that("write_to_sheet works", {

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

  # Create a new workbook
  my_workbook <- openxlsx::createWorkbook()

  sheet_name <- c("vessel disease")
  output_data <- vessel_disease_data

  testthat::expect_silent(
    write_to_sheet(sheet_name = sheet_name,
                   data = output_data,
                   workbook = my_workbook)
  )

  testthat::expect_equal(my_workbook$sheet_names[1], "vessel disease")

  rm(my_workbook)

})
