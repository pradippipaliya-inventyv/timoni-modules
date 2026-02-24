// values-prod.cue - Production environment configuration
values: {
	// Dynamic deployment name for production
	deploymentName: "prod-backend-deployment"
	
	// Dynamic service name for production
	serviceName: "prod-backend-service"
	
	// Dynamic service account name for production
	serviceAccountName: "prod-backend-sa"

	// Number of replicas for production
	replicas: 5

	// Container image configuration
	image: {
		repository: "docker.io/nginx"
		tag:        "1.25.3-alpine"
		digest:     ""
		pullPolicy: "Always"
	}

	// Service configuration
	service: {
		port: 443
		annotations: {
			"service.beta.kubernetes.io/aws-load-balancer-type":            "nlb"
			"service.beta.kubernetes.io/aws-load-balancer-scheme":          "internet-facing"
			"service.beta.kubernetes.io/aws-load-balancer-backend-protocol": "https"
		}
	}

	// Resource requirements (production-grade)
	resources: {
		requests: {
			cpu:    "500m"
			memory: "256Mi"
		}
		limits: {
			cpu:    "1000m"
			memory: "512Mi"
		}
	}

	// Application message
	message: "Hello from Production!"

	// Pod annotations for production
	podAnnotations: {
		"prometheus.io/scrape": "true"
		"prometheus.io/port":   "8080"
	}

	// Test configuration
	test: {
		enabled: true
		image: {
			repository: "docker.io/curlimages/curl"
			tag:        "8.1.2"
			digest:     ""
		}
	}

	// Production affinity rules
	affinity: {
		podAntiAffinity: {
			preferredDuringSchedulingIgnoredDuringExecution: [{
				weight: 100
				podAffinityTerm: {
					labelSelector: {
						matchExpressions: [{
							key:      "app.kubernetes.io/name"
							operator: "In"
							values: ["prod-backend"]
						}]
					}
					topologyKey: "kubernetes.io/hostname"
				}
			}]
		}
	}
}
