# Traveling Salesman Problem

Definition from wikipedia:
> The travelling salesman problem asks the following question: Given a list of cities and the distances between each pair of cities, what is the shortest possible route that visits each city exactly once and returns to the origin city?

There are a finite set of vertice (cities) and a finite set of edges (connection between cities). Each edge has an associated distance `d > 0`. That distance can be travel time, kilometers or the monetary cost associated with traveling from one city to another. 

To solve as mixed integer linear problem, one way is the Miller–Tucker–Zemlin formulation.

## Requirement

**R Optimization Infrastructure** --> [more information](https://roi.r-forge.r-project.org/index.html)

It is important to note that:
> [ROI.plugin.glpk](https://cran.r-project.org/web/packages/ROI.plugin.glpk/index.html) itself doesn’t contain compiled code but it imports Rglpk. The [Rglpk](https://cran.r-project.org/web/packages/Rglpk/index.html) package requires the linear programming kit - development files to be installed before the installation of Rglpk. Depending on the distribution, the linear programming kit - development files may be installed via one of the following commands.

To use the library, run the following command to install the packages.
```
sudo apt-get install liglpk-dev
sudo apt-get install r-cran-rglpk
```

Note that, the above commands are for the installation in Debian-based distributions. See the [instructions](https://roi.r-forge.r-project.org/installation.html) for other distributions or operating systems.

## Results

Once extract the results and organize for trip planner, then the itinerary can be viewed as:
```
| trip_id|property | idx_val|         x|           y|
|-------:|:--------|-------:|---------:|-----------:|
|       1|from     |       9| 363.85263|  89.4817924|
|       1|to       |       1| 360.45195|  17.2677175|
|       2|from     |       1| 360.45195|  17.2677175|
|       2|to       |       4| 443.06228|   0.5682933|
|       3|from     |       4| 443.06228|   0.5682933|
|       3|to       |       2| 437.88660|  76.1867451|
|       4|from     |       2| 437.88660|  76.1867451|
|       4|to       |      10| 494.86847| 475.8293768|
|       5|from     |      10| 494.86847| 475.8293768|
|       5|to       |       3| 380.49116| 367.8424762|
|       6|from     |       3| 380.49116| 367.8424762|
|       6|to       |       6|  83.18589| 231.2473271|
|       7|from     |       6|  83.18589| 231.2473271|
|       7|to       |       7| 162.54769| 194.0719908|
|       8|from     |       7| 162.54769| 194.0719908|
|       8|to       |       5| 228.24048| 195.6016676|
|       9|from     |       5| 228.24048| 195.6016676|
|       9|to       |       8| 254.61217| 201.2425709|
|      10|from     |       8| 254.61217| 201.2425709|
|      10|to       |       9| 363.85263|  89.4817924|
```
Visualization of the trip planner:
![result](https://github.com/ornwipa/traveling_salesman/blob/main/result.png)

## Acknowledgement

Thank to the guideline in [R for Operations Research](https://www.r-orms.org/) for parts of the codes and analyses.
