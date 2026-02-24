values: {
  replicas:        int & <2
}

deployment: {
    apiVersion: "apps/v1"
    kind:       "Deployment"
    metadata: name: values.deployment_name
    spec: {
        replicas: values.replicas
        selector: matchLabels: app: values.deployment_name
        template: {
            metadata: labels: app: values.deployment_name
            spec: containers: [{
                name: "my-app"
                image: "my-app:\(values.image_tag)"
            }]
        }
    }
}

service: {
    apiVersion: "v1"
    kind:       "Service"
    metadata: name: values.service_name
    spec: {
        ports: [{ port: 80, targetPort: 8080 }]
        selector: app: values.deployment_name
    }
}

objects: {
    apiVersion: "v1"
    kind:       "List"
    items: [
        deployment,
        service,
    ]
}