# Protocol automation

A main advantage for the OpenStudyBuilder usage is the opportunity to automate downstream systems and tools. To support connectivity and downstream usage, the API provides a standard interface to the data. One use case is the protocol automation. The OpenStudyBuilder project has shown that the protocol automation is working - they do have a Word-Addin which is unluckily not available as open-source. But to get an idea of the functionality, please checkout the [video](https://novo-nordisk.gitlab.io/nn-public/openstudybuilder/project-description/info_ddf/#integration-to-protocol-and-sdtm-study-design-data) for the procol automation.

There are various ways how the protocol could be automated. I would assume that Word is the prefered format at least for the first automation prototypes. 

## VBA utilization

An obvious solution would be to utilize VBA. I would not recommend VBA, as this required an active Word instance to run and is programmatically also not the most modern choice of programming language. On the other side VBA is designed to work with those documents and you can do anything you need.

With VBA you can easily search and replace text and do much more. The question is how to get the data for your study. And this is done through the API. The following example shows to get the study title. Information of the protocol-title are read in as JSON format. Unluckily there is no in-build JSON library available for VBA. But you could search and download a package. For demonstration purposes, we just extract the title from the JSON reponse via a text split.

```
Sub Get_study_title()
    Dim xmlhttp As Object
    Dim url As String
    Dim jsonResponse As String
    Dim title As String
    
    Set xmlhttp = CreateObject("MSXML2.serverXMLHTTP")
    url = "http://localhost:5003/studies/Study_000001/protocol-title"
    xmlhttp.Open "GET", url, False
    xmlhttp.Send
    
    jsonResponse = xmlhttp.responseText
    title = Split(jsonResponse, """")(7)
    MsgBox (title)
End Sub
```

![Screenshot to get protocol title from API](./img/protocol_auto_01.png)

## R utilization (officer)

Within the R programming language it is also possible to update Word documents. The package ["officer"](https://davidgohel.github.io/officer/) can for example be used. The API request, we can do with the httr library.

```R
library(httr)
library(officer)

# Switch to the corresponding working directory
setwd(".../OpenStudyBuilderScripts/scripts")

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
```

We have an input word document containing a `<study title>` flag which will be replaced with the title we receive from the API. Reading JSON into lists in R is straight forward with the jsonlite package.

![Replace text in docx file](./img/protocol_auto_02.png)

## Python utilization (python-docx)

https://stackoverflow.com/questions/24805671/how-to-use-python-docx-to-replace-text-in-a-word-document-and-save

## Python utilization (docxtpl)

https://pypi.org/project/docxtpl/