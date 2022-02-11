import requests

url = "http://maps.googleapis.com/maps/api/geocode/json"
location = "delhi technological university"

params = {'address':location}

# get request
response = requests.get(url = url, params = params)

# response as json
data = response.json()
# response as text
# text = response.text

results = data['results']
error = data['error_message']
status = data['status']

print(status)