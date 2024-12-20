#' Estimate Surface Area of Coral Fragments
#'
#' This function estimates the surface area of coral fragments using the difference in weight with one and two layers of paraffin wax. The conversion factor is based on the study by Veal et al. (2010).
#'
#' @param data A data frame containing the weight measurements of coral fragments. It should have columns `sample_id`, `w1_scratched`, and `w2_scratched`.
#' @param conversion_factor A numeric value representing the conversion factor to estimate the surface area from the weight difference. Default is 34.32.
#'
#' @return A data frame with columns `sample_id` and `area`, where `area` is the estimated surface area of the coral fragments.
#' @importFrom dplyr mutate select %>%
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
get_area <- function(data, conversion_factor = 34.32){

  # only sample, no blanks
  data <- data %>%
    filter(type == "sample")

  # Some tests

  # w_initial higher than w1
  if (any(data$w_initial > data$w1)){
    warning("\nFor the following samples, `w_initial` is higher than `w1`:\n",
            paste(data$sample_id[which(data$w_initial > data$w1)], collapse = "\n"),"\n")
  }


  # w1_scratched higher than w1
  if (any(data$w1_scratched > data$w1)){
    warning("\nFor the following samples, `w1_scratched` is higher than `w1`:\n",
            paste(data$sample_id[which(data$w1_scratched > data$w1)], collapse = "\n"),"\n")
  }

  # w1_scratched higher than w2
  if (any(data$w1_scratched > data$w2)){
    warning("\nFor the following samples, `w1_scratched` is higher than `w2`:\n",
            paste(data$sample_id[which(data$w1_scratched > data$w2)], collapse = "\n"),"\n")
  }

  # w2_scratched higher than w2
  if (any(data$w2_scratched > data$w2)){
    warning("\nFor the following samples, `w2_scratched` is higher than `w2`:\n",
            paste(data$sample_id[which(data$w2_scratched > data$w2)], collapse = "\n"),"\n")
  }

  # w1_scratched higher than w2_scratched
  if (any(data$w1_scratched > data$w2_scratched)){
    warning("\nFor the following samples, `w1_scratched` is higher than `w2_scratched`:\n",
            paste(data$sample_id[which(data$w1_scratched > data$w2_scratched)], collapse = "\n"),"\n")
  }


  data <- data %>%
    dplyr::mutate(delta_w = w2_scratched - w1_scratched,
           area = delta_w * conversion_factor) %>%
    dplyr::select(sample_id, area)

    return(data)
}
