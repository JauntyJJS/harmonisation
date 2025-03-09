test_that("get_quarto_version works", {

  loadNamespace("quarto")
  quarto_version <- get_quarto_version()
  quarto_version_sys <- get_quarto_version(test_sys_path = TRUE)
  quarto_version_no_path <- get_quarto_version(test_no_path = TRUE)
  quarto_version_sys_no_path <- get_quarto_version(test_sys_path = TRUE,
                                                   test_no_path = TRUE)

  testthat::expect_true(stringr::str_detect(quarto_version[1], "quarto.exe"))
  testthat::expect_true(stringr::str_detect(quarto_version_sys[1], "quarto.exe"))
  testthat::expect_equal(quarto_version_no_path, "NA (via quarto)")
  testthat::expect_equal(quarto_version_sys_no_path, "NA")
})

test_that("get_r_package_info works", {

  library("harmonisation")

  r_package_info <- get_r_package_info()

  r_package_info |>
    testthat::expect_type("list")

  testthat::expect_equal(r_package_info$package[1], "harmonisation")
})

test_that("get_r_package_info works", {

  library("knitr")

  knitr_version <- get_knitr_version()

  testthat::expect_true(stringr::str_detect(knitr_version, "RSPM"))
})

test_that("get_r_platform_info works", {

  r_platform_table <- get_r_platform_info()

  testthat::expect_equal(names(r_platform_table)[1], "setting")
  testthat::expect_equal(names(r_platform_table)[2], "value")
})
