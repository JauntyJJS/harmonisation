test_that("is_integer_value works", {

  testthat::expect_true(is_integer_value(1))

  testthat::expect_false(is_integer_value(1.1))

  testthat::expect_false(is_integer_value("1"))

  testthat::expect_false(is_integer_value(NA, allow_na = FALSE))

  testthat::expect_true(is_integer_value(NA, allow_na = TRUE))

})

test_that("is_integer_vector works", {

  testthat::expect_equal(is_integer_vector(c(1, 2, 3)),
                         c(TRUE, TRUE, TRUE))

  testthat::expect_equal(is_integer_vector(c(1.1, 2, 3)),
                         c(FALSE, TRUE, TRUE))

  testthat::expect_equal(is_integer_vector(c(1, 2, "3")),
                         c(FALSE, FALSE, FALSE))

  testthat::expect_equal(is_integer_vector(c(1, NA, 3),
                                           allow_na = FALSE),
                         c(TRUE, FALSE, TRUE))

  testthat::expect_equal(is_integer_vector(c(1, NA, 3),
                                           allow_na = TRUE),
                         c(TRUE, TRUE, TRUE))

})
