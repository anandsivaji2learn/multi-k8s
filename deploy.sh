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
kubectl set image deployments/server-deployment server=anandsivaji/multi-server:$SHA
kubectl set image deployments/client-deployment client=anandsivaji/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anandsivaji/multi-worker:$SHA