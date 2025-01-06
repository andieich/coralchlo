#' Read and Combine Metadata from Google Sheets and Calculate Area
#'
#' This function reads metadata from a Google Sheets link and combines data from multiple sheets into a single data frame. After some checks, the area is calculated with the get_area() function.
#'
#' @param googlesheets_link A character string representing the link to the Google Sheets document.
#' @param method Method used for the estimation of the surface area. Can either be a value based on the study by Veal et al. (2010) (`veal`) or conversion factors based on custom-build calibration objects (`criobe`).
#'
#' @return A data frame containing combined metadata from the specified Google Sheets.
#'
#' @importFrom googlesheets4 read_sheet
#' @importFrom janitor clean_names
#' @importFrom dplyr select left_join %>% .data pull
#'
#' @examples
#' \dontrun{
#' googlesheets_link <- "https://docs.google.com/spreadsheets/d/your_sheet_id"
#' read_metadata(googlesheets_link)
#' }
#'
#' @export
read_metadata <- function(googlesheets_link,
                          method = "criobe"){

  #get chl a and overview sheet and explicitly ask for all needed columns
  dat_overview <- googlesheets4::read_sheet(googlesheets_link,
                       sheet = "1. Overview&Chl") %>%
    janitor::clean_names() %>%
    dplyr::select(.data$sample_id,
                  .data$type,
                  .data$w_slurry1,
                  .data$w_slurry2,
                  .data$m1,
                  .data$m2,
                  .data$filename)

  # Find duplicated sample IDs

  #get sample IDs
  sample_ids <- dat_overview %>%
    dplyr::filter(!is.na(.data$sample_id)) %>%
    dplyr::pull(.data$sample_id)

  duplicated_sample_ids <- sample_ids[duplicated(sample_ids)]

  # If there are duplicated values, trigger an error
  if (length(duplicated_sample_ids) > 0) {
    duplicated_sample_ids <- unique(duplicated_sample_ids)
    stop(paste("Duplicated sample names detected for:", paste(duplicated_sample_ids, collapse = ", ")))
  }




  #get count sheet and explicitly ask for all needed columns
  dat_count <- googlesheets4::read_sheet(googlesheets_link,
                          sheet = "2. Counts") %>%
    janitor::clean_names() %>%
    dplyr::select(.data$sample_id,
                  .data$v_zoox,
                  .data$v_sw,
                  .data$c1,
                  .data$c2,
                  .data$c3,
                  .data$c4,
                  .data$c5,
                  .data$c6)



  #get area sheet and explicitly ask for all needed columns
  dat_area <- googlesheets4::read_sheet(googlesheets_link,
                         sheet = "3. Area") %>%
    janitor::clean_names() %>%
    dplyr::select(.data$sample_id,
                  .data$w_initial,
                  .data$w1,
                  .data$w1_scratched,
                  .data$w2,
                  .data$w2_scratched)


  #combine data
  dat_combined <- dplyr::left_join(dat_overview, dat_count, by = "sample_id")

  dat_combined <- dplyr::left_join(dat_combined, dat_area, by = "sample_id")


  # any NA in important columns
  run_na_tests(dat_combined)

  # calculate area

  dat_calulated_area <- get_area(dat_combined,
                                 method = method)

  dat_combined <- dplyr::left_join(dat_combined,
                                   dat_calulated_area,
                                   by = "sample_id")

  return(dat_combined)
}




#' Test for NA Values in Specific Columns
#'
#' This function checks for NA values in specific columns (and combinations) of a data frame and warns if any are found. It exports the row and column names with the NA values.
#'
#' @param data A data frame to be checked for NA values.
#' @param test A logical expression as a string to specify the columns (and combinations) to be checked for NA values.
#' @param col_name A character defining the column that should be printed as warning for the respective test.
#'
#' @examples
#' \dontrun{
#' data <- data.frame(
#'   id = 1:5,
#'   type = c("sample", "control", NA, "sample", "control"),
#'   value = c(10, NA, 15, 20, 25),
#'   col_name = "value"
#' )
#' test_for_na(data, test = 'type == "sample" & is.na(value)')
#' }
#'
#' @export
test_for_na <- function(data, test, col_name) {
  if (any(eval(parse(text = test), envir = data))){

    na_rows <- which(eval(parse(text = test), envir = data))

    warning("\nNA values found in column `",col_name, "` corrsponding to the following rows in `1. Overview&Chl`:\n",
            paste(na_rows, collapse = "\n"),"\n")
  }
}


#' Run a set of test for NA values in coulmns
#'
#' This fucntion uses the test_for_na() fucntion to run test on the important columns in the combined metadata sheet.
#'
#' @param data A data frame to be checked for NA values.
#'
run_na_tests <- function(data){
  test_for_na(data = data,
              test = 'is.na(type)',
              col_name = "type")


  test_for_na(data = data,
              test = 'is.na(filename)',
              col_name = "filename")


  test_for_na(data = data,
              test = 'is.na(m1)',
              col_name = "m1")

  test_for_na(data = data,
              test = 'is.na(m2)',
              col_name = "m2")

  test_for_na(data = data,
              test = 'type == "sample" & is.na(w_slurry1)',
              col_name = "w_slurry1")
  test_for_na(data = data,
              test = 'type == "sample" & is.na(w_slurry2)',
              col_name = "w_slurry2")

  test_for_na(data = data,
              test = 'type == "sample" & is.na(v_zoox)',
              col_name = "v_zoox")
  test_for_na(data = data,
              test = 'type == "sample" & is.na(v_sw)',
              col_name = "v_sw")

  test_for_na(data = data,
              test = 'type == "sample" & is.na(c1)',
              col_name = "c1")
  test_for_na(data = data,
              test = 'type == "sample" & is.na(c2)',
              col_name = "c2")
  test_for_na(data = data,
              test = 'type == "sample" & is.na(c3)',
              col_name = "c3")
  test_for_na(data = data,
              test = 'type == "sample" & is.na(c4)',
              col_name = "c4")
  test_for_na(data = data,
              test = 'type == "sample" & is.na(c5)',
              col_name = "c5")
  test_for_na(data = data,
              test = 'type == "sample" & is.na(c6)',
              col_name = "c6")

  test_for_na(data = data,
              test = 'type == "sample" & is.na(w_initial)',
              col_name = "w_initial")
  test_for_na(data = data,
              test = 'type == "sample" & is.na(w1)',
              col_name = "w1")
  test_for_na(data = data,
              test = 'type == "sample" & is.na(w1_scratched)',
              col_name = "w1_scratched")
  test_for_na(data = data,
              test = 'type == "sample" & is.na(w2)',
              col_name = "w2")
  test_for_na(data = data,
              test = 'type == "sample" & is.na(w2_scratched)',
              col_name = "w2_scratched")
}

