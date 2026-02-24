// values-dev.cue - Development environment configuration


_conf: _ @embed(file=config.yaml)
_data: _ @embed(glob=env/*.yml)

values: {
	// Dynamic deployment name for dev
	deploymentName: "dev-webapp-deployment"
	
	// Dynamic service name for dev
	serviceName: "dev-webapp-service"
	
	// Dynamic service account name for dev
	serviceAccountName: "dev-webapp-sa"

	// Number of replicas for dev
	replicas: 2

	// Container image configuration
	image: {
		repository: "docker.io/nginx"
		tag:        "1.25-alpine"
		digest:     ""
		pullPolicy: "IfNotPresent"
	}

	// Service configuration
	service: {
		port: 8080
	}

	// Resource requirements
	resources: {
		requests: {
			cpu:    "100m"
			memory: "64Mi"
		}
		limits: {
			cpu:    "200m"
			memory: "128Mi"
		}
	}

	// Application message
	message: "Hello from Development!"

	// Test configuration
	test: {
		enabled: false
		image: {
			repository: "docker.io/curlimages/curl"
			tag:        "latest"
			digest:     ""
		}
	}
}
