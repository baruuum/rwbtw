
# rwbtw

<!-- badges: start -->
[![R-CMD-check](https://github.com/baruuum/rwbtw/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/baruuum/rwbtw/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

This package contains a single function that calculates the random-walk betweenness measure proposed by Newman (2005) on (possibly weighted) graphs. Unfortunately, sparse matrices are not supported.

## Installation

You can install the development version of `rwbtw` from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("baruuum/rwbtw")
```

## Example

``` r
library(rwbtw)

# Network 1 on Fig 3. of Newman(2005)
print(network1)
#>       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
#>  [1,]    0    1    1    1    1    1    0    0    0     0     1
#>  [2,]    1    0    1    1    1    0    0    0    0     0     0
#>  [3,]    1    1    0    1    1    0    0    0    0     0     0
#>  [4,]    1    1    1    0    1    0    0    0    0     0     0
#>  [5,]    1    1    1    1    0    0    0    0    0     0     0
#>  [6,]    1    0    0    0    0    0    1    1    1     1     1
#>  [7,]    0    0    0    0    0    1    0    1    1     1     0
#>  [8,]    0    0    0    0    0    1    1    0    1     1     0
#>  [9,]    0    0    0    0    0    1    1    1    0     1     0
#> [10,]    0    0    0    0    0    1    1    1    1     0     0
#> [11,]    1    0    0    0    0    1    0    0    0     0     0

# get random-walk betweenness measures
rwbtw(network1)
#> [1] 0.6703030 0.2690909 0.2690909 0.2690909 0.2690909 0.6703030 0.2690909 0.2690909 0.2690909 0.2690909 0.3333333
```

## References
Newman, Mark EJ. "A measure of betweenness centrality based on random walks." *Social networks* 27, no. 1 (2005): 39-54.