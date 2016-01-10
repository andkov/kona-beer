# knitr::stitch_rmd(script="./manipulation/car-ellis.R", output="./manipulation/stitched-output/car-ellis.md")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.

# ---- load_sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
# source("http://statpower.net/Content/312/R%20Stuff/Steiger%20R%20Library%20Functions.txt")
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")

# ---- load_packages -----------------------------------------------------------
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr) #Pipes
library(ggplot2) #For graphing


# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("ggplot2", quietly=TRUE)
requireNamespace("dplyr", quietly=TRUE) #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit", quietly=TRUE)
# requireNamespace("plyr", quietly=TRUE)



# ---- load_data ---------------------------------------------------------------
input_beer <- c(
  "Duke's", "Blond Ale", "18", "4.9", "11.5", "Light", 
  "Hula Hef", "Hefeweisen", "16", "5", "11.5", "Wheat", 
  "Koko Brown", "Brown Ale", "26.7", "5.5", "13.69", "Roasted",    
  "Black Sand", "Porter", "45", "4.9", "15", "Roasted",
  "Lavaman", "Red Ale", "30", "5.6", "13.5", "Malty",   
  "Pipeline", "Porter", "23", "5.3", "13.4", "Roasted", 
  
  "Longboard", "Lager", "20", "4.6", "10.95", "Light", 
  "Big Wave", "Golden Ale", "21", "4.4", "10.3", "Light", 
  "Castaway", "India Pale Ale", "50", "6", "14.3",   "Hoppy", 
  "Fire Rock", "Pale Ale", "35", "6", "13.95",  "Malty", 
  "Wailua Wheat", "Golden Ale", "14.5", "5.4", "12", "Wheat",   
  
  "Lemongrass Lu'au", "Blond Ale", "20", "5.8", "11.5", "Light", 
  "Kua Bay", "India Pale Ale", "64", "7", NA, "Hoppy"

)

m <- matrix(input_beer, nrow =13, ncol=6, byrow = T)
ds <- as.data.frame(m, stringsAsFactors = F)
colnames(ds) <- c("beer","brew", "bitterness", "alcohol", "gravity", "type")
ds <- ds[,c("beer", "brew", "type", "bitterness", "alcohol", "gravity")]


# ---- tweak_data --------------------------------------------------------------
ds$beer <- as.factor(ds$beer)
ds$brew <- as.factor(ds$brew)

ds$bitterness <- as.numeric(ds$bitterness)
ds$alcohol <- as.numeric(ds$alcohol)
ds$gravity <- as.numeric(ds$gravity)

ds$type <- ordered(ds$type, levels = c("Light", "Wheat", "Hoppy", "Malty", "Roasted"))

# ---- declare_globals ---------------------------------------------------------
# pub menu :http://konabrewingco.com/wp-content/blogs.dir/5/files/2015/09/KON_2015-Menu-Update_Kona-Food_Web.pdf

beer_type <- c("Light", "Wheat", "Hoppy", "Malty", "Rosted")

beer_color_type <- c(
  "Light" = "#f8d555", 
  "Wheat" = "#fdc043", 
  "Hoppy"= "#fdc043", 
  "Malty"= "#b4572e", 
  "Roasted"= "#603b29"
)

# ---- compute_distance --------------------------------------------------------

cor(ds$gravity, ds$alcohol)



# ---- save_to_disk ------------------------------------------------------------
# Save as a compress, binary R dataset.  It's no longer readable with a text editor, but it saves metadata (eg, factor information).
# saveRDS(ds, file=path_output, compress="xz")
