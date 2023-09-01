# Export

To export studies or a study, export scripts are available. We can follow the instructions.

```
pip install -r requirements.txt
```

As I am using a windows system, I am working with a `.env` file instead of using the export command:

```
API_BASE_URL="http://localhost:5005/api"
```

Now I can install a python environment and run the export.py there:

```
pipenv install --dev
pipenv run export.py
```

To only export one specific study, I can use specifiy this in the .env file:

```
INCLUDE_STUDY_NUMBERS=0
```

Many single JSON files are created containing all information for this study. The study relevant data is available in "studies.Study_000001.*" files (assuming you used study 0 which has the id Study_000001).

