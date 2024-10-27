#' Random walk betweenness
#'
#' @description
#' Calculates the random walk betweenness of each node in a graph
#'
#' @param x a symemtric (possibly weighted) adjacency matrix or an \code{igraph} object
#' @return returns the random walk betweenness
#' @details if \code{x} is an \code{igraph} object that contains an edge attribute named \code{weight}, it will be used by default
#' @section References: Newman, Mark EJ. "A measure of betweenness centrality based on random walks." Social networks 27, no. 1 (2005): 39-54.
#' @export
rwbtw = function(x) {

    stopifnot(
        inherits(x, "matrix") || inherits(x, "igraph")
    )

    if(inherits(x, "igraph")) {
        if ("weight" %in% names(igraph::edge_attr(x))) {

            x = igraph::as_adj(x, attr = "weight", sparse = FALSE)

        } else {

            x = igraph::as_adj(x, sparse = FALSE)

        }

    } else {

        if (ncol(x) != nrow(x))
            stop("x has to be a sqaure matrix")

    }

    if (any(x < 0.0))
        stop("x cannot contain negative values")

    return(as.vector(.rwbtw(x)))

}

### EOF ###