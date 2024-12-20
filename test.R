library(coralchlo)
library(tidyverse)
library(googledrive)

dat_overview <- read_metadata("https://docs.google.com/spreadsheets/d/1KP-_yEQoHC9zHPlVpf3ob9BRJ60qNiGJsdZsO-l3ljw/edit?gid=0#gid=0")

dat_counts <- normalise_counts_per_area(dat_overview)

dat_chla <- normalise_chla_per_area(dat_overview,
                                    path_to_biotekfolder = "/Users/andi/Desktop/test_files")









#explicitly ask for all needed columns

dat_ov <- read_sheet(link_meta,
                     sheet = "1. Overview&Chl") %>%
  clean_names() %>%
  dplyr::select(sample_id,
         type,
         w_slurry1,
         w_slurry2,
         m1,
         m2,
         filename)



dat_count <- read_sheet(link_meta,
                     sheet = "2. Counts") %>%
  clean_names() %>%
  dplyr::select(sample_id,
         v_zoox,
         v_sw,
         c1,
         c2,
         c3,
         c4,
         c5,
         c6)



dat_area <- read_sheet(link_meta,
                        sheet = "3. Area") %>%
  clean_names() %>%
  dplyr::select(sample_id,
                w_initial,
                w1,
                w1_scratched,
                w2,
                w2_scratched)


dat <- left_join(dat_ov, dat_count, by = "sample_id")

dat <- left_join(dat, dat_area, by = "sample_id")

# any NA in important columns
run_na_tests(dat)

dat_area2 <- get_area(dat)



normalise_counts_per_area(dat_area2)


