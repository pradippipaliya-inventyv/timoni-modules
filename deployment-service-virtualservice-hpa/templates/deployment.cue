package templates

import (
	appsv1 "k8s.io/api/apps/v1"
	corev1 "k8s.io/api/core/v1"
)

#Deployment: appsv1.#Deployment & {
	#config:    #Config
	#cmName:    string
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name:      #config.deploymentName
		namespace: #config.metadata.namespace
		labels:    #config.metadata.labels
		if #config.metadata.annotations != _|_ {
			annotations: #config.metadata.annotations
		}
	}
	spec: appsv1.#DeploymentSpec & {
		replicas: #config.replicas
		selector: matchLabels: #config.selector.labels
		template: {
			metadata: {
				labels: #config.selector.labels
				if #config.podAnnotations != _|_ {
					annotations: #config.podAnnotations
				}
			}
			spec: corev1.#PodSpec & {
				serviceAccountName: #config.serviceAccountName
				containers: [
					{
						name:            #config.metadata.name
						image:           #config.image.reference
						imagePullPolicy: #config.image.pullPolicy
						ports: [
							{
								name:          "http"
								containerPort: 8080
								protocol:      "TCP"
							},
						]
						livenessProbe: {
							httpGet: {
								path: "/healthz"
								port: "http"
							}
						}
						readinessProbe: {
							httpGet: {
								path: "/healthz"
								port: "http"
							}
						}
						volumeMounts: [
							{
								mountPath: "/etc/nginx/conf.d"
								name:      "config"
							},
							{
								mountPath: "/usr/share/nginx/html"
								name:      "html"
							},
						]
						resources:       #config.resources
						securityContext: #config.securityContext
						if len(#config.env) > 0 {
							env: [ for k, v in #config.env {
								name:  k
								value: v
							}]
						}
					},
				]
				volumes: [
					{
						name: "config"
						configMap: {
							name: #cmName
							items: [{
								key:  "nginx.default.conf"
								path: key
							}]
						}
					},
					{
						name: "html"
						configMap: {
							name: #cmName
							items: [{
								key:  "index.html"
								path: key
							}]
						}
					},
				]
				if #config.podSecurityContext != _|_ {
					securityContext: #config.podSecurityContext
				}
				if #config.topologySpreadConstraints != _|_ {
					topologySpreadConstraints: #config.topologySpreadConstraints
				}
				if #config.affinity != _|_ {
					affinity: #config.affinity
				}
				if #config.tolerations != _|_ {
					tolerations: #config.tolerations
				}
				if #config.imagePullSecrets != _|_ {
					imagePullSecrets: #config.imagePullSecrets
				}
			}
		}
	}
}
