docker build -t branislavburdiliak/docker-multi-client:latest -t branislavburdiliak/docker-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t branislavburdiliak/docker-multi-server:latest -t branislavburdiliak/docker-multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t branislavburdiliak/docker-multi-worker:latest -t branislavburdiliak/docker-multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push branislavburdiliak/docker-multi-client:latest
docker push branislavburdiliak/docker-multi-server:latest
docker push branislavburdiliak/docker-multi-worker:latest
docker push branislavburdiliak/docker-multi-client:$SHA
docker push branislavburdiliak/docker-multi-server:$SHA
docker push branislavburdiliak/docker-multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment server=branislavburdiliak/docker-multi-client:$SHA
kubectl set image deployments/server-deployment server=branislavburdiliak/docker-multi-server:$SHA
kubectl set image deployments/worker-deployment server=branislavburdiliak/docker-multi-worket:$SHA