# tobi-docs

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

A Helm chart to deploy tobi-docs.

## Values

### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraObjects | list | `[]` | Add extra specs dynamically to this chart. |
| fullnameOverride | string | `""` | String to fully override the default application name. |
| nameOverride | string | `""` | Provide a name in place of the default application name. |

### Global

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.env | object | `{}` | Map of environment variables to inject into all containers. |
| global.secrets | object | `{}` | Map of environment variables to inject into all containers. |

### Docs

#### General

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| docs.affinity | object | `{}` | Affinity used for app pod. |
| docs.args | list | `[]` | Docs container command args. |
| docs.command | list | `[]` | Docs container command. |
| docs.containerPort | int | `8080` | Docs container port. |
| docs.env | object | `{}` | Docs container env variables, it will be injected into a configmap and loaded into the container. |
| docs.envFrom | list | `[]` | Docs container env variables loaded from configmap or secret reference. |
| docs.extraContainers | list | `[]` | Extra containers to add to the app pod as sidecars. |
| docs.extraPorts | list | `[]` | Docs extra container ports. |
| docs.hostAliases | list | `[]` | Host aliases that will be injected at pod-level into /etc/hosts. |
| docs.imagePullSecrets | list | `[]` | Image credentials configuration. |
| docs.initContainers | list | `[]` | Init containers to add to the app pod. |
| docs.nodeSelector | object | `{}` | Default node selector for app. |
| docs.podAnnotations | object | `{}` | Annotations for the app deployed pods. |
| docs.podLabels | object | `{}` | Labels for the app deployed pods. |
| docs.podSecurityContext | object | `{}` | Toggle and define pod-level security context. |
| docs.replicaCount | int | `1` | The number of application controller pods to run. |
| docs.revisionHistoryLimit | int | `10` | Revision history limit for the app. |
| docs.secrets | object | `{}` | Docs container env secrets, it will be injected into a secret and loaded into the container. |
| docs.securityContext | object | `{}` | Toggle and define container-level security context. |
| docs.statefulset | bool | `false` | Should the app run as a StatefulSet instead of a Deployment. |
| docs.tolerations | list | `[]` | Default tolerations for app. |
| docs.volumeClaims | list | `[]` | List of volumeClaims to add. |
| docs.volumeMounts | list | `[]` | List of mounts to add (normally used with `volumes` or `volumeClaims`). |
| docs.volumes | list | `[]` | List of volumes to add. |

#### Autoscaling

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| docs.autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler for the app. |
| docs.autoscaling.maxReplicas | int | `3` | Maximum number of replicas for the app. |
| docs.autoscaling.minReplicas | int | `1` | Minimum number of replicas for the app. |
| docs.autoscaling.targetCPUUtilizationPercentage | int | `80` | Average CPU utilization percentage for the app. |
| docs.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Average memory utilization percentage for the app. |

#### Image

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| docs.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for the app. |
| docs.image.repository | string | `"docker.io/debian"` | Repository to use for the app. |
| docs.image.tag | string | `""` | Tag to use for the app. Overrides the image tag whose default is the chart appVersion. |

#### Ingress

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| docs.ingress.annotations | object | `{}` | Additional ingress annotations. |
| docs.ingress.className | string | `""` | Defines which ingress controller will implement the resource. |
| docs.ingress.enabled | bool | `true` | Whether or not ingress should be enabled. |
| docs.ingress.hosts[0].backend.portNumber | string | `nil` | Port used by the backend service linked to the host record (leave null to use the app service port). |
| docs.ingress.hosts[0].backend.serviceName | string | `""` | Name of the backend service linked to the host record (leave empty to use the app service). |
| docs.ingress.hosts[0].name | string | `"domain.local"` | Name of the host record. |
| docs.ingress.hosts[0].path | string | `"/"` | Path of the host record to manage routing. |
| docs.ingress.hosts[0].pathType | string | `"Prefix"` | Path type of the host record. |
| docs.ingress.labels | object | `{}` | Additional ingress labels. |
| docs.ingress.tls | list | `[]` | Enable TLS configuration. |

#### Metrics

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| docs.metrics.enabled | bool | `false` | Deploy metrics service. |
| docs.metrics.service.annotations | object | `{}` | Metrics service annotations. |
| docs.metrics.service.labels | object | `{}` | Metrics service labels. |
| docs.metrics.service.port | int | `8080` | Metrics service port. |
| docs.metrics.service.targetPort | int | `8080` | Metrics service target port. |
| docs.metrics.serviceMonitor.annotations | object | `{}` | Prometheus ServiceMonitor annotations. |
| docs.metrics.serviceMonitor.enabled | bool | `false` | Enable a prometheus ServiceMonitor. |
| docs.metrics.serviceMonitor.endpoints[0].basicAuth.password | string | `""` | The secret in the service monitor namespace that contains the password for authentication. |
| docs.metrics.serviceMonitor.endpoints[0].basicAuth.username | string | `""` | The secret in the service monitor namespace that contains the username for authentication. |
| docs.metrics.serviceMonitor.endpoints[0].bearerTokenSecret.key | string | `""` | Secret key to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the service monitor and accessible by the Prometheus Operator. |
| docs.metrics.serviceMonitor.endpoints[0].bearerTokenSecret.name | string | `""` | Secret name to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the service monitor and accessible by the Prometheus Operator. |
| docs.metrics.serviceMonitor.endpoints[0].honorLabels | bool | `false` | When true, honorLabels preserves the metric’s labels when they collide with the target’s labels. |
| docs.metrics.serviceMonitor.endpoints[0].interval | string | `"30s"` | Prometheus ServiceMonitor interval. |
| docs.metrics.serviceMonitor.endpoints[0].metricRelabelings | list | `[]` | Prometheus MetricRelabelConfigs to apply to samples before ingestion. |
| docs.metrics.serviceMonitor.endpoints[0].path | string | `"/metrics"` | Path used by the Prometheus ServiceMonitor to scrape metrics. |
| docs.metrics.serviceMonitor.endpoints[0].relabelings | list | `[]` | Prometheus RelabelConfigs to apply to samples before scraping. |
| docs.metrics.serviceMonitor.endpoints[0].scheme | string | `""` | Prometheus ServiceMonitor scheme. |
| docs.metrics.serviceMonitor.endpoints[0].scrapeTimeout | string | `"10s"` | Prometheus ServiceMonitor scrapeTimeout. If empty, Prometheus uses the global scrape timeout unless it is less than the target's scrape interval value in which the latter is used. |
| docs.metrics.serviceMonitor.endpoints[0].selector | object | `{}` | Prometheus ServiceMonitor selector. |
| docs.metrics.serviceMonitor.endpoints[0].tlsConfig | object | `{}` | Prometheus ServiceMonitor tlsConfig. |
| docs.metrics.serviceMonitor.labels | object | `{}` | Prometheus ServiceMonitor labels. |

#### NetworkPolicy

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| docs.networkPolicy.create | bool | `false` | Create NetworkPolicy object for the app. |
| docs.networkPolicy.egress | list | `[]` | Egress rules for the NetworkPolicy object. |
| docs.networkPolicy.ingress | list | `[]` | Ingress rules for the NetworkPolicy object. |
| docs.networkPolicy.policyTypes | list | `["Ingress"]` | Policy types used in the NetworkPolicy object. |

#### Pdb

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| docs.pdb.annotations | object | `{}` | Annotations to be added to app pdb. |
| docs.pdb.enabled | bool | `false` | Deploy a PodDisruptionBudget for the app |
| docs.pdb.labels | object | `{}` | Labels to be added to app pdb. |
| docs.pdb.maxUnavailable | string | `""` | Number of pods that are unavailable after eviction as number or percentage (eg.: 50%). Has higher precedence over `docs.pdb.minAvailable`. |
| docs.pdb.minAvailable | string | `""` (defaults to 0 if not specified) | Number of pods that are available after eviction as number or percentage (eg.: 50%). |

#### Probes

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| docs.probes.healthcheck.path | string | `"/"` | Docs container healthcheck endpoint. |
| docs.probes.healthcheck.port | int | `8080` | Port to use for healthcheck (defaults to container port if not set) |
| docs.probes.livenessProbe.enabled | bool | `true` | Whether or not enable the probe. |
| docs.probes.livenessProbe.failureThreshold | int | `3` | Minimum consecutive failures for the probe to be considered failed after having succeeded. |
| docs.probes.livenessProbe.initialDelaySeconds | int | `30` | Number of seconds after the container has started before probe is initiated. |
| docs.probes.livenessProbe.periodSeconds | int | `30` | How often (in seconds) to perform the probe. |
| docs.probes.livenessProbe.successThreshold | int | `1` | Minimum consecutive successes for the probe to be considered successful after having failed. |
| docs.probes.livenessProbe.timeoutSeconds | int | `5` | Number of seconds after which the probe times out. |
| docs.probes.readinessProbe.enabled | bool | `true` | Whether or not enable the probe. |
| docs.probes.readinessProbe.failureThreshold | int | `2` | Minimum consecutive failures for the probe to be considered failed after having succeeded. |
| docs.probes.readinessProbe.initialDelaySeconds | int | `10` | Number of seconds after the container has started before probe is initiated. |
| docs.probes.readinessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the probe. |
| docs.probes.readinessProbe.successThreshold | int | `2` | Minimum consecutive successes for the probe to be considered successful after having failed. |
| docs.probes.readinessProbe.timeoutSeconds | int | `5` | Number of seconds after which the probe times out. |
| docs.probes.startupProbe.enabled | bool | `true` | Whether or not enable the probe. |
| docs.probes.startupProbe.failureThreshold | int | `10` | Minimum consecutive failures for the probe to be considered failed after having succeeded. |
| docs.probes.startupProbe.initialDelaySeconds | int | `0` | Number of seconds after the container has started before probe is initiated. |
| docs.probes.startupProbe.periodSeconds | int | `10` | How often (in seconds) to perform the probe. |
| docs.probes.startupProbe.successThreshold | int | `1` | Minimum consecutive successes for the probe to be considered successful after having failed. |
| docs.probes.startupProbe.timeoutSeconds | int | `5` | Number of seconds after which the probe times out. |

#### Resources

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| docs.resources.limits.cpu | string | `"500m"` | CPU limit for the app. |
| docs.resources.limits.memory | string | `"2Gi"` | Memory limit for the app. |
| docs.resources.requests.cpu | string | `"100m"` | CPU request for the app. |
| docs.resources.requests.memory | string | `"256Mi"` | Memory request for the app. |

#### Service

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| docs.service.extraPorts | list | `[]` | Extra service ports. |
| docs.service.nodePort | int | `31000` | Port used when type is `NodePort` to expose the service on the given node port. |
| docs.service.port | int | `80` | Port used by the service. |
| docs.service.portName | string | `"http"` | Port name used by the service. |
| docs.service.protocol | string | `"TCP"` | Protocol used by the service. |
| docs.service.type | string | `"ClusterIP"` | Type of service to create for the app. |

#### ServiceAccount

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| docs.serviceAccount.annotations | object | `{}` | Annotations applied to created service account. |
| docs.serviceAccount.automountServiceAccountToken | bool | `false` | Should the service account access token be automount in the pod. |
| docs.serviceAccount.clusterRole.create | bool | `false` | Should the clusterRole be created. |
| docs.serviceAccount.clusterRole.rules | list | `[]` | ClusterRole rules associated with the service account. |
| docs.serviceAccount.create | bool | `false` | Create a service account. |
| docs.serviceAccount.enabled | bool | `false` | Enable the service account. |
| docs.serviceAccount.name | string | `""` | Service account name. |
| docs.serviceAccount.role.create | bool | `false` | Should the role be created. |
| docs.serviceAccount.role.rules | list | `[]` | Role rules associated with the service account. |

#### Strategy

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| docs.strategy.rollingUpdate.maxSurge | int | `1` | The maximum number of pods that can be scheduled above the desired number of pods. |
| docs.strategy.rollingUpdate.maxUnavailable | int | `1` | The maximum number of pods that can be unavailable during the update process. |
| docs.strategy.type | string | `"RollingUpdate"` | Strategy type used to replace old Pods by new ones, can be `Recreate` or `RollingUpdate`. |

## Sources

**Source code:**

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
