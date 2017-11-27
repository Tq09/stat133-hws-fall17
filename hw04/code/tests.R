library(testthat)
## Test remove_missing
context("Remove_missing")

test_that("remove_missing is a vector containing no NA", {
  expect_equal(remove_missing(c(1, NA)), c(1))
  expect_equal(remove_missing(c(1, NA, 2)), c(1, 2))
  expect_equal(remove_missing(c(NA, 5)), c(5))
  expect_equal(remove_missing(c(1, NA, 3, 6)), c(1, 3, 6))
})
## Test get_minimum
context("get_minimum")

test_that("get_minimum is the smallest number", {
  expect_equal(get_minimum(c(1, NA)), 1)
  expect_equal(get_minimum(c('a', 2)), "non-numeric argument")
  expect_equal(get_minimum(c(17, NA, 5, 6)), 5)
  expect_equal(get_minimum(c(NA)), "non-numeric argument")
})
## Test get_maximum
context("get_maximum")

test_that("get_maximum is the largest number", {
  expect_equal(get_maximum(c(1, NA)), 1)
  expect_equal(get_maximum(c('a', 2)), "non-numeric argument")
  expect_equal(get_maximum(c(17, NA, 5, 6)), 17)
  expect_equal(get_maximum(c(NA)), "non-numeric argument")
})
## Test get_range
context("get_range")

test_that("get_range is the range of the numbers in the vector", {
  expect_equal(get_range(c(1, NA)), 0)
  expect_equal(get_range(c('a', 2)), "non-numeric argument")
  expect_equal(get_range(c(17, NA, 5, 6)), 12)
  expect_equal(get_range(c(NA)), "non-numeric argument")
})
## Test get_median
context("get_median")

test_that("get_median is the median number", {
  expect_equal(get_median(c(1, NA), TRUE), 1)
  expect_equal(get_median(c('a', 2)), "non-numeric argument")
  expect_equal(get_median(c(17, NA, 5, 6), TRUE), 6)
  expect_equal(get_median(c(NA), TRUE), "non-numeric argument")
})
## Test get_average
context("get_average")

test_that("get_average is the mean number", {
  expect_equal(get_average(c(1, NA), TRUE), 1)
  expect_equal(get_average(c('a', 2)), "non-numeric argument")
  expect_equal(get_average(c(17, NA, 5, 5), TRUE), 9)
  expect_equal(get_average(c(NA), TRUE), "non-numeric argument")
})
## Test get_stdev
context("get_stdev")

test_that("get_stdev is the standard deviation", {
  expect_equal(get_stdev(c(1, NA), TRUE), sd(c(1)))
  expect_equal(get_stdev(c('a', 2)), "non-numeric argument")
  expect_equal(get_stdev(c(17, NA, 5, 5), TRUE), sd(c(17, 5, 5)))
  expect_equal(get_stdev(c(NA), TRUE), "non-numeric argument")
})
## Test get_quartile1
context("get_quartile1")

test_that("get_quartile1 is the first quartile number", {
  expect_equal(get_quartile1(c(1, 4, 7, 9, NA), TRUE), unname(quantile(c(1, 4, 7, 9), 0.25)))
  expect_equal(get_quartile1(c('a', 2)), "non-numeric argument")
  expect_equal(get_quartile1(c(17, NA, 5, 5), TRUE), unname(quantile(c(17, 5, 5), 0.25)))
  expect_equal(get_quartile1(c(NA), TRUE), "non-numeric argument")
})
## Test get_quartile3
context("get_quartile3")

test_that("get_quartile3 is the third quartile number", {
  expect_equal(get_quartile3(c(1, 4, 7, 9, NA), TRUE), unname(quantile(c(1, 4, 7, 9), 0.75)))
  expect_equal(get_quartile3(c('a', 2)), "non-numeric argument")
  expect_equal(get_quartile3(c(17, NA, 5, 5), TRUE), unname(quantile(c(17, 5, 5), 0.75)))
  expect_equal(get_quartile3(c(NA), TRUE), "non-numeric argument")
})
## Test get_percentile10
context("get_percentile10")

test_that("get_percentile10 is the 10 quantile number", {
  expect_equal(get_percentile10(c(1, 4, 7, 9, NA), TRUE), unname(quantile(c(1, 4, 7, 9), 0.1)))
  expect_equal(get_percentile10(c('a', 2)), "non-numeric argument")
  expect_equal(get_percentile10(c(17, NA, 5, 5), TRUE), unname(quantile(c(17, 5, 5), 0.1)))
  expect_equal(get_percentile10(c(NA), TRUE), "non-numeric argument")
})
## Test get_percentile90
context("get_percentile90")

test_that("get_percentile90 is the 90 quantile number", {
  expect_equal(get_percentile90(c(1, 4, 7, 9, NA), TRUE), unname(quantile(c(1, 4, 7, 9), 0.9)))
  expect_equal(get_percentile90(c('a', 2)), "non-numeric argument")
  expect_equal(get_percentile90(c(17, NA, 5, 5), TRUE), unname(quantile(c(17, 5, 5), 0.9)))
  expect_equal(get_percentile90(c(NA), TRUE), "non-numeric argument")
})
## Test count_missing
context("count_missing")

test_that("count_missing is the number of NAs in the vector", {
  expect_equal(count_missing(c(1, 4, 7, 9, NA)), 1)
  expect_equal(count_missing(c(2)), 0)
  expect_equal(count_missing(c(17, NA, 5, 5)), 1)
  expect_equal(count_missing(c(NA)), 1)
})
## Test summary_stats
context("summary_stats")

test_that("summary_stats is the summary of a vector", {
  ## Test 1
  a1 <- c(1, 4, 7, 9)
  b1 <- list(
    min(a1),
    unname(quantile(a1, 0.1)),
    unname(quantile(a1, 0.25)),
    unname(quantile(a1, 0.5)),
    mean(a1),
    unname(quantile(a1, 0.75)),
    unname(quantile(a1, 0.9)),
    max(a1),
    max(a1) - min(a1),
    sd(a1),
    1
  )
  names(b1) <- c("minimum", "percent10", "quartile1", "median", "mean",
                "quartile3", "percent90", "maximum", "range", "stdev", "missing")
  expect_equal(summary_stats(c(1, 4, 7, 9, NA)), b1)
  ## Test 2
  a2 <- c(2, 5, 7, 14)
  b2 <- list(
    min(a2),
    unname(quantile(a2, 0.1)),
    unname(quantile(a2, 0.25)),
    unname(quantile(a2, 0.5)),
    mean(a2),
    unname(quantile(a2, 0.75)),
    unname(quantile(a2, 0.9)),
    max(a2),
    max(a2) - min(a2),
    sd(a2),
    1
  )
  names(b2) <- c("minimum", "percent10", "quartile1", "median", "mean",
                 "quartile3", "percent90", "maximum", "range", "stdev", "missing")
  expect_equal(summary_stats(c(2, NA, 5, 7, 14)), b2)
  # Test 3
  a3 <- c(24, 1, 23, 9)
  b3 <- list(
    min(a3),
    unname(quantile(a3, 0.1)),
    unname(quantile(a3, 0.25)),
    unname(quantile(a3, 0.5)),
    mean(a3),
    unname(quantile(a3, 0.75)),
    unname(quantile(a3, 0.9)),
    max(a3),
    max(a3) - min(a3),
    sd(a3),
    1
  )
  names(b3) <- c("minimum", "percent10", "quartile1", "median", "mean",
                 "quartile3", "percent90", "maximum", "range", "stdev", "missing")
  expect_equal(summary_stats(c(24, NA, 1, 23, 9)), b3)
  # Test 4
  a4 <- c(3)
  b4 <- list(
    min(a4),
    unname(quantile(a4, 0.1)),
    unname(quantile(a4, 0.25)),
    unname(quantile(a4, 0.5)),
    mean(a4),
    unname(quantile(a4, 0.75)),
    unname(quantile(a4, 0.9)),
    max(a4),
    max(a4) - min(a4),
    sd(a4),
    3
  )
  names(b4) <- c("minimum", "percent10", "quartile1", "median", "mean",
                 "quartile3", "percent90", "maximum", "range", "stdev", "missing")
  expect_equal(summary_stats(c(NA, NA, NA, 3)), b4)
})
## Test rescale100
context("rescale100")

test_that("rescale100 is the number rescaled to 0 ~ 100", {
  expect_equal(rescale100(c(1, 4, 7, 9), 1, 9), c(0, 300/8, 75, 100))
  expect_equal(rescale100(c(22, 2, 9, 18), 2, 22), c(100, 0, 35, 80))
  expect_equal(rescale100(c(17, 5, 5), 5, 17), c(100, 0, 0))
  expect_equal(rescale100(c(100, 23, 1, 78), 1, 100), c(100, 2200/99, 0, 7700/99))
})

## Test drop_lowest
context("drop_lowest")

test_that("drop_lowest is the vector after dropping the lowest score", {
  expect_equal(drop_lowest(c(1, 4, 7, 9)), c(4, 7, 9))
  expect_equal(drop_lowest(c(22, 2, 9, 18)), c(22, 9, 18))
  expect_equal(drop_lowest(c(17, 5, 5)), c(17, 5))
  expect_equal(drop_lowest(c(100, 23, 1, 78)), c(100, 23, 78))
})

# test score_homework()
context("output the avg of hw")

test_that("choose either to drop the lowest or not", {
  expect_equal(score_homework(c(1, 2), drop = TRUE), 2)
  expect_equal(score_homework(c(1, 2, 3), drop = TRUE), 2.5)
  expect_equal(score_homework(c(1, 2, -1), drop = FALSE), 2/3)
  expect_equal(score_homework(c(0, 10, 4), drop = FALSE), 14/3)
})

# test score_quiz()
context("output the avg of quizzes")
test_that("choose either to drop the lowest or not", {
  expect_equal(score_quiz(c(1, 2), drop = T), 2)
  expect_equal(score_quiz(c(1, 2, 3), drop = T), 2.5)
  expect_equal(score_quiz(c(1, 2, -1), drop = F), 2/3)
  expect_equal(score_quiz(c(0, 10, 4), drop = F), 14/3)
})

# test score_lab()
context("Show the lab score based on attendance")
test_that("enter the times of attendance from 0 to 12", {
  expect_equal(score_lab(0), 0)
  expect_equal(score_lab(6), 0)
  expect_equal(score_lab(12), 100)
  expect_equal(score_lab(10), 80)
})