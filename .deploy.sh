# Here we have two tags. One with $SHA to always deploy the latest image in the k8s 
# and one with the latest, so that if someone runs the apply will have the latest code
docker build -t anandsivaji/multi-client:latest -t anandsivaji/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anandsivaji/multi-server:latest -t anandsivaji/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anandsivaji/multi-worker:latest -t anandsivaji/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anandsivaji/multi-client:latest
docker push anandsivaji/multi-server:latest
docker push anandsivaji/multi-worker:latest

docker push anandsivaji/multi-client:$SHA
docker push anandsivaji/multi-server:$SHA
docker push anandsivaji/multi-worker:$SHA

kubectl apply -f k8s

# Please make sure the names here are matching the ones in K8S deployment config
kubectl set image deployment/client-deployment client=anandsivaji/multi-client:$SHA
kubectl set image deployment/server-deployment server=anandsivaji/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=anandsivaji/multi-worker:$SHA
