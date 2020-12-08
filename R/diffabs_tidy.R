#' Tidy the output of an elemental analysis
#'
#' Converts nested list output of `diffabs_elemental_analysis()` to a
#' tidy format for easy processing.
#'
#' @param spectra the output of `diffabs_elemental_analysis()`
#'
#' @return
#' @export
#'
#' @examples

diffabs_tidy <- function(
  spectra
  ){
  n <- names(spectra)
  l <- length(spectra)
  spectra <- do.call("rbind", spectra)
  element <- do.call("c",
                     lapply(as.list(n), function(x) rep(x, nrow(spectra)/l)))
  return(data.frame(spectra,element))
}
