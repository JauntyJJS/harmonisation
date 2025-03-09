#' @title Add Cohort Name
#' @description Add cohort name as a new column
#' in the dataset and move it to the first column.
#' @param input_data The input data as a
#' data frame or tibble.
#' @param cohort_name A text indicating the name of
#' the cohort
#' @param cohort_name_column A text indicating the
#' column name used to represent the name of the cohort.
#' Default: 'cohort_name'
#' @return A data frame with a new column called
#' the input text from`cohort_name_column` containing
#' a character vector of the input text from `cohort_name`.
#' @details An error will be raised if input
#' `cohort_name_column` is already a column name
#' in `input_data`. Currently, no overriding of
#' columns is allowed.
#' @examples
#'
#' input_data <- tibble::tribble(
#'   ~column_a, ~column_b,
#'   1, "Yes",
#'   1, "No")
#'
#' cohort_name = "Cohort 1"
#'
#' result_data <- input_data |>
#'   add_cohort_name(cohort_name = "Cohort 1",
#'                   cohort_name_column = "cohorts")
#'
#' result_data
#'
#' @rdname add_cohort_name
#' @export
add_cohort_name <- function(input_data, cohort_name,
                            cohort_name_column = "cohort_name") {

  # Try out https://cli.r-lib.org/reference/test_that_cli.html

  if (cohort_name_column %in% colnames(input_data)) {
    glue::glue("
     Input cohort_name_column: {cohort_name_column} cannot\\
     be used as {cohort_name_column} is also a column name\\
     in the input data.
    ") |>
      cli::cli_abort()
  }

  input_data <- input_data |>
    dplyr::mutate(!!cohort_name_column := cohort_name) |>
    dplyr::relocate(dplyr::all_of(c(cohort_name_column)))

  return(input_data)

}
