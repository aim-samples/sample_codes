import requests

url = "http://maps.googleapis.com/maps/api/geocode/json"
location = "delhi technological university"

params = {'address':location}

response = requests.get(url = url, params = params)

data = response.json()

results = data['results']
error = data['error_message']
status = data['status']

print(status)