#' Normalise Cell Counts for Surface Area of Coral Fragments
#'
#' This function calculates the original number of cells in the tissue slurry and then normalises these counts for the surface area of a coral fragment.
#'
#' @param data A data frame containing the cell counts and other relevant measurements. It should have columns `c1` to `c6` representing count replicates, `v_zoox`, `v_sw`, `w1`, `w2`, and `area`.
#' @param v_ml_count A numeric value representing the volume in milliliters added into the counting chamber. Default is 0.01 mL (= 10 µL).
#' @param v_ml_sw_added A numeric value representing the volume in milliliters of seawater added. Default is 3 mL.
#' @param v_ml_sw_pipetted A numeric value representing the volume in milliliters of seawater pipetted. Default is 1 mL.
#'
#' @return A data frame with normalised cell counts per surface area of coral fragments.
#'
#' @importFrom dplyr mutate select %>%
#' @importFrom tidyr pivot_longer
#'
#' @examples
#' \dontrun{
#' data <- data.frame(
#'   sample_id = c("sample1", "sample2"),
#'   c1 = c(110, 160),
#'   c2 = c(105, 155),
#'   c3 = c(115, 165),
#'   c4 = c(120, 170),
#'   c5 = c(125, 175),
#'   c6 = c(130, 180),
#'   v_zoox = c(1, 1),
#'   v_sw = c(2, 2),
#'   w1 = c(0.5, 0.5),
#'   w2 = c(1, 1),
#'   area = c(10, 15)
#' )
#' normalise_counts_per_area(data)
#' }
#'
#' @export
normalise_counts_per_area <- function(data,
                                      v_ml_count = 0.01,
                                      v_ml_sw_added = 3,
                                      v_ml_sw_pipetted = 1) {
  data <- data %>%
    dplyr::filter(type == "sample")

  data %>%
    tidyr::pivot_longer(cols = c1:c6,
                        names_to = "count_replicate",
                        values_to = "count_subsample") %>% #make long
    dplyr::mutate(dillution_factor = v_zoox / (v_zoox + v_sw)) %>%
    dplyr::mutate(count_per_mL = 1000 * count_subsample / (dillution_factor * v_ml_count)) %>%
    dplyr::mutate(count_per_sample = count_per_mL * (v_ml_sw_added / v_ml_sw_pipetted) * (w2 / w1)) %>%
    dplyr::mutate(count_per_cm2 = count_per_sample / area) %>%
    dplyr::select(sample_id, count_replicate, count_per_cm2)
}
