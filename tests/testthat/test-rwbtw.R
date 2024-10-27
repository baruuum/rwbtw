test_that("graph1", {

    # Network 1 in Fig 3. in Newman(2005)
    res = rwbtw(network1)

    expect_equal(round(res[1], 3), .670)
    expect_equal(round(res[6], 3), .670)
    expect_equal(round(res[11], 3), .333)
    expect_equal(round(res[2], 3), .269)
    expect_equal(round(res[7], 3), .269)

    if (requireNamespace("igraph")) {

        g = igraph::graph_from_adjacency_matrix(network1, mode = "undirected")
        # plot(g)
        res_g = rwbtw(g)

        expect_equal(round(res_g[1], 3), .670)
        expect_equal(round(res_g[6], 3), .670)
        expect_equal(round(res_g[11], 3), .333)
        expect_equal(round(res_g[2], 3), .269)
        expect_equal(round(res_g[7], 3), .269)

    }

    # Network 2 in Fig 3. in Newman(2005)
    res2 = rwbtw(network2)

    expect_equal(round(res2[12], 3), .321)
    expect_equal(round(res2[15], 3), .321)
    expect_equal(round(res2[17], 3), .267)
    expect_equal(round(res2[3], 3), .194)
    expect_equal(round(res2[8], 3), .194)

    if (requireNamespace("igraph")) {

        g2 = igraph::graph_from_adjacency_matrix(network2, mode = "undirected")
        # plot(g)
        res_g2 = rwbtw(g2)

        expect_equal(round(res_g2[12], 3), .321)
        expect_equal(round(res_g2[15], 3), .321)
        expect_equal(round(res_g2[17], 3), .267)
        expect_equal(round(res_g2[3], 3), .194)
        expect_equal(round(res_g2[8], 3), .194)

        # add random weights
        igraph::edge_attr(g2, "weight") = runif(igraph::ecount(g2))
        res_g2_2 = rwbtw(g2)

        # check that weights are used
        expect_false(isTRUE(all.equal(res_g2_2, res_g2)))

    }

})
