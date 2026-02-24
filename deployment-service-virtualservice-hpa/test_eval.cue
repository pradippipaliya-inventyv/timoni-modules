package main

service: {
    apiVersion: "v1"
    kind: "Service"
    metadata: name: "my-svc"
}

deployment: {
    apiVersion: "apps/v1"
    kind: "Deployment"
    metadata: name: "my-dep"
}

configmap: {
    apiVersion: "v1"
    kind: "ConfigMap"
    metadata: name: "my-cm"
}
