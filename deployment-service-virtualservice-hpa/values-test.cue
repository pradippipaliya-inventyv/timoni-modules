// values.cue - Default configuration
values: {
	// Dynamic deployment name (default)
	deploymentName: "my-app-deployment-1"
	
	// Dynamic service name (default)
	serviceName: "my-app-service-2"
	
	// Dynamic service account name (default)
	serviceAccountName: "my-app-sa-2"

	// Number of replicas
	replicas: 3

	// Container image configuration
	image: {
		repository: "docker.io/nginx"
		tag:        "latest"
		digest:     ""
		pullPolicy: "IfNotPresent"
	}

	// Service configuration
	service: {
		port: 80
	}

	// Application message
	message: "Hello from Timoni!"

	// Environment variables
	env: {
		"MY_ENV_VAR": "my-value"
		"ANOTHER_VAR": "another-value"
	}

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
