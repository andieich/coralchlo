#' Estimate Surface Area of Coral Fragments
#'
#' This function estimates the surface area of coral fragments using the difference in weight with one and two layers of paraffin wax.
#'
#' @param data A data frame containing the weight measurements of coral fragments. It should have columns `sample_id`, `w1_scratched`, and `w2_scratched`.
#' @param method Method used for the estimation of the surface area. Can either be a value based on the study by Veal et al. (2010) (`veal`) or conversion factors based on custom-build calibration objects (`criobe`).
#'
#' @return A data frame with columns `sample_id` and `area`, where `area` is the estimated surface area of the coral fragments.
#' @importFrom dplyr mutate select %>% .data
#'
#' @references Veal, C. J., Holmes, G., Nunez, M., Hoegh-Guldberg, O., & Osborn, J. (2010). A comparative study of methods for surface area and three-dimensional shape measurement of coral skeletons. Limnology and Oceanography: Methods, 8(5), 241–253. \doi{10.4319/lom.2010.8.241}
#'
#' @examples
#' \dontrun{
#' data <- data.frame(
#'   sample_id = c("sample1", "sample2"),
#'   w1_scratched = c(10, 15),
#'   w2_scratched = c(12, 18)
#' )
#' get_area(data)
#' }
#'
#' @export
get_area <- function(data, method){

  # only sample, no blanks
  data <- data %>%
    filter(.data$type == "sample")

  # Some tests

  # w1_scratched higher than w2_scratched
  if (any(data$w1_scratched > data$w2_scratched)){
    warning("\nFor the following samples, `w1_scratched` is higher than `w2_scratched`:\n",
            paste(data$sample_id[which(data$w1_scratched > data$w2_scratched)], collapse = "\n"),"\n")
  }

  if (method == "criobe"){

    intercept <- 0.52
    slope <- 43.6

  } else if (method == "veal"){

    intercept <- 0
    slope <- 34.32

  } else {

    stop(paste("`method` has to be `criobe` or `veal` but was "), method)

  }


  data <- data %>%
    dplyr::mutate(delta_w = .data$w2_scratched - .data$w1_scratched,
                  area = intercept + .data$delta_w * slope) %>%
    dplyr::select(.data$sample_id, .data$area)

    return(data)
}
