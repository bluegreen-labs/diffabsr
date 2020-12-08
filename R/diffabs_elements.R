#' Converts spectra to element count values
#'
#' Uses the output of `diffabs_spectra()` to
#' calculate element counts based upon regions
#' of interest list. Regions of interest are
#' defined by the elements of interest and
#' beamline / detector configurations.
#'
#' Please consult with DIFFABS engineers for
#' setting details.
#'
#' @param spectra the output of diffabs_spectra()
#' @param rois nested list of regions of interest along the spectral
#' domain
#'
#' @return
#' @export
#'
#' @examples

diffabs_elements <- function(
  spectra,
  rois
){
  element_counts <- lapply(
    rois,
    function(roi, spectrum = spectra$spectra){

      cps <- apply(spectrum, 2, function(x){
        caTools::trapz(seq(roi[1],roi[2]), x[roi[1]:roi[2]])
      })

      # return (meta-) data
      return(data.frame(
        cps,
        position = spectra$position
      ))
    })
}
