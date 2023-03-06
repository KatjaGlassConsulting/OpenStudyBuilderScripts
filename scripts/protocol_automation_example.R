library(httr)
library(officer)

# Switch to the corresponding working directory
setwd("C:/temp/git/OpenStudyBuilderScripts/scripts")

api_url <- "http://localhost:5003"
response <- GET(paste(api_url,"studies", "Study_000001", "protocol-title", sep = "/"))
study_1_prot_title <- jsonlite::fromJSON(rawToChar(response$content))
study_title = toString(study_1_prot_title["study_title"])

print(study_title)

protocol_doc <- read_docx(path = "./files/protocol_example_input.docx")
body_replace_all_text(
  protocol_doc,
  "<study title>",
  study_title)
print(protocol_doc, target = "./files/protocol_example_output_r.docx")


