rois <- list(
  ca = c(360, 380),
  fe = c(620, 660),
  cu = c(775, 825),
  sr = c(1390, 1430),
  ti = c(440, 460)
)

channel_positions <- list(
  channel_0 = data.frame(
    ICR = 39,
    OCR = 43,
    s = 27
  ),
  channel_1 = data.frame(
    ICR = 40,
    OCR = 44,
    s = 28
  ),
  channel_2 = data.frame(
    ICR = 41,
    OCR = 45,
    s = 29
  ),
  channel_3 = data.frame(
    ICR = 42,
    OCR = 46,
    s = 30
  )
)

# test coordinate conversions
testthat::test_that("functions",{

  spectra <- diffabs_spectra(
    file = system.file(package = "diffabsr","extdata/demo.nxs"),
    channels = channel_positions)

  elements <- diffabs_elements(
    rois = rois,
    spectra = spectra)

  # test spectra
  expect_is(
    spectra
    ,
    "list"
    )

  # test elements
  expect_is(
    elements
    ,
    "list"
  )

  # test elements
  expect_is(
    diffabs_tidy(elements)
    ,
    "data.frame"
  )

})
