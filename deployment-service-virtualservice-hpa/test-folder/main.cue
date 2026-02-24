package k8s

// Define the schema and default values for our toggles
values: {
	app_name:              string | *"default-app"
	enable_deployment:     bool | *true
	enable_service:        bool | *true
	enable_configmap:      bool | *false
	enable_virtualservice: bool | *false
}

// 1. Define all your resources normally
deployment: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: values.deployment_name
	spec: {
		replicas: 1
		selector: matchLabels: app: values.deployment_name
		template: {
			metadata: labels: app: values.deployment_name
			spec: containers: [{
				name:  "main"
				image: "my-image:latest"
			}]
		}
	}
}

service: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: name: values.service_name
	spec: {
		ports: [{port: 80, targetPort: 8080}]
		selector: app: values.deployment_name
	}
}

configmap: {
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: name: "\(values.app_name)-config"
	data: {
		"settings.json": "{}"
	}
}

virtualservice: {
	apiVersion: "networking.istio.io/v1alpha3"
	kind:       "VirtualService"
	metadata: name: values.app_name
	spec: {
		hosts: ["\(values.app_name).example.com"]
		http: [{
			route: [{
				destination: {
					host: values.app_name
					port: number: 80
				}
			}]
		}]
	}
}

// 2. Conditionally append to the items list based on values!
objects: {
	apiVersion: "v1"
	kind:       "List"
	items: [
		if values.enable_deployment {deployment},
		if values.enable_service {service},
		if values.enable_configmap {configmap},
		if values.enable_virtualservice {virtualservice},
	]
}
