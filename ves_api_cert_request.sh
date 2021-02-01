#!/bin/bash
exp_date=`date -v +89d '+%FT%TZ' | sed "s/^/'/;s/$/'/"`
pw=$VES_P12_PASSWORD
if [ -z $pw ]; then
  echo "Volterra p12 API Certificate password is missing. Check VES_P12_PASSWORD env variable"
  exit 1
fi
p12file=`cat ~/.vesconfig | grep "p12-bundle" | cut -d ":" -f 2 | cut -d " " -f 2`
if [ ! -f $p12file ]; then
  echo "Volterra p12 bundle not found. Check ~/.vesconfig"
  exit 1
fi
cat > ~/api_create.yaml << EOF
expiration_timestamp: $exp_date
name: `whoami`-api-$RANDOM
namespace: system
spec:
  password: $pw
  type: API_CERTIFICATE
EOF
p12=`vesctl request rpc api_credential.CustomAPI.Create -i ~/api_create.yaml --uri /public/namespaces/system/api_credentials --http-method POST --timeout 15`
mv $p12file $p12file.`date +'%s'`.bkp
name=`echo $p12 | cut -d ":" -f 4 | cut -d " " -f 2 | sed "s/^/'/;s/$/'/"`
echo $p12 | cut -d ":" -f 3 | cut -d " " -f 2 | base64 --decode > $p12file
rm ~/api_create.yaml
echo "Successfully created new p12 API Certificate bundle $name at `date '+%FT%TZ'`. p12 expires $exp_date"
exit 0
