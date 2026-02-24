package k8s

#replicas: <2

deployment: {
    apiVersion: "apps/v1"
    kind:       "Deployment"
    metadata: name: #deployment_name
    spec: {
        replicas: #replicas
        selector: matchLabels: app: #deployment_name
        template: {
            metadata: labels: app: #deployment_name
            spec: containers: [{
                name: "my-app"
                image: "my-app:1.0.0"
            }]
        }
    }
}

service: {
    apiVersion: "v1"
    kind:       "Service"
    metadata: name: #service_name
    spec: {
        ports: [{ port: 80, targetPort: 8080 }]
        selector: app: #deployment_name
    }
}