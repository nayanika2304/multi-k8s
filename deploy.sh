docker build -t nayanika2304/multi-client:latest -t nayanika2304/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t nayanika2304/multi-server:latest -t nayanika2304/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t nayanika2304/multi-worker:latest -t nayanika2304/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push nayanika2304/multi-client:latest
docker push nayanika2304/multi-server:latest
docker push nayanika2304/multi-worker:latest

docker push nayanika2304/multi-client:$SHA
docker push nayanika2304/multi-server:$SHA
docker push nayanika2304/multi-worker:$SHA

kubectll apply -f k8s
kubectl set image deployments/server-deployment server=nayanika2304/multi-server:$SHA
kubectl set image deployments/client-deployment client=nayanika2304/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nayanika2304/multi-worker:$SHA
