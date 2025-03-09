#' @title Print Quarto Version
#' @description A function that gives some
#' information on which version of Quarto
#' is used and its location. We can't name it
#' as get_quarto_version
#' @param test_sys_path Set to TRUE if we want to
#' test the program finding Quarto in a system
#' environment.
#' Default: FALSE
#' @param test_no_path Set to TRUE if we want to
#' test when a path to Quarto does not exist.
#' Default: FALSE
#' @return A vector of text indicating the Quarto version
#' and where is it found in the computer.
#' @examples
#'
#' quarto_version <- get_quarto_version()
#'
#' @rdname get_quarto_version
#' @export
get_quarto_version <- function(
    test_sys_path = FALSE,
    test_no_path = FALSE
) {

  # Taken from https://github.com/r-lib/sessioninfo/issues/75
  if (isNamespaceLoaded("quarto") && isFALSE(test_sys_path)) {
    path <- quarto::quarto_path() |>
      fs::path_real()
    ver <- system("quarto -V", intern = TRUE)
    if (is.null(path) || isTRUE(test_no_path)) {
      "NA (via quarto)"
    } else {
      paste0(ver, " @ ", path, "/ (via quarto)")
    }
  } else {
    path <- Sys.which("quarto") |>
      fs::path_real()
    if (path == "" || isTRUE(test_no_path)) {
      "NA"
    } else {
      ver <- system("quarto -V", intern = TRUE)
      paste0(ver, " @ ", path)
    }
  }
}

#' @title Get R Package Information
#' @description A function that gives some
#' information on the loaded libraries used
#' in a script or project.
#' @return A tibble with four columns `package`,
#' `version`, `date` and `source`.
#' \itemize{
#'   \item `package`: The name of the loaded package.
#'   \item `version`: The version number of the loaded package.
#'   \item `date`: The date of the loaded package was installed.
#'   \item `source`: The source where the loaded package was installed.
#' }
#' @examples
#' library("dplyr")
#'
#' r_package_info <- get_r_package_info()
#'
#' r_package_info
#'
#' @rdname get_r_package_info
#' @export
get_r_package_info <- function() {

  r_package_table <- sessioninfo::package_info()
  rownames(r_package_table) <- NULL

  r_package_table <- r_package_table |>
    tibble::as_tibble() |>
    dplyr::mutate(
      version = ifelse(is.na(r_package_table$loadedversion),
                       r_package_table$ondiskversion,
                       r_package_table$loadedversion)) |>
    dplyr::filter(.data[["attached"]] == TRUE) |>
    dplyr::select(
      dplyr::any_of(c("package", "version",
                      "date", "source"))
    )

  return(r_package_table)

}

#' @title Get `knitr` Version
#' @description A function that gives some
#' information on the loaded library `knitr`.
#' @return A text saying the version number
#' and where it is downloaded from.
#' @examples
#' library("knitr")
#'
#' knitr_info <- get_knitr_version()
#'
#' knitr_info
#'
#' @rdname get_knitr_version
#' @export
get_knitr_version <- function() {

  knitr_info <- "NA"

  r_package_table <- sessioninfo::package_info(
    pkgs = c("installed")
  ) |>
    dplyr::filter(.data[["package"]] == "knitr")

  if (nrow(r_package_table) == 1) {

    knitr_version <- r_package_table$loadedversion[1]
    knitr_source <- r_package_table$source[1]

    knitr_info <- paste0(
      knitr_version, " from ",
      knitr_source)
  }

  return(knitr_info)

}

#' @title Get R Platform Information
#' @description A function that gives some
#' information on the R platform environment used
#' in a script or project.
#' @return A tibble with two columns `setting`,
#' and `value`.
#' \itemize{
#'   \item `setting`: The name of the settings like R version, OS, etc.
#'   \item `value`: The value of the setting. Usually the version number of the settings.
#' }
#' @examples
#'
#' r_platform_table <- get_r_platform_info
#'
#' @rdname get_r_platform_info
#' @export
get_r_platform_info <- function() {

  r_platform_table <- sessioninfo::platform_info()
  r_platform_table[["quarto"]] <- get_quarto_version()[1]
  r_platform_table[["knitr"]] <- get_knitr_version()[1]

  r_platform_table <- data.frame(
    setting = names(r_platform_table),
    value = unlist(r_platform_table,
                   use.names = FALSE),
    stringsAsFactors = FALSE
  )

  return(r_platform_table)
}
