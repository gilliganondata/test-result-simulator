# Scratchpad for exploring hand calculating the 2-sample difference in proportions
# vs. using prop.test.

a_observed <- 0.05
b_observed <- 0.055
num_obs <- 25000

# Calculate by hand
min_lift_proportion <- b_observed - a_observed - 1.645 *
  sqrt((a_observed * (1-a_observed) + b_observed * (1- b_observed)) / num_obs)

max_lift_proportion <- b_observed - a_observed + 1.645 *
  sqrt((a_observed * (1-a_observed) + b_observed * (1- b_observed)) / num_obs)

# Put in a data frame
df <- data.frame(label = "Manual",
                 min = min_lift_proportion,
                 max = max_lift_proportion)

# Function to pass other permutations
prop_test <- function(label, p1, p2, num_obs, alt){
  
  test <- prop.test(x = c(p1 * num_obs, p2 * num_obs),
                    n = c(num_obs, num_obs),
                    conf.level = 0.95,
                    alternative = alt,
                    correct = FALSE
  )
  
  return_df <- data.frame(label = label,
                          min = test$conf.int[[1]],
                          max = test$conf.int[[2]])
  
}

df <- df %>% 
  # rbind(prop_test("2-Sided - A_B", a_observed, b_observed, 25000, "two.sided")) %>% 
  rbind(prop_test("2-Sided - B_A", b_observed, a_observed, 25000, "two.sided")) %>% 
  # rbind(prop_test("Greater - A_B", a_observed, b_observed, 25000, "greater")) %>% 
  rbind(prop_test("Greater - B_A", b_observed, a_observed, 25000, "greater")) 
  # rbind(prop_test("Less - A_B", a_observed, b_observed, 25000, "less"))
  # rbind(prop_test("Less - B_A", b_observed, a_observed, 25000, "less"))