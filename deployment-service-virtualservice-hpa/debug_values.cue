@if(debug)

package main

// Values used by debug_tool.cue.
// Debug example 'cue cmd -t debug -t name=test -t namespace=test -t mv=1.0.0 -t kv=1.28.0 build'.
values: {
	deploymentName: "debug-deployment"
	serviceName: "debug-service"
	serviceAccountName: "debug-sa"
	podAnnotations: "cluster-autoscaler.kubernetes.io/safe-to-evict": "true"
	message: "Hello Debug"
	env: {
		"DEBUG_MODE": "true"
	}
	image: {
		repository: "docker.io/nginx"
		tag:        "1-alpine"
		digest:     ""
	}
	test: {
		enabled: true
		image: {
			repository: "docker.io/curlimages/curl"
			tag:        "latest"
			digest:     ""
		}
	}
	affinity: nodeAffinity: requiredDuringSchedulingIgnoredDuringExecution: nodeSelectorTerms: [{
		matchExpressions: [{
			key:      "kubernetes.io/os"
			operator: "In"
			values: ["linux"]
		}]
	}]
}
