library(knitr)
library(dplyr)
library(ggplot2)

# set the number of cities:
n <- 10

# set boundary of Euclidean space:
max_x <- 500
max_y <- 500

# randomize locations of cities:
set.seed(12345)
cities <- data.frame(id = 1:n, x = runif(n, max = max_x), y = runif(n, max = max_y))

# visualize locations of cities:
ggplot(cities, aes(x, y)) + geom_point() + ggtitle("Location of Cities/Customers")

# create euclidean distance matrix:
distance <- as.matrix(stats::dist(select(cities, x, y), diag = TRUE, upper = TRUE))
dist_fun <- function(i, j) {
  vapply(seq_along(i), # a vector
         function(k) distance[i[k], j[k]], # an already-defined function 
         numeric(1L)) # an expected data type
}

# formulate TSP as MILP:
library(ompr)
model <- MIPModel() %>%
  
  # a variable is 1 IFF travel from i to j, otherwise 0
  add_variable(x[i, j], i = 1:n, j = 1:n, type = "integer", lb = 0, ub = n) %>%
  
  # a helper variable for Miller–Tucker–Zemlin formulation
  add_variable(u[i], i = 1:n, lb = 1, ub = n) %>%
  
  # objective function = minimize travel distance
  set_objective(sum_expr(dist_fun(i, j) * x[i, j], i = 1:n, j = 1:n), "min") %>%
  
  # constraint to not go from a city to the same city
  set_bounds(x[i, i], ub = 0, i = 1:n) %>%
  
  # constraint to leave each city once
  add_constraint(sum_expr(x[i, j], j = 1:n) == 1, i = 1:n) %>%
  
  # constraint to visit each city once
  add_constraint(sum_expr(x[i, j], i = 1:n) == 1, j = 1:n) %>%
  
  # constraint for no sub-tour
  add_constraint(u[i] >= 2, i = 2:n) %>%
  add_constraint(u[i] - u[j] + 1 <= (n - 1) * (1 - x[i, j]), i = 2:n, j = 2:n)

# solve with GLPK solver libraries:
library(ompr.roi)
library(ROI.plugin.glpk)
result <- solve_model(model, with_ROI(solver = "glpk", verbose = TRUE))

# extract the solution:
solution <- get_solution(result, x[i, j]) %>% filter(value > 0) 
kable(solution)

# connect to-from cities in the solution:
solution_path <- solution
for (k in 1:(n-1)) {
  for (l in 1:n) {
    if (solution_path[k,3] == solution[l,2]) {
      solution_path[k+1,2] <- solution[l,2]
      solution_path[k+1,3] <- solution[l,3]
    }
  }
}
kable(solution_path)

# create trip planner, link back indexes of the model to actual cities:
paths <- select(solution_path, i, j) %>% rename(from = i, to = j) %>% 
  mutate(trip_id = row_number()) %>% 
  tidyr::gather(property, idx_val, from:to) %>% 
  mutate(idx_val = as.integer(idx_val)) %>% 
  inner_join(cities, by = c("idx_val" = "id"))
kable(arrange(paths, trip_id))

# plot the solutions:
ggplot(cities, aes(x, y)) + geom_point() + 
  geom_line(data = paths, aes(group = trip_id)) + 
  ggtitle(paste0("Optimal route with cost: ", round(objective_value(result), 2)))
