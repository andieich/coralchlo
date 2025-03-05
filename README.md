# `coralchlo`


## Coral Chlorophyll and Symbiodiniaceae Counts

This package helps during the analysis of chlorophyll a data and
Symbiodiniaceae counts. The data has to be prepared following these
[protocols](https://andieich.github.io/coral_chlorophyll_symcounts/).

The package can be installed with the `devtools` package:

``` r
devtools::install_github("andieich/coralchlo")
```

The current version is 0.0.0.7.

After installation, you can load the package and download the metadata
sheet. During this the import of the sheet, some basic test are done to
ensure it was filled out correctly and that the values make sense.

Additionally, the surface area is estimated from the increase in weight
with the additional layer of paraffin wax. Different conversion factors
can be used. Either a value from the literature from @veal2010, or
conversion factors based on custom-made calibration blocks (see
[here](calibration.qmd) for more info). The method can be selected in
the `read_metadata()` function with `method = "veal"` or
`method = "criobe"`. The default selection is `"criobe"`.

``` r
library(coralchlo)

link_metadatasheet <- "example_link"

dat_overview <- read_metadata(link_metadatasheet)
```

Then, the chlorophyll a concentration is calculated based on the
absorption measured with the photometer.

The photometer files (`.csv`) can be store in Google Drive or locally.
If they are stored locally, `path_to_biotekfolder`, is the path to the
folder containing these files. If they are stored in Google Drive,
`path_to_biotekfolder` is the path within the Google Drive to the folder
containing the photometer files. If you use Google Drive, set
`is_googledrive = TRUE`. The files are downloaded to a temporary folder
or to a folder specified in `download_directory`. All files in
`download_directory` will be replaced.

The values are blank-corrected. To ensure that the blank values make
sense, they are plotted for all wavelengths and photometer files. This
can be skipped by setting `plot = FALSE` in the
`normalise_chla_per_area()` function. The area data is used to normalize
the chlorophyll concentration for the surface area of the coral
fragment. For each sample, two measurements were taken, therefore two
chlorophyll a and c2 concentrations will be exported.

``` r
dat_chla <- normalise_chla_per_area(dat_overview,
                                    path_to_biotekfolder = "example_path")
```

![](README_files/figure-commonmark/unnamed-chunk-6-1.png)

``` r
head(dat_chla, n = 10)
```

       sample_id measurement_replicate chl_a_per_cm2 chl_c2_per_cm2 chl_tot_per_cm2
    1   2TSML27P                    m1      1.623838      0.1974951        1.821333
    2   2TSML27P                    m2      1.623838      0.1974951        1.821333
    3   2TSPL07P                    m1      1.549499      0.1820674        1.731566
    4   2TSPL07P                    m2      1.553081      0.1809296        1.734011
    5   2TSAL09P                    m1      2.446933      0.2562347        2.703167
    6   2TSAL09P                    m2      2.446933      0.2562347        2.703167
    7   2TSML26P                    m1      3.853164      0.3458726        4.199037
    8   2TSML26P                    m2      3.853164      0.3458726        4.199037
    9   2TSAL07P                    m1      3.416526      0.3199191        3.736445
    10  2TSAL07P                    m2      3.416292      0.3298182        3.746110

Similarly, the Symbiodiniaceae counts are normalized for the surface
area of the coral fragment. Since six measurements are taken per sample,
six values are exported

``` r
dat_counts <- normalise_counts_per_area(dat_overview)
head(dat_counts, n = 10)
```

       sample_id count_replicate count_per_cm2
    1   2TSML27P              c1       2340544
    2   2TSML27P              c2       2167170
    3   2TSML27P              c3       2600604
    4   2TSML27P              c4       2080483
    5   2TSML27P              c5       2687291
    6   2TSML27P              c6       2253857
    7   2TSPL07P              c1       2977569
    8   2TSPL07P              c2       3447712
    9   2TSPL07P              c3       2899212
    10  2TSPL07P              c4       2429070
