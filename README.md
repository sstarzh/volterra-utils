# volterra-utils

ves_api_cert_request.sh
-----------------------
pre-requisites:
 - vesctl installed and added to $PATH
 - Existing p12-bundle is valid and unexpired
 - VES_P12_PASSWORD environment variable exists and populated with valid p12-bundle password
 - ~/.vesconfig exists and contains p12-bundle file path
 
Script can be ran manually or set up to run periodically via cron 

Visit https://gitlab.com/volterra.io/vesctl/-/tree/master for vesctl installation instructions
