// values-staging.cue - Staging environment configuration
values: {
	// Dynamic deployment name for staging
	deploymentName: "staging-api-deployment"
	
	// Dynamic service name for staging
	serviceName: "staging-api-service"
	
	// Dynamic service account name for staging
	serviceAccountName: "staging-api-sa"

	// Number of replicas for staging
	replicas: 3

	// Container image configuration
	image: {
		repository: "docker.io/httpd"
		tag:        "2.4"
		digest:     ""
		pullPolicy: "Always"
	}

	// Service configuration
	service: {
		port: 80
		annotations: {
			"service.beta.kubernetes.io/aws-load-balancer-type": "nlb"
		}
	}

	// Resource requirements
	resources: {
		requests: {
			cpu:    "200m"
			memory: "128Mi"
		}
		limits: {
			cpu:    "500m"
			memory: "256Mi"
		}
	}

	// Application message
	message: "Hello from Staging!"

	// Test configuration  
	test: {
		enabled: true
		image: {
			repository: "docker.io/curlimages/curl"
			tag:        "latest"
			digest:     ""
		}
	}
}
