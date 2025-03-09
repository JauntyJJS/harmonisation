test_that("reactable_with_download_csv_button works", {

  medical_data <- tibble::tribble(
    ~unique_id, ~medications, ~medication_fixed,
    "1", "Medication 1", "Fixed Medication 1",
    "2", "Medication 2", "Fixed Medication 2"
  ) |>
    dplyr::mutate(
      unique_id = as.factor(.data[["unique_id"]])
    )

  medical_table <- medical_data |>
    reactable_with_download_csv_button(
      download_file_name = "medical_data"
    )

  filter_function_text <- paste0(
    "function(_e){(function(event){Reactable.setFilter('medical_data-download-table', ",
    "'unique_id', event.target.value || undefined)}).apply(event.target,[_e])}"
  )

  # Test if filter drop down box is presence
  testthat::expect_true(
    medical_table[[1]]$x$tag$attribs$columns[[1]]$filterInput$children[[1]]$attribs$value |>
      stringr::str_detect(
        pattern = "__ALL__"
      )
  )

  # Test if download button exists and has the correct file name
  testthat::expect_true(
    medical_table[[2]]$attribs$onclick |>
      stringr::str_detect(
        pattern = "Reactable.downloadDataCSV\\('reactable-.*', 'medical_data.csv'\\)"
      )
  )

})
