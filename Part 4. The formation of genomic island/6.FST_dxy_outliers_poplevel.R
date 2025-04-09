# Set the working directory
setwd("/set/your/workin/directory")

# Load necessary libraries
library(dplyr)
library(ggplot2)

# Read and clean the data
fst_dxy_pi_all <- read.csv("23pop_win100kb_fst_dxy_pi_invariant.csv.gz") ## can be download from figshare website

# Initialize an empty data frame to collect results
results <- data.frame(dxy=double(), outliers=character(), pop=character())

# Standardize Fst columns (from column 6 to 534)
zfst_scaled <- scale(fst_dxy_pi_all[, 6:534])

# Define population names and prepare data
popnames <- c("1_2", "6_7", "13_16", "9_10", "1_3", "4_7", "10_12", "14_18", "5_19", "2_6")
meta_data <- fst_dxy_pi_all[, 1:5]  # Extract metadata columns (first 5 columns)

# Loop over populations to identify outliers and create a combined data frame
for (pop in popnames) {
  # Extract Fst and dxy for the current population
  Fst <- zfst_scaled[, paste("Fst_", pop, sep="")]
  dxy <- fst_dxy_pi_all[, paste("dxy_", pop, sep="")]
  
  # Combine metadata, dxy, and zFst
  pop_data <- cbind(meta_data, dxy, Fst)
  
  # Classify Fst outliers as Fst > 2
  pop_data <- pop_data %>%
    mutate(outliers = ifelse(Fst > 2, "outlier", "neutral"),
           pop = paste(which(popnames == pop), pop, sep="-"))
  
  # Select and rename the relevant columns
  pop_data_subset <- pop_data %>%
    select(dxy, outliers, pop)
  
  # Append to results
  results <- rbind(results, pop_data_subset)
}

# Remove any remaining missing values
results <- na.omit(results)

# Plot the results
pdf("zfst_2_sym_allo_poplevel.pdf", height=10, width=20)
ggplot(data = results) +
  geom_boxplot(aes(x = pop, y = dxy, color = outliers)) +
  theme_minimal() +
  labs(title = "Dxy and Fst Outliers by Population",
       x = "Population",
       y = "Dxy",
       color = "Outliers")
dev.off()
