# Title: Lab06
# Description: More dplyr, ggplot2, and files' stuff
# Input(s): Data file 'nba2017-players.csv'
# Output(s): what are the main outputs (list of outputs)
# Author: Tianqi Lu
# Date: 10-05-2017

# packages
library(readr)    # importing data
library(dplyr)    # data wrangling
library(ggplot2)  # graphics

dat <- read_csv("nba2017-players.csv")
warriors <- data.frame(arrange(filter(dat, team == "GSW"), salary))
write.csv(warriors, file = "/Users/TLuv/Downloads/stat133/stat133-hws-fall17/lab06/data/warriors.csv", row.names = FALSE)
lakers <- data.frame(arrange(filter(dat, team == "LAL"), desc(experience)))
write_csv(lakers, "/Users/TLuv/Downloads/stat133/stat133-hws-fall17/lab06/data/lakers.csv")


sink(file = '/Users/TLuv/Downloads/stat133/stat133-hws-fall17/lab06/output/data-structure.txt')
str(dat)
sink()

sink(file = '/Users/TLuv/Downloads/stat133/stat133-hws-fall17/lab06/output/summary-warriors.txt')
summary(warriors)
sink()

sink(file = '/Users/TLuv/Downloads/stat133/stat133-hws-fall17/lab06/output/summary-lakers.txt')
summary(lakers)
sink()

png(filename = '/Users/TLuv/Downloads/stat133/stat133-hws-fall17/lab06/images/scatterplot-height-weight.png')
plot(x = dat$height, y = dat$weight, pch = 20, xlab = "Height", ylab = "Weight")
dev.off()

png(filename = '/Users/TLuv/Downloads/stat133/stat133-hws-fall17/lab06/images/scatterplot-height-weight-higherResolution.png', pointsize = 5)
plot(x = dat$height, y = dat$weight, pch = 20, xlab = "Height", ylab = "Weight")
dev.off()

jpeg(filename = "/Users/TLuv/Downloads/stat133/stat133-hws-fall17/lab06/images/histogram-age.jpeg", width = 600, height = 400)
ggplot(data = dat, aes(x = age)) + geom_histogram()
dev.off()

pdf(file = "/Users/TLuv/Downloads/stat133/stat133-hws-fall17/lab06/images/histogram-age-pdf.pdf", width = 7, height = 5)
ggplot(data = dat, aes(x = age)) + geom_histogram()
dev.off()

gg_pts_salary <- ggplot(dat, aes(x = points, y = salary)) + geom_point()
ggsave(filename = '/Users/TLuv/Downloads/stat133/stat133-hws-fall17/lab06/images/points_salary.pdf', plot = gg_pts_salary, width = 7, height = 5)

gg_ht_wt_positions <- ggplot(dat, aes(x = height, y = weight)) + facet_wrap(~ position) + geom_point()
ggsave(filename = '/Users/TLuv/Downloads/stat133/stat133-hws-fall17/lab06/images/height_weight_by_position.pdf', width = 6, height = 4)


# Use Piper %>%
#- display the player names of Lakers `'LAL'`
dat %>%
  filter(team == "LAL") %>%
  select("player")

# - display the name and salary of GSW point guards 'PG'
dat %>%
  filter(team == "GSW" & position == "PG") %>%
  select("player", "salary")

# - dislay the name, age, and team, of players with more than 10 years 
# of experience, making 10 million dollars or less.
dat %>%
  filter(experience > 10 & salary <= 10000000) %>%
  select("player", "age", "team")

# - select the name, team, height, and weight, of rookie players, 
# 20 years old, displaying only the first five occurrences (i.e. rows)
dat %>%
  filter(experience == 0 & age == 20) %>%
  select("player", "team", "height", "weight") %>%
  slice(1:5)

# - create a data frame `gsw_mpg` of GSW players, that contains variables for 
# `player` name, `experience`, and `min_per_game` (minutes per game), 
# sorted by `min_per_game` (in descending order)
gsw_mpg <- dat %>%
  filter(team == "GSW") %>%
  mutate(min_per_game = minutes / games) %>%
  select("player", "experience", "min_per_game") %>%
  arrange(min_per_game)

# - display the average triple points by team, in ascending order, of the 
# bottom-5 teams (worst 3pointer teams)
dat %>%
  group_by(team) %>%
  summarise(
    avg_points3 = mean(points3, na.rm = TRUE)
  ) %>%
  arrange(avg_points3) %>%
  tail(5)

# - obtain the mean and standard deviation of `age`, for Power Forwards, with 5 
# and 10 years (including) years of experience
dat %>%
  filter(position == "PF" & experience >= 5 & experience <= 10) %>%
  summarise(
    mean(age, na.rm = TRUE),
    sd(age)
  )