#' @title Calculate Column Maximum Character
#' @description Calculate the maximum number of
#' characters for each column in the input data frame
#' or tibble, including the column name.
#' @param data Input tibble or data frame.
#' @return A numeric vector each value indicated the
#' maximum number of characters for each column of the
#' input data frame or tibble.
#' @examples
#' coronary_vessel_segments <- c(
#'   "LM", "pLAD", "mLAD", "dLAD",
#'   "pLCX", "dLCX", "pRCA", "mRCA", "dRCA"
#' )
#'
#' vessel_severity <- c(
#'   "Severe", "Severe", "Minimal", "Occluded",
#'   "Moderate", "Moderate", "Normal", "Severe", "Mild"
#' )
#'
#'
#' vessel_disease_data <- data.frame(
#'   coronary_vessel_segments = coronary_vessel_segments,
#'   vessel_severity = vessel_severity
#' )
#'
#' column_max_char <- calculate_column_max_char(vessel_disease_data)
#'
#' column_max_char
#'
#' @rdname calculate_column_max_char
#' @export
calculate_column_max_char <- function(data) {

  # Convert factor columns to type character
  # as nchar gives an error if a input vector
  # is of type factor
  data <- data |>
    dplyr::mutate_if(is.factor, is.character)

  # Start with an empty vector
  column_max_char_vector <- c()

  for (i in seq_len(ncol(data))) {
    # For each column

    # Get the number of char for the column name
    column_name_char <- colnames(data)[i] |>
      nchar()

    # Get the number of char for each data in the column
    data_char <- data[, i, drop = TRUE] |>
      nchar()

    # Get the maximun number of char and append
    longest_char <- max(data_char, column_name_char,
                        na.rm = TRUE
    )

    column_max_char_vector <- c(
      column_max_char_vector,
      longest_char
    )
  }

  return(column_max_char_vector)
}

#' @title Write To Excel Sheet
#' @description Write data to an excel sheet.
#' @param sheet_name A vector of characters representing
#' sheet names for the Excel file.
#' @param data A list of tibble and data frame representing
#' the data needed to output to the Excel file.
#' @param workbook A Workbook object created using
#' `openxlsx::createWorkbook`.
#' @examples
#' coronary_vessel_segments <- c(
#'   "LM", "pLAD", "mLAD", "dLAD",
#'   "pLCX", "dLCX", "pRCA", "mRCA", "dRCA"
#' )
#'
#' vessel_severity <- c(
#'   "Severe", "Severe", "Minimal", "Occluded",
#'   "Moderate", "Moderate", "Normal", "Severe", "Mild"
#' )
#'
#' vessel_disease_data <- data.frame(
#'   coronary_vessel_segments = coronary_vessel_segments,
#'   vessel_severity = vessel_severity
#' )
#'
#' # Create a new workbook
#' my_workbook <- openxlsx::createWorkbook()
#'
#' sheet_name = c("vessel disease")
#' output_data = vessel_disease_data
#'
#' write_to_sheet(sheet_name = sheet_name,
#'                data = output_data,
#'                workbook = my_workbook)
#'
#' @rdname write_to_sheet
#' @export
write_to_sheet <- function(sheet_name,
                           data,
                           workbook) {

  # Create a new worksheet
  openxlsx::addWorksheet(wb = workbook,
                         sheetName = sheet_name)

  font_size <- as.integer(openxlsx::getBaseFont(workbook)$size$val)

  openxlsx::setColWidths(
    wb = workbook,
    sheet = sheet_name,
    cols = seq_len(ncol(data)),
    widths = calculate_column_max_char(data) + font_size - 6
  )

  # Write to worksheet as an Excel Table
  openxlsx::writeDataTable(
    wb = workbook,
    sheet = sheet_name,
    x = data,
    withFilter = TRUE,
    bandedRows = FALSE
  )

}
