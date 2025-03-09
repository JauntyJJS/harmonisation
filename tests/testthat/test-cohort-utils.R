test_that("add_cohort_name works", {

  input_data <- tibble::tribble(
    ~column_a, ~column_b,
    1, "Yes",
    1, "No",
  )

  cohort_name <- "Cohort 1"

  result_data <- input_data |>
    add_cohort_name(cohort_name = "Cohort 1",
                    cohort_name_column = "cohorts")

  testthat::expect_true(
    "cohorts" %in% colnames(result_data)
  )

  testthat::expect_error(
    input_data |>
      add_cohort_name(cohort_name = "Cohort 1",
                      cohort_name_column = "column_a")
  )

  testthat::expect_snapshot(
    input_data |>
      add_cohort_name(cohort_name = "Cohort 1",
                      cohort_name_column = "column_a"),
    error = TRUE
  )

})
