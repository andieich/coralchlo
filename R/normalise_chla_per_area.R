#' Normalise Chlorophyll Concentration for Surface Area of Coral Fragments
#'
#' This function calculates the chlorophyll concentration in a coral fragment, normalised for the surface area of that coral fragment, based on absorption measurements. The formula to convert absorptions to chlorophyll concentration comes from Jeffrey & Humphrey (1975).
#'
#' @param data A data frame containing metadata for the samples.
#' @param pl A numeric value representing the path length in cm. Default is 1.
#' @param v_ml_sw_added A numeric value representing the volume in milliliters of seawater added. Default is 3 mL.
#' @param v_ml_sw_pipetted A numeric value representing the volume in milliliters of seawater pipetted. Default is 1 mL.
#' @param path_to_biotekfolder A character string representing the path to the folder containing Biotek files.
#' @param is_googledrive A logical value indicating whether the Biotek files are stored on Google Drive. Default is FALSE.
#' @param download_directory A character string representing the directory to download files if they are stored on Google Drive. Default is NA. All files in that directory will be replaced.
#' @param plot A logical value indicating whether to plot the absorption values for blanks and samples. Default is TRUE.
#'
#' @return A data frame with columns `sample_id` and `chl_a_per_cm2`, representing the chlorophyll concentration normalised for surface area.
#'
#' @references Jeffrey, S. W., & Humphrey, G. F. (1975). New spectrophotometric equations for determining chlorophylls a, b, c1 and c2 in higher plants, algae and natural phytoplankton. Biochemie Und Physiologie Der Pflanzen, 167(2), 191–194. \doi{10.1016/S0015-3796(17)30778-3}
#'
#' @importFrom dplyr filter group_by summarise ungroup mutate select left_join setdiff
#' @importFrom tidyr pivot_longer
#' @importFrom ggplot2 ggplot aes geom_point position_jitterdodge facet_wrap theme_minimal theme element_text
#'
#' @examples
#' \dontrun{
#' data <- data.frame(
#'   sample_id = c("sample1", "sample2"),
#'   type = c("sample", "sample"),
#'   w1 = c(0.5, 0.5),
#'   w2 = c(1, 1),
#'   area = c(10, 15),
#'   filename = c("file1", "file2"),
#'   m1 = c(1, 2),
#'   m2 = c(3, 4)
#' )
#' path_to_biotekfolder <- "path/to/biotek/files"
#' normalise_chla_per_area(data, path_to_biotekfolder = path_to_biotekfolder)
#' }
#'
#' @export
normalise_chla_per_area <- function(data,
                                    pl = 1,
                                    v_ml_sw_added = 3,
                                    v_ml_sw_pipetted = 1,
                                    path_to_biotekfolder,
                                    is_googledrive = FALSE,
                                    download_directory = NA,
                                    plot = TRUE){

  # Get photometer data
  data_photometer <- import_biotek2_files(path_to_biotekfolder = path_to_biotekfolder,
                                          is_googledrive = is_googledrive,
                                          download_directory = download_directory)


  # all files from metadata in read into data_photometer?
  fn_metadata <- data$filename %>%
    unique()

  fn_data_photometer <- data_photometer$filename %>%
    unique()

  missing_files <- dplyr::setdiff(fn_metadata, fn_data_photometer)

  if (length(missing_files) > 0) {
    stop("The following filenames in `fn_metadata` were not found in `fn_data_photometer`:\n",
            paste(missing_files, collapse = "\n"))
  }


  # transform metadata to long df, i.e. position of replicate measurement in 2 rows
  data_long <- data %>%
    tidyr::pivot_longer(cols = c('m1', 'm2'),
                 names_to = 'measurement',
                 values_to = 'position')

  print(data_long)

  # test for duplicated positions
  verify_unique_positions(data_long)

  verify_positions(data_long, data_photometer)

  # combine metadata sheet and photometer data
  data_chlorophyll <- left_join(data_long, data_photometer,
              by = c("filename", "position"))

  # separate blanks and calculate mean per file name (= measurement)
  data_blanks <- data_chlorophyll %>%
    dplyr::filter(type == "blank") %>%
    dplyr::group_by(filename) %>%
    dplyr::summarise(mean_abs_663 = round(mean(abs_663),3),
              mean_abs_630 = round(mean(abs_630),3),
              mean_abs_750 = round(mean(abs_750),3),
              mean_abs_470 = round(mean(abs_470),3)) %>%
    dplyr::ungroup()

  # blank correct measurements
  data_chlorophyll <- data_chlorophyll %>%
    left_join(data_blanks, by = "filename") %>%
    mutate(abs_663_c = round(abs_663 - mean_abs_663,3),
           abs_630_c = round(abs_630 - mean_abs_630,3),
           abs_750_c = round(abs_750 - mean_abs_750,3),
           abs_470_c = round(abs_470 - mean_abs_470,3))

  # plot the values for blanks and samples for each wavelength for each filename
  # this helps e.g. to find false blank measurements
  if (plot){
    plot_abs <- data_chlorophyll %>%
      dplyr::select(sample_id, type, filename, abs_663_c : abs_470_c) %>%
      tidyr::pivot_longer(abs_663_c : abs_470_c, names_to = "wavelength", values_to = "absorption") %>%
      ggplot2::ggplot(ggplot2::aes(x = filename, y = absorption, col = type))+
      ggplot2::geom_point(position = ggplot2::position_jitterdodge(jitter.width = .3, dodge.width = .6), shape = 21)+
      ggplot2::facet_wrap(~wavelength, scales = "free_y")+
      ggplot2::theme_minimal() +
      ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0.5, hjust=1))

    print(plot_abs)
  }


  # filter only samples
  data_chlorophyll <- data_chlorophyll %>%
    dplyr::filter(type == "sample")

  # calculate chlorophyll with formula in Jeffrey & Humphrey (1975), correct for volume
  data_chlorophyll <- data_chlorophyll %>%
    dplyr::mutate(chl_a_subsample = 11.43 * (abs_663_c - abs_750_c) / pl - 0.64 * (abs_630_c - abs_750_c)/pl) %>% #in µg per mL
    dplyr::mutate(chl_a_per_sample = chl_a_subsample * (v_ml_sw_added / v_ml_sw_pipetted) * (w2 / w1)) %>% # µg in whole sample. of V_slurry, 40 mL were centrifuged
    #and filled up with 3 mL SSW, 1 mL of SSW was centrifuged and 1 mL acetone added, 0.5 mL acetone measured.
    # c in 0.5 mL is the absolute amount in the 1 mL, 3 is multiplied because after centrifucation of the 40 mL, only 1 mL is taken for chl.
    # This is the absolute amount in the 40 mL that were centrifuged
    # (w2 / w1) is multiplied to consider that V_slurry was more than 40 mL
    dplyr::mutate(chl_a_per_cm2 = chl_a_per_sample/area)


  # clean
  data_chlorophyll <- data_chlorophyll %>%
    dplyr::select(sample_id,
           chl_a_per_cm2)

  return(data_chlorophyll)
}



#' Verify Unique Positions per Filename
#'
#' This function verifies that each position only occurs once per filename in a data frame. If a duplicated position for one filename is found, it prints the filename followed by the positions.
#'
#' @param data A data frame containing columns `filename` and `position`.
#'
#' @return A logical value indicating whether all positions are unique per filename.
#'
#' @examples
#' \dontrun{
#' data <- data.frame(
#'   filename = c("file1.txt", "file1.txt", "file2.txt", "file2.txt", "file2.txt"),
#'   position = c(1, 2, 1, 1, 3)
#' )
#' verify_unique_positions(data)
#' }
#'
#' @export
verify_unique_positions <- function(data) {
  duplicated_positions <- data %>%
    dplyr::group_by(filename, position) %>%
    dplyr::filter(dplyr::n() > 1) %>%
    dplyr::ungroup()

  if (nrow(duplicated_positions) > 0) {
    duplicated_filenames <- unique(duplicated_positions$filename)

    for (filename in duplicated_filenames) {
      positions <- duplicated_positions %>%
        dplyr::filter(filename == !!filename) %>%
        dplyr::pull(position)

      stop("In the metadata sheet for ", filename, ", the following positions are duplicated:\n", paste(unique(positions), collapse = ", "), "\n\n")
    }

    return(FALSE)
  } else {
    return(TRUE)
  }
}

#' Verify Positions in Data Frames
#'
#' This function checks if all positions in `data_1` occur in `data_2` for each filename. If there are positions in `data_1` that do not occur in `data_2`, it prints a warning with the filename followed by the positions.
#'
#' @param data_1 A data frame containing columns `filename` and `position`.
#' @param data_2 A data frame containing columns `filename` and `position`.
#'
#' @return A logical value indicating whether all positions in `data_1` occur in `data_2`.
#'
#' @examples
#' \dontrun{
#' data_1 <- data.frame(
#'   filename = c("file1.txt", "file1.txt", "file2.txt", "file2.txt"),
#'   position = c(1, 2, 1, 4)
#' )
#' data_2 <- data.frame(
#'   filename = c("file1.txt", "file1.txt", "file2.txt", "file2.txt"),
#'   position = c(1, 2, 1, 3)
#' )
#' verify_positions(data_1, data_2)
#' }
#'
#' @export
verify_positions <- function(data_1, data_2) {
  missing_positions <- data_1 %>%
    dplyr::anti_join(data_2, by = c("filename", "position"))

  if (nrow(missing_positions) > 0) {
    missing_filenames <- unique(missing_positions$filename)

    for (filename in missing_filenames) {
      positions <- missing_positions %>%
        dplyr::filter(filename == !!filename) %>%
        dplyr::pull(position)

      stop("The follwong positions in the metadata sheet for ", filename, " do not exist in the photometer data:\n ", paste(positions, collapse = ", "), "\n\n")
    }

    return(FALSE)
  } else {
    return(TRUE)
  }
}



