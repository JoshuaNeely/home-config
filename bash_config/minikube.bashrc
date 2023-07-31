function docker-use-minikube() {
    export DOCKER_TLS_VERIFY="1"
    export DOCKER_HOST="tcp://$(minikube ip):2376"
    export DOCKER_CERT_PATH="/home/jneely/.minikube/certs"
    export MINIKUBE_ACTIVE_DOCKERD="minikube"

    eval $(minikube -p minikube docker-env)
}

function docker-use-original() {
    unset DOCKER_TLS_VERIFY
    unset DOCKER_HOST
    unset DOCKER_CERT_PATH
    unset MINIKUBE_ACTIVE_DOCKERD
}

# I may need to configure many customizations... eg kubernetes version
# This would be a place to do it, short term. Longer term I may need to share this with the team in some script.
function minikube-start-custom() {
    # 10.0.0.0 is the internal cluster ip... if our registry is deployed WITHIN kube, containers can find it here
    # externally, we'd still find it at $(minikube ip)
    minikube start \
        --extra-config=apiserver.service-node-port-range=1-65535 \
        --insecure-registry "10.0.0.0/24" \
        --cpus=max \
        --memory=max \
        --addons=dashboard \
        --addons=registry \
        --addons=ingress
}
