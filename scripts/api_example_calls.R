# CURL example to get API results from OpenStudyBuilder
#
# Remark - you can get the current bearer token by executing by calling the API from the browser and copy the token
#   goto - https://openstudybuilder.northeurope.cloudapp.azure.com/api/docs#/Studies/get_all_studies_get
#   click "authorize" top right lock symbol, then "authorize"
#   click "try it out"
#   remove everything from the "filters" field
#   click "execute"
#   copy the bearer token from the CURL command (long string after "-H 'Authorization: Bearer ")
#

# setup for sandbox environment
api_url <- "https://openstudybuilder.northeurope.cloudapp.azure.com/api"
api_bearer <- "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6Ii1LSTNROW5OUjdiUm9meG1lWm9YcWJIWkdldyJ9.eyJhdWQiOiI2ZDdmMTFkOC1kMTUwLTQ0ODctYjVlZi03NzQyM2IxYWU1MTMiLCJpc3MiOiJodHRwczovL2xvZ2luLm1pY3Jvc29mdG9ubGluZS5jb20vNTRlODU3MjUtZWQyYS00OWE0LWExOWUtMTFjOGQyOWY5YTBmL3YyLjAiLCJpYXQiOjE2NzQ0ODExODAsIm5iZiI6MTY3NDQ4MTE4MCwiZXhwIjoxNjc0NDg2Nzg0LCJhaW8iOiJBWFFBaS84VEFBQUE3ZW9QMmtzZUdYSHA0OWVGRTQxYWFKMUxUVHNWUDBMVXFEcGNhdVBPNm5Qb2x1YUJ2SDJ3K28zNnlZSlBqZm9TZWtIWmNlZFphbWloUkYva1gwSVdaNmExR25JU1lUYWdybEJ2RXJYdERGcFBpSit4c1l6MEM5cXM0blF0WlhET0hVcjNVazIrNGF2Z1lWVDUwaktoc2c9PSIsImF6cCI6ImU2NmFlYzU4LWFlMGMtNGMzMS05Mzg5LTM0ZTAwNjdhZjNiZCIsImF6cGFjciI6IjAiLCJpZHAiOiJtYWlsIiwibmFtZSI6ImthdGphLmdsYXNzIiwib2lkIjoiZDY4ZWI1MmYtOTI4Zi00MzY0LTgzMWUtYTk0MjM5ZWE4ZDdhIiwicHJlZmVycmVkX3VzZXJuYW1lIjoia2F0amEuZ2xhc3NAZ2xhY29uLmV1IiwicmgiOiIwLkFYWUFKVmZvVkNydHBFbWhuaEhJMHAtYUQ5Z1JmMjFRMFlkRXRlOTNRanNhNVJOMkFIMC4iLCJzY3AiOiJBbGwgQVBJLmNhbGwiLCJzdWIiOiJpVXppbFlGbkVUblQ2WmVyTHY5QzgxVjFtLXRKSXd5dFFzRkw1T092Uk9RIiwidGlkIjoiNTRlODU3MjUtZWQyYS00OWE0LWExOWUtMTFjOGQyOWY5YTBmIiwidXRpIjoiNHhKY2pQa3VjMGU3akJpYTdSb2lBQSIsInZlciI6IjIuMCJ9.sz2PjJWHEnG-ydYFCUFheSQdTdHA1nrml5_53GRn3DK7lWm4yXIIiEQ-6INcs3rxiKTlkpY6Z9zPEa11kWNZ5EV_CIiCz8q2_3C3CTtFexrD1u_Uf-FJdePzeWEwJWnX2k-Tm9_z4KpxRzPF6tdvkWBdkXU9BPwwQnkI_x0pB4XC5W3Ag1w4sI_h0uZM8VQGhQqUO9fx6nA3JJjQYYRP4BjiXg3e5vTKPfPr2YqyDSVVMVb8z9As39JSfU0HQR-Luht5b63ohvWA4zg9VW876txYEM6rbrqWeJH3Vc0ZEaN6vKkwKc1qcFZ6dqBI4CmKiNZ8tdxyeVWG7BZuEs12Kw"

library(httr)

response <- GET(paste(api_url,"studies", sep = "/"), add_headers(Authorization = paste("Bearer", api_bearer)))
studies <- jsonlite::fromJSON(rawToChar(response$content))

#str(studies)
#print(studies)
#print(studies[][["items"]][["uid"]])
#print(studies[][["items"]][["study_id"]])

cat(studies[][["items"]][["uid"]], studies[][["items"]][["study_id"]])



response <- GET(paste(api_url,"ct/terms?codelist_name=Sex", sep = "/"), add_headers(Authorization = paste("Bearer", api_bearer)))
ct_sex <- jsonlite::fromJSON(rawToChar(response$content))

print(ct_sex[["items"]][["name"]][["sponsor_preferred_name"]])
