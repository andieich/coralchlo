
#' Import and clean Biotek2 files
#'
#' This function imports and cleans all `.csv` files from a specified folder. It can handle files from a local directory or from a Google Drive folder.
#'
#' @param path_to_biotekfolder A character string specifying the path to the folder containing the `.csv` files.
#' @param is_googledrive A logical value indicating whether the folder is on Google Drive. Default is `FALSE`.
#' @param download_directory A character string specifying the directory to download the files to if `is_googledrive` is `TRUE`. If not specified, a temporary directory will be used. All files in `download_directory` will be replaced.
#' @return A data frame containing the cleaned data from all `.csv` files.
#' @importFrom googledrive drive_ls drive_get drive_download as_id
#' @importFrom purrr map_dfr
#' @importFrom dplyr mutate mutate_at filter %>% .data
#' @importFrom dplyr %>% .data
#' @importFrom janitor clean_names
#'@importFrom utils read.csv
#' @examples
#' \dontrun{
#' # Read and clean files from a local directory
#' data <- read_all_biotek2_files("path/to/local/folder")
#'
#' # Read and clean files from a Google Drive folder
#' data <- read_all_biotek2_files("your-google-drive-folder-id", is_googledrive = TRUE)
#' }

import_biotek2_files<- function(path_to_biotekfolder, is_googledrive = FALSE, download_directory = NA){
  # fiels in download_path will be replaced

  if (!is_googledrive) {

    # get list of all .csv files
    csv_files_in_folder <- list.files(path_to_biotekfolder, pattern = '.csv')

    # make path to .csv files
    csv_paths <- paste(path_to_biotekfolder , csv_files_in_folder, sep = '/')

  } else if (is_googledrive) {

    # get all csv files in drive folder
    csv_files_in_gdrivefolder <- googledrive::drive_ls(path = path_to_biotekfolder, pattern = ".csv")

    # create temporary folder if download folder is not specified
    if(is.na(download_directory)){
      download_directory <- file.path(tempdir(), "googledrive_downloads")
    }

    # remove if exists
    if(dir.exists(download_directory)){
      unlink(download_directory, recursive = TRUE)
    }

    # create folder
    dir.create(download_directory)

    # Download all files
    lapply(csv_files_in_gdrivefolder$id, function(file_id) {

      download_file_path <- file.path(download_directory, drive_get(as_id(file_id))$name)

      googledrive::drive_download(as_id(file_id),
                                  overwrite = TRUE,
                                  path = download_file_path)
    })

    # get path to .csv files
    csv_paths <- paste(download_directory , csv_files_in_gdrivefolder$name, sep = '/')

    } else {

    stop("`is_googledrive` has to be TRUE or FALSE")

  }

  #import and clean data
  clean_data <- csv_paths %>%
    purrr::map_dfr(read_and_clean_file)

  return(clean_data)

}



#' Read and Clean a Single Biotek2 File
#'
#' This function reads and cleans a single `.csv` file and is called by `read_all_biotek2_files()`.
#'
#' @param path_to_file A character string specifying the path to the `.csv` file.
#' @return A data frame containing the cleaned data from the `.csv` file.
#' @importFrom janitor clean_names
#' @importFrom dplyr mutate mutate_at vars filter if_all
#'
read_and_clean_file <- function(path_to_file){

  data <- utils::read.csv(path_to_file)[,2:7]#get rid of type and blank corrected values

  print(path_to_file)
  data <- data %>%
    janitor::clean_names() %>%
    dplyr::mutate(position = as.character(.data$position)) %>%
    dplyr::mutate_at(dplyr::vars(2:6),
              list(as.numeric)) %>%
    dplyr::filter(!dplyr::if_all(2:6, ~ is.na(.))) %>% # delete rows containing only NA values
    dplyr::mutate(filename = basename(path_to_file)) %>%
    dplyr::mutate(filename = substr(.data$filename, 1, nchar(.data$filename)-4))

    return(data)

}

