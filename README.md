# Traveling Salesman Problem

Definition from wikipedia:
> The travelling salesman problem (TSP) asks the following question: Given a list of cities and the distances between each pair of cities, what is the shortest possible route that visits each city exactly once and returns to the origin city?

There are a finite set of vertice (cities) and a finite set of edges (connection between cities). Each edge has an associated distance `d > 0`. That distance can be travel time, kilometers or the monetary cost associated with traveling from one city to another. 

To solve the TSP as mixed integer linear problem (MILP), one way is the Miller–Tucker–Zemlin formulation.

## Requirement

**R Optimization Infrastructure** --> [more information](https://roi.r-forge.r-project.org/index.html)

It is important to note that:
> [ROI.plugin.glpk](https://cran.r-project.org/web/packages/ROI.plugin.glpk/index.html) itself doesn’t contain compiled code but it imports Rglpk. The [Rglpk](https://cran.r-project.org/web/packages/Rglpk/index.html) package requires the linear programming kit - development files to be installed before the installation of Rglpk. Depending on the distribution, the linear programming kit - development files may be installed via one of the following commands.

To use the library, run the following command to install the packages.
```
sudo apt-get install liglpk-dev
sudo apt-get install r-cran-rglpk
```

Note that the above command are installations for Debian-based distributions. See the [instructions](https://roi.r-forge.r-project.org/installation.html) for other distributions or operating systems.

## Results

The results from the solver will look like:
```
<SOLVER MSG>  ----
GLPK Simplex Optimizer, v4.65
110 rows, 110 columns, 434 non-zeros
      0: obj =   0.000000000e+00 inf =   2.900e+01 (29)
     30: obj =   2.233834282e+03 inf =   0.000e+00 (0)
*    63: obj =   9.495191454e+02 inf =   3.994e-16 (0)
OPTIMAL LP SOLUTION FOUND
GLPK Integer Optimizer, v4.65
110 rows, 110 columns, 434 non-zeros
100 integer variables, none of which are binary
Integer optimization begins...
Long-step dual simplex will be used
+    63: mip =     not found yet >=              -inf        (1; 0)
+   165: >>>>>   1.508872962e+03 >=   9.495191454e+02  37.1% (15; 0)
+   533: >>>>>   1.492351976e+03 >=   1.025876490e+03  31.3% (39; 11)
+  1105: >>>>>   1.457136124e+03 >=   1.354455390e+03   7.0% (60; 41)
+  1681: mip =   1.457136124e+03 >=     tree is empty   0.0% (0; 235)
INTEGER OPTIMAL SOLUTION FOUND
<!SOLVER MSG> ----
```

Once extract the results and organize for trip planner, then the iternary is:
```
| trip_id|property | idx_val|         x|           y|
|-------:|:--------|-------:|---------:|-----------:|
|       1|from     |       9| 363.85263|  89.4817924|
|       1|to       |       1| 360.45195|  17.2677175|
|       2|from     |       4| 443.06228|   0.5682933|
|       2|to       |       2| 437.88660|  76.1867451|
|       3|from     |      10| 494.86847| 475.8293768|
|       3|to       |       3| 380.49116| 367.8424762|
|       4|from     |       1| 360.45195|  17.2677175|
|       4|to       |       4| 443.06228|   0.5682933|
|       5|from     |       7| 162.54769| 194.0719908|
|       5|to       |       5| 228.24048| 195.6016676|
|       6|from     |       3| 380.49116| 367.8424762|
|       6|to       |       6|  83.18589| 231.2473271|
|       7|from     |       6|  83.18589| 231.2473271|
|       7|to       |       7| 162.54769| 194.0719908|
|       8|from     |       5| 228.24048| 195.6016676|
|       8|to       |       8| 254.61217| 201.2425709|
|       9|from     |       8| 254.61217| 201.2425709|
|       9|to       |       9| 363.85263|  89.4817924|
|      10|from     |       2| 437.88660|  76.1867451|
|      10|to       |      10| 494.86847| 475.8293768|
```
Visualization of the trip planner:
![result]()
