docker build -t skumardocker2019/multi-client:latest -t skumardocker2019/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t skumardocker2019/multi-server:latest -t skumardocker2019/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t skumardocker2019/multi-worker:latest -t skumardocker2019/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push skumardocker2019/multi-client:latest
docker push skumardocker2019/multi-server:latest
docker push skumardocker2019/multi-worker:latest

docker push skumardocker2019/multi-client:$SHA
docker push skumardocker2019/multi-server:$SHA
docker push skumardocker2019/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=skumardocker2019/multi-server:$SHA
kubectl set image deployments/client-deployment client=skumardocker2019/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=skumardocker2019/multi-worker:$SHA
