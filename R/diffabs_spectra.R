#' convert DIFFABS output to corrected spectra
#'
#' Reads in a NXS file and returns spectra, making
#' the necessary corrections
#'
#' @param file an NXS DIFFABS file
#' @param channels a list of detector channels to use
#'
#' @return
#' @export
#'
#' @examples

diffabs_spectra <- function(
  file,
  channels){

  # open hdf5 file
  file.h5 <- hdf5r::H5File$new(file, mode="r+")

  # lets look at the content
  # can't use `names()` as the path base
  # name changes with the filename
  nodes <- file.h5$ls(recursive=TRUE)$name
  position <- file.h5[[nodes[grep("trajectory_1_1", nodes)]]][]
  IO <- file.h5[[nodes[grep("data_02", nodes)]]][]

  # loop over channels sum element wise output
  spectra <- lapply(channels, function(position = channels){

    # get correction parameters
    ICR <- file.h5[[nodes[grep(sprintf("data_%02d", position$ICR), nodes)]]][]
    OCR <- file.h5[[nodes[grep(sprintf("data_%02d", position$OCR), nodes)]]][]
    IO_correction <- ICR/OCR

    # get raw spectra
    s <- file.h5[[nodes[grep(sprintf("data_%02d", position$s), nodes)]]][,]

    # apply corrections to spectra
    s <- t(apply(s, 1, function(x){
      (x / IO) * IO_correction
    }))
  })

  # sum all channel values
  spectra_sum <-
    Reduce("+", spectra)

  # close hdf5 file
  file.h5$close_all()

  # return data
  return(list(
    spectra = spectra_sum,
    position = position))
}
