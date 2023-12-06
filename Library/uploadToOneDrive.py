import requests as req
import json
import oneDriveResources as res

def upload_testLog_staging():
  filename = res.fileName['testLog']
  url = res.websiteUrl+res.environment['staging']+"/"+res.timestamp+"/"+filename+"/content"
  with open (res.filePath['testLog'], 'r', encoding='UTF8') as file:
    payload = file.read()
  response = req.request("PUT", url, headers=res.headers, data=payload)
  print(json.dumps(response.json(), indent=4))

def upload_testReport_staging():
  filename = res.fileName['testReport']
  url = res.websiteUrl+res.environment['staging']+"/"+res.timestamp+"/"+filename+"/content"
  with open (res.filePath['testReport'], 'r', encoding='UTF8') as file:
    payload = file.read()
  response = req.request("PUT", url, headers=res.headers, data=payload)
  print(json.dumps(response.json(), indent=4))

def upload_testOutput_staging():
  filename = res.fileName['testOutput']
  url = res.websiteUrl+res.environment['staging']+"/"+res.timestamp+"/"+filename+"/content"
  with open (res.filePath['testOutput'], 'r', encoding='UTF8') as file:
    payload = file.read()
  response = req.request("PUT", url, headers=res.headers, data=payload)
  print(json.dumps(response.json(), indent=4))

def upload_junitReport_staging():
  filename = res.fileName['junitReport']
  url = res.websiteUrl+res.environment['staging']+"/"+res.timestamp+"/"+filename+"/content"
  with open (res.filePath['junitReport'], 'r', encoding='UTF8') as file:
    payload = file.read()
  response = req.request("PUT", url, headers=res.headers, data=payload)
  print(json.dumps(response.json(), indent=4))

def main():
    upload_testLog_staging()
    upload_testReport_staging()
    upload_testOutput_staging()
    upload_junitReport_staging()

if __name__ == "__main__":
    main()