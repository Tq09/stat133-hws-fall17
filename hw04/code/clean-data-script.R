source('./code/functions.R')

dat <- read.csv(file = './data/rawdata/rawscores.csv', stringsAsFactors = FALSE)

# Sink summary of the raw data
sink('./output/summary-rawscores.txt')
cat('Structure of the raw data', '\n')
str(dat)

cat('\nSummary of each column in the raw data\n')
for (j in 1:ncol(dat)) {
  cat(names(dat)[j])
  print_stats(summary_stats(dat[,j]))
  cat('\n\n')
}
sink()

# replace every NA with zero
dat[is.na(dat)] <- 0

# use rescale100() to rescale QZ1: 0 is the minimum, and 12 is the max
dat$QZ1 <- rescale100(dat$QZ1, xmin = 0, xmax = 12)

# use rescale100() to rescale QZ2: 0 is the minimum, and 18 is the max
dat$QZ2 <- rescale100(dat$QZ2, xmin = 0, xmax = 18)

# use rescale100() to rescale QZ3: 0 is the minimum, and 20 is the max
dat$QZ3 <- rescale100(dat$QZ3, xmin = 0, xmax = 20)

# use rescale100() to rescale QZ4: 0 is the minimum, and 20 is the max
dat$QZ4 <- rescale100(dat$QZ4, xmin = 0, xmax = 20)

# use rescale100() to add a variable Test1 by rescaling EX1: 0 is the minimum, and 80 is the max.
dat$Test1 <- rescale100(dat$EX1, xmin = 0, xmax = 80)

# use rescale100() to add a variable Test2 by rescaling EX2: 0 is the minimum, and 90 is the max.
dat$Test2 <- rescale100(dat$EX2, xmin = 0, xmax = 90)

# add a variable Homework to the data frame of scores; this variable should contain the overall 
# homework score obtained by dropping the lowest HW, and then averaging the remaining scores.
dat$Homework <- dat$HW1 + dat$HW2 + dat$HW3 + dat$HW4 + dat$HW5 + dat$HW6 + dat$HW7 + dat$HW8 + dat$HW9
for (i in 1:nrow(dat)) {
  dat$Homework[i] = (dat$Homework[i] - min(dat[i, 1:9])) / 8
}

# add a variable Quiz to the data frame of scores; this variable should contain the overall quiz score 
# obtained by dropping the lowest quiz, and then averaging the remaining scores.
dat$Quiz <- dat$QZ1 + dat$QZ2 + dat$QZ3 + dat$QZ4
for (i in 1:nrow(dat)) {
  dat$Quiz[i] = (dat$Quiz[i] - min(dat[i, 11:14])) / 3
}

# rescale ATT
dat$Lab <- rescale100(dat$ATT, xmin = 0, xmax = 12)

# add a variable Overall to the data frame of scores
dat$Overall <- 0.1*dat$Lab + 0.3 * dat$Homework + 0.15 * dat$Quiz + 0.2*dat$Test1 + 0.25*dat$Test2

# add Grade grade
for (i in 1:nrow(dat)) {
  dat$Grade[i] = toGrade(dat$Overall[i])
}

# Sink summary
sink('./output/Lab-stats.txt')
cat('Summary of labs\n')
print_stats(summary_stats(dat$Lab))
sink()

sink('./output/Homework-stats.txt')
cat('Summary of Homework\n')
print_stats(summary_stats(dat$Homework))
sink()

sink('./output/Quiz-stats.txt\n')
cat('Summary of Quiz')
print_stats(summary_stats(dat$Quiz))
sink()

sink('./output/Test1-stats.txt\n')
cat('Summary of Test1')
print_stats(summary_stats(dat$Test1))
sink()

sink('./output/Test2-stats.txt\n')
cat('Summary of Test2')
print_stats(summary_stats(dat$Test2))
sink()

sink('./output/Overall-stats.txt\n')
cat('Summary of Overall')
print_stats(summary_stats(dat$Overall))
sink()

# sink summary of clean data
sink('./output/summary-cleanscores.txt')
cat('Structure', '\n\n')
str(dat)
sink()

write.csv(dat, './data/cleandata/cleanscores.csv', row.names = FALSE)




