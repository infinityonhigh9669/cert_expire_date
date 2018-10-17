#/bin/bash

# Fill the ca files direcory in ""
cert="/example_dir"

echo " "
if openssl x509 -checkend 86400 -noout -in $cert
then
  today=`date +%D`
  expiredate=`openssl x509 -enddate -noout -in $cert  | awk -F'=' '{print $2}'`
  expdate="date +%D --date='$expiredate'"
  ed=`eval $expdate`
  daysleft=`echo $(($(($(date -u -d "$ed" "+%s") - $(date -u -d "$today" "+%s"))) / 86400))`
  echo "$daysleft days left."
else
  echo "The certificate $cert has expired or will do so within 24 hours."
  echo "(or is invalid/not found)"
fi
echo " "
