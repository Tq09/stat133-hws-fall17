# ===================================================================
# Title: make teams table
# Description: More about dplyr and ggplot
# Input(s): nba2017-roster.csv
#           nba2017-stats.csv
# Output(s): efficiency-summary.txt
#            teams-summary.txt
#            nba2017-teams.csv
#            teams_star_plot.pdf
#            experience_salary.pdf
#            teams_star_plot.pdf
#            experience_salary.pdf
# Author: Tianqi Lu
# Date: 10-15-2017
# ===================================================================


# read csv tables
library(readr)
roster <- read_csv('data/nba2017-roster.csv')
stats <- read_csv('data/nba2017-stats.csv')

# add these variables to stats
library(dplyr)
stats <- mutate(stats, 
                missed_fg = field_goals_atts - field_goals_made,
                missed_ft = points1_atts - points1_made,
                points = 3 * points3_made + 2 * points2_made + points1_made,
                rebounds = off_rebounds + def_rebounds,
                efficiency = (points + rebounds + assists + steals + blocks
                              - missed_fg - missed_ft - turnovers) 
                / games_played)

# output the efficiency index
sink(file = 'output/efficiency-summary.txt')
summary(stats$efficiency)
sink()

# merge two data frames
dat <- merge(roster, stats)

# create a new data frame from dat
teams <- summarise(
  group_by(dat, team),
  experience = sum(experience),
  salary = round(sum(salary) / 1000000, digits = 2),
  points3 = sum(points3_made),
  points2 = sum(points2_made),
  free_throws = sum(points1_made),
  points = points3 + points2 + free_throws,
  off_rebounds = sum(off_rebounds),
  def_rebounds = sum(def_rebounds),
  assists = sum(assists),
  steals = sum(steals),
  blocks = sum(blocks),
  turnovers = sum(turnovers),
  fouls = sum(fouls),
  efficiency = sum(efficiency)
)

# export the summary of teams
sink('data/teams-summary.txt')
summary(teams)
sink()

# export teams as a csv file
write.csv(teams, row.names = FALSE, 'data/nba2017-teams.csv')

# export the star plot of teams
pdf(file = 'images/teams_star_plot.pdf')
stars(teams[ ,-1], labels = teams$team)
dev.off()

# export the scatterplot of experience and salary
library(ggplot2)
pdf(file = 'images/experience_salary.pdf')
ggplot(teams, aes(experience, salary, label = team)) + 
  geom_point() + 
  geom_text(check_overlap = TRUE)
dev.off()











