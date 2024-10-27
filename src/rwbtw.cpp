#include <RcppArmadillo.h>
// #define DEBUG

//[[Rcpp::depends(RcppArmadillo)]]

//' Random-walk Betweenness
//'
//' @param A (weighted) adjacency matrix
//' @return returns the random walk betweenness of each node
//[[Rcpp::export(.rwbtw)]]
arma::vec rwbtw(const arma::mat& A) {

    if (!A.is_symmetric(1e-10))
        Rcpp::stop("A is not symmetric");

    if (arma::any(arma::vectorise(A) < 0.0))
        Rcpp::stop("A contains negative elements");

    // no of nodes
    arma::uword n = A.n_rows;

    // Laplacian
    arma::mat L = arma::diagmat(arma::sum(A)) - A;

#ifdef DEBUG
    Rcpp::Rcout << "L: " << L << std::endl;
#endif 
    // invert reduced Laplacian
    arma::mat T = arma::inv_sympd(L.submat(0, 0, n - 2, n - 2));

    // add zero columns and rows
    T.insert_rows(n - 1, 1);
    T.insert_cols(n - 1, 1);

#ifdef DEBUG
    Rcpp::Rcout << "T: " << T << std::endl;
#endif 

    arma::cube I_st(n, n, n, arma::fill::zeros);

    for (arma::uword i = 0; i < n; ++i) {

        for (arma::uword s = 0; s < n; ++s) {
        
            for (arma::uword t = 0; t < s; ++t) {

                if (s != t) {
                
                    if (i == s || i == t) {
                    
                        I_st(s, t, i) = 1.0;

                    } else {

                        for (arma::uword j = 0; j < n; ++j)
                            if (i != j)
                                I_st(s, t, i) += 0.5 * A(i, j) * std::abs(T(i, s) - T(i, t) - T(j, s) + T(j, t));
                        
                    }

                }
                
            } 
        } 
    } 


#ifdef DEBUG
    Rcpp::Rcout << "I_st[, , 2]: " << I_st.slice(2) << std::endl;
#endif 

    // get random walk betweenness
    arma::vec b(n);
    for (arma::uword i = 0; i < n; ++i) {

        arma::mat tmpmat = I_st.slice(i);
        b(i) = arma::sum(tmpmat.elem(arma::trimatl_ind(size(tmpmat), -1)));

    }

    b /= 0.5 * n * (n - 1);

    return b;

}

// EOF