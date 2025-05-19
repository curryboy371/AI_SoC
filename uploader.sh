echo "start git uploader"

git pull
PID=$!
wait $PID

git add .
PID=$!
wait $PID
if [ $? -eq 0 ]; then
  echo "finish add"
else
   exit 1
fi


git commit -m $1

PID=$!
wait $PID
if [ $? -eq 0 ]; then
  echo "finish commit"
else
   exit 1
fi


git push

PID=$!
wait $PID

if [ $? -eq 0 ]; then
  echo "finish push"
else
   exit 1
fi


echo "finish git uploader"
