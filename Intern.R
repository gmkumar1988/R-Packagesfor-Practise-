# install.packages("dplyr")
library(dplyr)
# install.packages("lubridate")
library(lubridate)
# install.packages("tidyverse")
library(tidyverse)
# install.packages("ggplot2")
library(ggplot2)
location <- read.csv('/Users/maheshg/Dropbox/Sample Datasets Kaggle/Intern/locations.csv')
schedule <- read.csv('/Users/maheshg/Dropbox/Sample Datasets Kaggle/Intern/schedule_24_partial.csv')
team_game <- read.csv('/Users/maheshg/Dropbox/Sample Datasets Kaggle/Intern/team_game_data.csv')
View(team_game)
View(schedule)

head(schedule)
head(location)
head(team_game)

### How many times are the Thunder scheduled to play 4 games in 6 nights in the 
##provided 80-game draft of the 2024-25 season schedule? 
###(Note: clarification, the stretches can overlap, 
###the question is really ???How many games are the 4th game played over the past 6 nights????) 

###Step 1 : Mutate the Date column to Date format and arrange the schedule by Date

okc_games <- schedule %>%
  filter(team == "OKC") %>%
  arrange(gamedate)

dates <- okc_games$gamedate
# print(length(dates))
count <- 0
# str(dates)
dates <- as.Date(dates)
for (i in 4:length(dates)) {
  current_date <- dates[i]
  previous_dates <- dates[(i-3):(i-1)]
  
  # Skip if any dates are missing
  if (any(is.na(c(current_date, previous_dates)))) next
  
  # Check if all 3 previous games occurred within 6 nights before current game
  if (all(current_date - previous_dates <= 6)) {
    count <- count + 1
  }
}
cat("Thunder played the 4th game in a 6-night span", count, "times.\n")

###From 2014-15 to 2023-24, what is the 
# average number of 4-in-6 stretches for a team in a season?
# Adjust each team/season to per-82 games before taking your final average.   

team_season_counts <- data.frame(team = character(), season = integer(), count = numeric(), games_played = integer())

for (season in 2015:2024) {
  for (team in unique(schedule$team)) {
    team_games <- schedule %>%
      filter(season == season, team == team) %>%
      arrange(gamedate)
    
    dates <- team_games$gamedate
    raw_count <- 0
    dates <- as.Date(dates)
    
    for (i in 4:length(dates)) {
      if (all(!is.na(dates[(i-3):(i)])) && all(dates[i] - dates[(i-3):(i-1)] <= 6)) {
        raw_count <- raw_count + 1
      }
    }
    
    adjusted <- raw_count * (82 / length(dates))
    
    team_season_counts <- rbind(team_season_counts, data.frame(
      team = team,
      season = season,
      count = adjusted,
      games_played = length(dates)
    ))
  }
}

mean(team_season_counts$count)

###Which team has had the most 4-in-6 stretches in a single season from 2014-15 to 2023-24?
count_4in_6 <- function(datest) {
  dates <- as.Date(datest)
  count <- 0
  for (i in 4:length(dates)) {
    if (all(!is.na(dates[(i-3):(i)])) && all(dates[i] - dates[(i-3):(i-1)] <= 6)) {
      count <- count + 1
    }
  }
  return(count)
 }
# Step 1 : Getting the list of teams and success:
 teams <- unique(schedule$team)
 seasons <- unique(schedule$season)

#Step 2 : Initialize results dataframe :
 results <- data.frame(team = character(), season = integer(), adjusted_4_in_6 = numeric(),stringsAsFactors = FALSE)

#Step 3 : Loop through each team and season to calculate adjusted 4-in-6 counts
 for (team in teams) {
   for (season in seasons) {
     team_season_games <- schedule %>%
       filter(team == team, season == season) %>%
       arrange(gamedate)
     
     raw_count <- count_4in_6(team_season_games$gamedate)
     adjusted_count <- raw_count * (82 / nrow(team_season_games))
     
     results <- rbind(results, data.frame(team = team, season = season, adjusted_4_in_6 = adjusted_count))
   }
 }
 #Step 4 : Calculate average per team across seasons
 team_averages <- results %>%
   group_by(team) %>%
   summarize(avg_4_in_6 = mean(adjusted_4_in_6, na.rm = TRUE)) %>%
   arrange(desc(avg_4_in_6))
 #Step 5 : Identify the team with the highest average
 # highest_avg_team <- team_averages[which.max(team_averages$avg_4_in_6), ]
 # print(highest_avg_team)
 highest <- team_averages %>% slice(1)
 print(highest)
 lowest <- team_averages %>% slice(n())
 print(lowest)
 
##Is the difference between most and least from Q3 surprising, or do you expect that size difference is likely to be the result of chance?
 count_4_in_6 <- function(datest) {
   dates <- as.Date(datest)
   count <- 0
   for (i in 4:length(dates)) {
     current_date <- dates[i]
     previous_dates <- dates[(i-3):(i-1)]
     if (any(is.na(c(current_date, previous_dates)))) next
     if (all(current_date - previous_dates <= 6)) {
       count <- count + 1
     }
   }
   return(count)
 }
 
 # Function to get team averages
 get_team_averages <- function(schedule) {
   schedule %>%
     group_by(team, season) %>%
     arrange(gamedate) %>%
     summarise(
       games_played = n(),
       raw_count = count_4_in_6(gamedate),
       adjusted_4in6 = raw_count * (82 / games_played),
       .groups = "drop"
     ) %>%
     group_by(team) %>%
     summarise(avg_4in6 = mean(adjusted_4in6, na.rm = TRUE), .groups = "drop")
 }

 # Step 1: Calculate observed team averages
 observed <- get_team_averages(schedule)
 observed_diff <- max(observed$avg_4in6) - min(observed$avg_4in6)
 print(observed)
 print(observed_diff)

  
 # Step 2: Permutation test
 set.seed(42)
 n_sim <- 1000
 sim_diffs <- numeric(n_sim)
 
 for (i in 1:n_sim) {
   shuffled_schedule <- schedule %>%
     group_by(team, season) %>%
     mutate(gamedate = sample(gamedate)) %>%
     ungroup()
   
   sim_avg <- get_team_averages(shuffled_schedule)
   sim_diffs[i] <- max(sim_avg$avg_4in6, na.rm = TRUE) - min(sim_avg$avg_4in6, na.rm = TRUE)
 }
 
 # Step 3: Compare observed to simulated
 p_value <- mean(sim_diffs >= observed_diff)
 
 # Step 4: Output
 cat(" Observed difference between highest and lowest team average:", round(observed_diff, 2), "\n")
 cat("Estimated p-value from permutation test:", round(p_value, 4), "\n")
 
 if (p_value < 0.05) {
   cat("This difference is statistically significant ??? unlikely due to chance.\n")
 } else {
   cat("This difference could plausibly be due to random variation.\n")
 }
 
###What was BKN's defensive eFG% in the 2023-24 season? What was their defensive eFG% that season in situations
 ###where their opponent was on the second night of back-to-back?  
 bkn_defense <- team_game %>%
   filter(season == 2023, def_team == "BKN") %>%
   mutate(gamedate = as.Date(gamedate)) %>%
   filter(!is.na(fgmade), !is.na(fgattempted), !is.na(fg3made), fgattempted > 0) %>%
   mutate(def_eFG = (fgmade + 0.5 * fg3made) / fgattempted)
 ### Step 2 : Calculate Overall Defensive eFG%
 overall_def_eFG <- mean(bkn_defense$def_eFG, na.rm = TRUE)
 print(overall_def_eFG)
 ### Step 3 : Identify Opponent Back-to-Back Games
 opponent_b2b <- team_game %>%
   filter(season == 2023) %>%
   select(off_team, gamedate) %>%
   mutate(gamedate = as.Date(gamedate)) %>%
   arrange(off_team, gamedate) %>%
   group_by(off_team) %>%
   mutate(prev_game = lag(gamedate),
          is_b2b = !is.na(prev_game) & (gamedate - prev_game == 1)) %>%
   ungroup()
 
### Step 4 : Merge to identify backto back situations
 bkn_defense <- team_game %>%
   filter(season == 2023, def_team == "BKN") %>%
   mutate(gamedate = as.Date(gamedate)) %>%
   filter(!is.na(fgmade), !is.na(fgattempted), !is.na(fg3made), fgattempted > 0) %>%
   mutate(def_eFG = (fgmade + 0.5 * fg3made) / fgattempted) %>%
   left_join(opponent_b2b, by = c("off_team", "gamedate"))
 # Step 5: Calculate defensive eFG% when opponent was on 2nd night of back-to-back
 b2b_def_eFG <- bkn_defense %>%
   filter(is_b2b == TRUE) %>%
   summarise(avg_def_eFG = mean(def_eFG, na.rm = TRUE)) %>%
   pull(avg_def_eFG)
 overall_def_eFG <- mean(bkn_defense$def_eFG, na.rm = TRUE)
 cat("Brooklyn Nets' overall defensive eFG% in 2023???24:", round(overall_def_eFG * 100, 2), "%\n")
 cat(" Defensive eFG% vs opponents on 2nd night of back-to-back:", round(b2b_def_eFG * 100, 2), "%\n")
 ### Step 6 : Visualization
 summary_df <- bkn_defense %>%
   mutate(b2b_flag = ifelse(is_b2b, "Opponent on B2B", "All Games")) %>%
   group_by(b2b_flag) %>%
   summarise(avg_eFG = mean(def_eFG, na.rm = TRUE))
 
 ggplot(summary_df, aes(x = b2b_flag, y = avg_eFG * 100, fill = b2b_flag)) +
   geom_bar(stat = "identity", width = 0.6) +
   labs(title = "Brooklyn Defensive eFG% (2023???24)",
        x = "", y = "Defensive eFG%") +
   theme_minimal() +
   scale_fill_manual(values = c("#1D428A", "#C4CED4")) +
   theme(legend.position = "none")
 
 
### Please identify at least 2 trends in scheduling over time. 
 ###In other words, how are the more recent schedules different 
 ###from the schedules of the past? Please include a visual (plot or styled table) highlighting or explaining each trend and include a brief written description of your findings.  
 schedule <- schedule %>%
   mutate(gamedate = as.Date(gamedate))

 schedule_b2b <- schedule %>%
   arrange(team, season, gamedate) %>%
   group_by(team, season) %>%
   mutate(prev_game = lag(gamedate),
          is_b2b = !is.na(prev_game) & (gamedate - prev_game == 1)) %>%
   ungroup()
 
 b2b_counts <- schedule_b2b %>%
   group_by(team, season) %>%
   summarise(b2b_games = sum(is_b2b, na.rm = TRUE)) %>%
   group_by(season) %>%
   summarise(avg_b2b_per_team = mean(b2b_games))
 ggplot(b2b_counts, aes(x = season, y = avg_b2b_per_team)) +
   geom_line(color = "#1D428A", size = 1.2) +
   geom_point(color = "#C4CED4", size = 2) +
   labs(title = "???? Average Back-to-Back Games per Team by Season",
        x = "Season", y = "Avg Back-to-Back Games") +
   theme_minimal()
 
 weekend_share <- schedule %>%
   mutate(weekday = weekdays(gamedate),
          is_weekend = weekday %in% c("Saturday", "Sunday")) %>%
   group_by(season) %>%
   summarise(
     total_games = n(),
     weekend_games = sum(is_weekend),
     pct_weekend = weekend_games / total_games * 100
   )
 
 # Plot: Weekend game share over time
 ggplot(weekend_share, aes(x = season, y = pct_weekend)) +
   geom_col(fill = "#1D428A", alpha = 0.8) +
   labs(title = "Percentage of Games Played on Weekends by Season",
        x = "Season", y = "Weekend Game Share (%)") +
   theme_minimal()
###Please design a plotting tool to help visualize a team???s schedule for a season. The plot should cover the whole season and should help the viewer contextualize and understand a team???s schedule, potentially highlighting periods of excessive travel, dense blocks of games, or other schedule anomalies. If you can, 
 ###making the plots interactive (for example through the plotly package) is a bonus.   
 ###Please use this tool to plot OKC and DEN's provided 80-game 2024-25 schedules.   
 
 # Step 1: Prepare data
 schedule_2025 <- schedule %>%
   mutate(gamedate = as.Date(gamedate)) %>%
   arrange(team, gamedate)
## Step 2 : 4 in 6 Stretches
 schedule_2025 <- schedule %>%
   arrange(team, gamedate) %>%
   group_by(team) %>%
   mutate(
     dense_block = sapply(1:n(), function(i) {
       if (i < 4) return(FALSE)
       recent <- gamedate[(i-3):i]
       return(all(recent[i] - recent <= 6))
     }),
     away_flag = ifelse(location == "Away", TRUE, FALSE),
     away_streak = {
       rle_away <- rle(away_flag)
       rep(ifelse(rle_away$values, rle_away$lengths, 0), rle_away$lengths)
     }
   ) %>%
   ungroup()