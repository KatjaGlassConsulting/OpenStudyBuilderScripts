import requests
from os import environ

def testResponse():
  api_base_url = environ.get("API_BASE_URL")
  API_HEADERS = {"Accept": "application/json"}
  response = requests.get(
      api_base_url + "/ct/packages", headers=API_HEADERS
  )
  res = response.json()
  print(res)

testResponse()