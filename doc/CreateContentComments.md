# Create Content Comments

A small **Webpage** is developed which is utilizing the API to create Clinical Programs, Projects and Studies from Trial Domains. When you have downloaded this repository (or just the two files [createContent.html](../scripts/createContent.html) and [createContentScripts.js](../scripts/createContentScripts.js)), you can start the webpage by opening the HTML file. This is a very simplified webpage without any extras to purely demonstrate the functionality and allow to upload data into the OpenStudyBuilder - in this case a local instance having the API running on `http://localhost:5003/`.

The webpage consist of one HTML file containing all display elements and one Java Script file containing all scripts. The scripts is using comments and speaking names and for this should be easy to follow. If you for example have a different endpoint, you can simply change the API base url: `let api_base_url = 'http://localhost:5003/'` in the js file.

Printouts are printed into the "console" of the browser. To see and browse the JSON structured outputs nicely, please open the developer tools (in most browsers by pressing F12) and checkout the console. The output is additionally printed into fields of the webpage, containing the JSON formatted information.

The upper part will give you some information. `Get Programs`, `Get Projects` and `Get Studies` will receive the corresponding information from the API.

You can `Create Clinical Program` in case it is not already available - here only the name is required.

You can `Create Project` in case it is not existing and you provided all information - you also need a connecting clinical program id.

## Programming Explanations

When you checkout the HTML page (`createContent.html`), you can see which functions are called for specific actions.

```html
<button onclick="getClinicalProgram()">Get Programs</button>
<button onclick="getProjects()">Get Projects</button>
<button onclick="getStudies()">Get Studies</button>
<button onclick="createClinicalProgram()">Create Clinical Program</button>
<button onclick="createProject()">Create Project</button>
```

In the corresponding Script file (`createContentScripts.js`), you can check how the functions are implemented and how the API is called. The following example shows that the API is called via a basic xmlHttp request. If you would need authentification, you could include this there.

```js
// makes a API GET request
function httpURLGet(path) {
  var url = api_base_url + path;
  var xmlHttp = new XMLHttpRequest()
  xmlHttp.open('GET', url, false)
  xmlHttp.send(null)
  return xmlHttp.responseText
}
```

Calling the API directly, it is easily possible to create the same named clinical program or project multiple times. For this next to the pure API calls, additionally some checks are implemented.

To create a clinical program, it is for example checked, that there had been a value entered. You don't want to create an empty string as project. The next part checks that the clinical program name is not already available as you do not want to create the same program multiple twice. Finally if all is fine, the POST request to create the clinical program is submitted.

```js
// Create a new clinical program and print result (if provided and not already existing)
function createClinicalProgram() {
  writeTextToContainer("");
  console.log('Create clinical program:')
  value = document.getElementById('01_clinicalProgramInput').value;
  // if no name is provided, then do not create anything
  if (value == null || value == ""){
    writeTextToContainer("The input for Clinical Program is not provided and for this cannot be created.");
  } else {
    // check that this is not already available
    let programs = JSON.parse(httpURLGet("clinical-programmes"))
    let isAlreadIn = programs.reduce((accum, item) => accum || item.name == value, false)
    if (isAlreadIn){
      writeTextToContainer("The clinical programme is already available.");
    } else {
      content = {"name" : value}
      let response = httpURLPost("clinical-programmes", content)
      writeTextToContainer(response);
      console.log(JSON.parse(response));
    }
  }
}
```

## Upload a study

A study contains potentially many information which you might not want to type one-by-one. For this the application will read in the trial domain datasets in JSON format and create as much automatically as possible.

Interested how? This is coming next!