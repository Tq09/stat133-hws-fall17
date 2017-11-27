#' title： remove missing
#' description： removes missing values from a vector
#' param： x vector possibly containing missing values
#' return： vector without missing values
remove_missing <- function(x) {
  y <- c()
  j = 0
  for(i in 1:length(x)) {
    if(!is.na(x[i])) {
      j = j + 1
      y[j] = x[i]
    } 
  }
  y
}
#' title： get minimum
#' description： get minimum value in a vector
#' param： x vector possibly containing missing values
#' return： smallest number
get_minimum <- function(x, na.rm = FALSE) {
  if (is.numeric(x) == FALSE) {
    return("non-numeric argument")
  } else {
    if (na.rm == TRUE) {
      x = remove_missing(x)
    }
    result <- sort(x)
  }
  return(result[1])
}
#' title： get maximum
#' description： get max value in a vector
#' param： x vector possibly containing missing values
#' return： largest number
get_maximum <- function(x, na.rm = FALSE) {
  if (is.numeric(x) == FALSE) {
    return("non-numeric argument")
  } else {
    if (na.rm == TRUE) {
      x = remove_missing(x)
    }
    result <- sort(x, decreasing = TRUE)
  }
  return(result[1])
}
#' title： get range
#' description： get range value in a vector
#' param： x vector possibly containing missing values
#' return： range number
get_range <- function(x, na.rm = FALSE) {
  if (is.numeric(x) == FALSE) {
    return("non-numeric argument")
  } else {
    return(get_maximum(x, na.rm = FALSE) - get_minimum(x, na.rm = FALSE))
  }
}
#' title： get median
#' description： get median value in a vector
#' param： x vector possibly containing missing values
#' return： median number
get_median <- function(x, na.rm = FALSE) {
  if (is.numeric(x) == FALSE) {
    return("non-numeric argument")
  } else {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  } 
  y <- sort(x)
  if (length(y)%%2 == 1) {
    val <- y[(length(y) + 1)/2]
  } else {
    val <- (y[(length(y) / 2) + 1] + y[length(y) / 2]) / 2
  }
  }
  return (val)
}
#' title： get average
#' description： get average value in a vector
#' param： x vector possibly containing missing values
#' return： average number
get_average <- function(x, na.rm = FALSE) {
  if (is.numeric(x) == FALSE) {
    return("non-numeric argument")
  } else {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  sum <- 0
  for (i in 1:length(x)) {
    sum = sum + x[i]
  }
  }
  return(sum / length(x))
}
#' title： get stdev
#' description： get stdev value in a vector
#' param： x vector possibly containing missing values
#' return： stand deviation number
get_stdev <- function(x, na.rm = FALSE) {
  if (is.numeric(x) == FALSE) {
    return("non-numeric argument")
  } else {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  avg <- get_average(x, na.rm)
  sum <- 0
  for (i in 1:length(x)) {
    sum = sum + (x[i] - avg) ^ 2
  }
  val <- sqrt(sum / (length(x) - 1))
  }
  return(val)
}
#' title： get quartile1
#' description： get first quartile in a vector
#' param： x vector possibly containing missing values
#' return： first quartile
get_quartile1 <- function(x, na.rm = FALSE) {
  if (is.numeric(x) == FALSE) {
    return("non-numeric argument")
  } else {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  val = unname(quantile(x, 0.25))
  }
  return(val)
}
#' title： get quartile3
#' description： get third quartile in a vector
#' param： x vector possibly containing missing values
#' return： third quartile
get_quartile3 <- function(x, na.rm) {
  if (is.numeric(x) == FALSE) {
    return("non-numeric argument")
  } else {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  val = unname(quantile(x, 0.75))
  }
  return(val)
}
#' title： get percentile10
#' description： get 10 quantile in a vector
#' param： x vector possibly containing missing values
#' return： 10 quantile
get_percentile10 <- function(x, na.rm = FALSE) {
  if (is.numeric(x) == FALSE) {
    return("non-numeric argument")
  } else {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  val = unname(quantile(x, 0.1))
  }
  return(val)
}
#' title： get percentile90
#' description： get 90 quantile in a vector
#' param： x vector possibly containing missing values
#' return： 90 quantile
get_percentile90 <- function(x, na.rm = FALSE) {
  if (is.numeric(x) == FALSE) {
    return("non-numeric argument")
  } else {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
  }
  val = unname(quantile(x, 0.9))
  }
  return(val)
}
#' title： count missing
#' description： get number of NAs
#' param： x vector possibly containing missing values
#' return： number of NAs
count_missing <- function(x) {
  length(x) - length(remove_missing(x))
}
#' title： summary stats
#' description： get summary of x
#' param： x vector possibly containing missing values
#' return： summary of x
#' 
#' 
# summary_stats <- function(x) {
#   val <- list(get_minimum(x, TRUE), 
#        get_percentile10(x, TRUE),
#        get_quartile1(x, TRUE),
#        get_median(x, TRUE),
#        get_average(x, TRUE),
#        get_quartile3(x, TRUE),
#        get_percentile90(x, TRUE),
#        get_maximum(x, TRUE),
#        get_range(x, TRUE),
#        get_stdev(x, TRUE),
#        count_missing(x)
#        )
#   names(val) <- c("minimum", "percent10", "quartile1", "median", "mean", 
#                   "quartile3", "percent90", "maximum", "range", "stdev", "missing")
#   return(val)
# }
summary_stats <- function(x) {
  list(
    minimum = get_minimum(x, na.rm = TRUE),
    percent10 = get_percentile10(x, na.rm = TRUE),
    quartile1 = get_quartile1(x, na.rm = TRUE),
    median = get_median(x, na.rm = TRUE),
    mean = get_average(x, na.rm = TRUE),
    quartile3 = get_quartile3(x, na.rm = TRUE),
    percent90 = get_percentile90(x, na.rm = TRUE),
    maximum = get_maximum(x, na.rm = TRUE),
    range = get_range(x, na.rm = TRUE),
    stdev = get_stdev(x, na.rm = TRUE),
    missing = count_missing(x)
)
}
#' title： print stats
#' description： print summary of x
#' param： x vector possibly containing missing values
#' return： summary of x
print_stats <- function(x) {
  label <- names(x)
  maxLength <- max(nchar(label))
  for(i in 1:length(x)) {
    curLength <- nchar(label[i])
    diffLength <- maxLength - curLength
    blanks <- paste(rep(" ", diffLength), collapse = '')
    print(blanks)
    cat(paste0(label[i], blanks, ': ', sprintf('%0.4f', x[[i]])), '\n')
  }
}

#' title： rescale100
#' description： rescale x to 0 ~ 100
#' param： x vector possibly containing missing values, minimum and maximum
#' return： rescale of x
rescale100 <- function(x, xmin, xmax) {
  100 * (x - xmin) / (xmax - xmin)
}
#' title： drop lowest
#' description： drop the lowest in x
#' param： x vector possibly containing missing values, minimum and maximum
#' return：new x without the smallest
drop_lowest <- function(x) {
  n <- length(x)
  xmin <- get_minimum(x, TRUE)
  y <- c()
  j = 0
  for(i in 1:n) {
    if(x[i] != xmin) {
      j = j + 1
      y[j] = x[i]
    } else {
      xmin = xmin - 1
    }
  }
  y
}
#' title： score homework
#' description： get the score of homework
#' param： x vector possibly containing missing values, minimum and maximum
#' return： the score of homework
score_homework <- function(x, drop = FALSE) {
  if (drop == TRUE) {
    x = drop_lowest(x)
  }
  get_average(x)
}
#' title： score quiz
#' description： get the score of quiz
#' param： x vector possibly containing missing values, minimum and maximum
#' return： the score of quiz
score_quiz <- function(x, drop = FALSE) {
  if (drop == TRUE) {
    x = drop_lowest(x)
  }
  get_average(x)
}
#' title： score lab
#' description： get the score of lab
#' param： x vector possibly containing missing values, minimum and maximum
#' return： the score of lab
score_lab <- function(x) {
  if (x > 12 | x < 0) {
    return("input should be between 1 and 12")
  } else if (x > 10) {
    val = 100
  } else if (x == 10) {
    val = 80
  } else if (x == 9) {
    val <- 60
  } else if (x == 8) {
    val <- 40
  } else if (x == 7) {
    val <- 20
  } else {
    val <- 0
  }
  return (val)
}

#' title： toGrade
#' description： change overall score to letter grade
#' param： x vector possibly containing missing values, minimum and maximum
#' return： the letter grades
toGrade <- function(x) {
  if(x < 50) {
    val = 'F'
  } else if(x < 60) {
    val = 'D'
  } else if(x < 70) {
    val = 'C-'
  } else if(x < 77.5) {
    val = 'C'
  } else if(x < 79.5) {
    val = 'C+'
  } else if(x < 82) {
    val = 'B-'
  } else if(x < 86) {
    val = 'B'
  } else if(x < 88) {
    val = 'B+'
  } else if(x < 90) {
    val = 'A-'
  } else if(x < 95) {
    val = 'A'
  } else {
    val = 'A+'
  }
}














