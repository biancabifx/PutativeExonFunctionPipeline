###########################################
#
#Creating tables to match gtex brain tissue samples to their respective rail-RNA IDs used by snaptron.
#Once I have tables of matching ids for each brain tissue type present in gtex, I will use the rail_id's to query those specific samples.
#
###########################################
rm(list=ls()) #Clear R memory
gc() #empty garbage collector

### Load libraries:
library('recount')
library('dplyr')
library('downloader')
library('janitor')
library('xfun')
#install_github('LieberInstitute/jaffelab')
library('jaffelab')
library('rtracklayer')
library('plyr')

#Set working directoy:
work_dir <- "~/Documents/snaptronwork"
setwd(work_dir)

#Load file containing a table with rail_ids and their respective run ids.
#This file was downloaded from http://snaptron.cs.jhu.edu/data/gtex
#This file contains gtex samples of varying tissue types provided within the snaptron package
railtorun <- read.delim(file = "./snapgtex/samples.rid2run_acc.tsv", encoding = "UTF-8")

#Explore available samples.
#Search among GTEx samples, and samples in recount-brain to determine which runs I will use for analysis

#Get recount_brain metadata:
recount_brain_v1 <- recount::add_metadata(source = 'recount_brain_v1')

#Loading objects:
brain <- recount_brain_v1

#Get GTEx metadata:
gtex <- as.data.frame(recount::all_metadata('GTEx'))


#Find GTEx samples that are derived from brains
braingtex <- gtex %>% dplyr::filter(smts == "Brain") %>% group_by(project, smtsd) %>% dplyr::summarise(n = n())

# # A tibble: 13 x 3
# # Groups:   project [1]
# project   smtsd                                         n
# <chr>     <chr>                                     <int>
#   1 SRP012682 Brain - Amygdala                             81
# 2 SRP012682 Brain - Anterior cingulate cortex (BA24)     99
# 3 SRP012682 Brain - Caudate (basal ganglia)             134
# 4 SRP012682 Brain - Cerebellar Hemisphere               118
# 5 SRP012682 Brain - Cerebellum                          145
# 6 SRP012682 Brain - Cortex                              132
# 7 SRP012682 Brain - Frontal Cortex (BA9)                120
# 8 SRP012682 Brain - Hippocampus                         103
# 9 SRP012682 Brain - Hypothalamus                        104
# 10 SRP012682 Brain - Nucleus accumbens (basal ganglia)   123
# 11 SRP012682 Brain - Putamen (basal ganglia)             103
# 12 SRP012682 Brain - Spinal cord (cervical c-1)           76
# 13 SRP012682 Brain - Substantia nigra                     71

#Create subsets of the gtex dataframe based on brain tissue:
amygdala <- gtex[ which(gtex$smtsd == "Brain - Amygdala"),]
acc <- gtex[ which(gtex$smtsd == "Brain - Anterior cingulate cortex (BA24)"),]
caudate <- gtex[ which(gtex$smtsd == "Brain - Caudate (basal ganglia)"),]
cerebellarh <- gtex[ which(gtex$smtsd == "Brain - Cerebellar Hemisphere"),]
cerebellum <- gtex[ which(gtex$smtsd == "Brain - Cerebellum"),]
cortex <- gtex[ which(gtex$smtsd == "Brain - Cortex"),]
frontalcortex <- gtex[ which(gtex$smtsd == "Brain - Frontal Cortex (BA9)"),]
hippoc <- gtex[ which(gtex$smtsd == "Brain - Hippocampus"),]
hypo <- gtex[ which(gtex$smtsd == "Brain - Hypothalamus"),]
nucacc <- gtex[ which(gtex$smtsd == "Brain - Nucleus accumbens (basal ganglia)"),]
putamen <- gtex[ which(gtex$smtsd == "Brain - Putamen (basal ganglia)"),]
spinalc <- gtex[ which(gtex$smtsd == "Brain - Spinal cord (cervical c-1)"),]
subnigra <- gtex[ which(gtex$smtsd == "Brain - Substantia nigra"),]

#See which rail_ids are needed to represent the run id for each tissue sample:
#First, make the column for "run" identical for both dataframes:
colnames(railtorun) [2] <- "run" 

#Retrieve corresponding rail_ids for each tissue type by joining the gtex subset tissue dataframes and the railtorun dataframe by the "run" id which they have in common:
amygdala_1 <- join(amygdala, railtorun, by = "run", type = "left")
amygdala_2 <- amygdala_1$rail_id
amygdala_rail <- paste(amygdala_2, collapse = ",")
amygdala_rail
#[1] "53969,54029,54069,54255,53362,53363,52741,52908,58590,58832,58950,59009,54962,55002,55172,57589,57592,54294,54301,51573,50769,50772,50817,50846,50962,50965,51060,56865,56911,57081,57126,57192,50507,50537,50589,50651,50159,50163,50210,50213,50276,50355,50371,55949,56130,56165,56190,56206,52670,51755,52002,58163,58205,58450,54782,54913,58050,58080,59480,59505,59138,59329,53116,52077,52163,52292,55575,55584,55626,55693,55769,55318,55503,56596,56700,56803,51194,51227,51231,56231,56352"

acc_1 <- join(acc, railtorun, by = "run", type = "left")
acc_2 <- acc_1$rail_id
acc_rail <- paste(acc_2, collapse = ",")

caudate_1 <- join(caudate, railtorun, by = "run", type = "left")
caudate_2 <- caudate_1$rail_id
caudate_rail <- paste(caudate_2, collapse = ",")

cerebellarh_1 <- join(cerebellarh, railtorun, by = "run", type = "left")
cerebellarh_2 <- cerebellarh_1$rail_id
cerebellarh_rail <- paste(cerebellarh_2, collapse = ",")

cerebellum_1 <- join(cerebellum, railtorun, by = "run", type = "left")
cerebellum_2 <- cerebellum_1$rail_id
cerebellum_rail <- paste(cerebellum_2, collapse = ",")

cortex_1 <- join(cortex, railtorun, by = "run", type = "left")
cortex_2 <- cortex_1$rail_id
cortex_rail <- paste(cortex_2, collapse = ",")

frontalcortex_1 <- join(frontalcortex, railtorun, by = "run", type = "left")
frontalcortex_2 <- frontalcortex_1$rail_id
frontalcortex_rail <- paste(frontalcortex_2, collapse = ",")

hippoc_1 <- join(hippoc, railtorun, by = "run", type = "left")
hippoc_2 <- hippoc_1$rail_id
hippoc_rail <- paste(hippoc_2, collapse = ",")

hypo_1 <- join(hypo, railtorun, by = "run", type = "left")
hypo_2 <- hypo_1$rail_id
hypo_rail <- paste(hypo_2, collapse = ",")

nucacc_1 <- join(nucacc , railtorun, by = "run", type = "left")
nucacc_2 <- nucacc_1$rail_id
nucacc_rail <- paste(nucacc_2, collapse = ",")

putamen_1 <- join(putamen, railtorun, by = "run", type = "left")
putamen_2 <- putamen_1$rail_id
putamen_rail <- paste(putamen_2, collapse = ",")

spinalc_1 <- join(spinalc, railtorun, by = "run", type = "left")
spinalc_2 <- spinalc_1$rail_id
spinalc_rail <- paste(spinalc_2, collapse = ",")

subnigra_1 <- join(subnigra, railtorun, by = "run", type = "left")
subnigra_2 <- subnigra_1$rail_id
subnigra_rail <- paste(subnigra_2, collapse = ",")

#Now that I have lists of the rail_ids, I can use them for snaptron queries by searching for putative novel exons within samples of a specific tissue type.
#Here is an example of the amygdala search output:
#./qs --region "chr1:6145799-6145853" --datasrc gtex --samples '53969,54029,54069,54255,53362,53363,52741,52908,58590,58832,58950,59009,54962,55002,55172,57589,57592,54294,54301,51573,50769,50772,50817,50846,50962,50965,51060,56865,56911,57081,57126,57192,50507,50537,50589,50651,50159,50163,50210,50213,50276,50355,50371,55949,56130,56165,56190,56206,52670,51755,52002,58163,58205,58450,54782,54913,58050,58080,59480,59505,59138,59329,53116,52077,52163,52292,55575,55584,55626,55693,55769,55318,55503,56596,56700,56803,51194,51227,51231,56231,56352' 1> amygdalatest.tsv
amygdalatest <- read.delim(file = "./snapout/amygdalatest.tsv", encoding = "UTF-8")

#Divide the total number of samples that had one or more reads covering the intron by the total number of gtex amygdala sampels:
length(amygdalatest$samples) / length(amygdala_2)
#[1] 0.617284
#Approximately 62% of samples had one or more reads covering the intron.

#The following illustrates the average coverage of those samples which had one or more reads covering the intron:
amygdalatest$coverage_avg
# [1]  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000
# [10]  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000
# [19]  1.736842  1.000000  2.000000  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000
# [28]  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000
# [37]  1.000000  1.000000  1.000000  1.000000  1.000000  1.200000  1.000000  1.000000  1.350000
# [46]  1.000000  1.428571 15.253333  1.000000  1.000000


# #Save all tissue ids within a file as .RData
# grep("*_rail", ls())
# # [1]  4  8 14 18 22 26 30 35 39 43 47 53 57
# railids <- grep("*_rail", ls())
# railids <- ls(railids)

#Save all rail id sample lists as objects, representing each tissue:
save(acc_rail, file="~/Documents/splice_project/data/analysis/acc_rail.Rdata")
save(amygdala_rail, file="~/Documents/splice_project/data/analysis/amygdala_rail.Rdata")
save(caudate_rail, file="~/Documents/splice_project/data/analysis/caudate_rail.Rdata")
save(cerebellarh_rail, file="~/Documents/splice_project/data/analysis/cerebellarh_rail.Rdata")
save(cerebellum_rail, file="~/Documents/splice_project/data/analysis/cerebellum_rail.Rdata")
save(cortex_rail, file="~/Documents/splice_project/data/analysis/cortex_rail.Rdata")
save(frontalcortex_rail, file="~/Documents/splice_project/data/analysis/frontalcortex_rail.Rdata")
save(hippoc_rail, file="~/Documents/splice_project/data/analysis/hippoc_rail.Rdata")
save(hypo_rail, file="~/Documents/splice_project/data/analysis/hypo_rail.Rdata")
save(nucacc_rail, file="~/Documents/splice_project/data/analysis/nucacc_rail.Rdata")
save(putamen_rail, file="~/Documents/splice_project/data/analysis/putamen_rail.Rdata")
save(spinalc_rail, file="~/Documents/splice_project/data/analysis/spinalc_rail.Rdata")
save(subnigra_rail, file="~/Documents/splice_project/data/analysis/subnigra_rail.Rdata")
