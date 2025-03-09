library(dplyr)
library(limma)
library(tibble)
new_name_metagx <- read.csv("new_name_metagx_liat.csv",header = T)
metaGx_data <- exp.before.batch
# Creating a dictionary from old to new keys
rename_dict <- setNames(new_name_metagx$real_name, new_name_metagx$old_name)

# Update column names considering only existing columns
colnames(metaGx_data) <- ifelse(colnames(metaGx_data) %in% names(rename_dict),
                                rename_dict[colnames(metaGx_data)],
                                colnames(metaGx_data))
#???????? ?????????????? ???????????? ?????? ???? ???? ???????????? ???? gene 
metaGx_data_transposed <- metaGx_data %>%
  rownames_to_column(var = "Gene")
#merage all of data 
merged_table <- metaGx_data_transposed %>%
  full_join(GSE20194_transposed, by = "Gene") %>%
  full_join(GSE20271_transposed, by = "Gene")
merged_table <- merged_table %>% column_to_rownames(var = "Gene")
#remove all the col with "rep" (8 total )
merged_table <- merged_table %>%
  select(-ends_with("rep"))
write.csv(merged_table,"merged_metaGx_neo.csv")

#test


