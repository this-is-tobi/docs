{{/*
Expand the name of the chart.
*/}}
{{- define "this-is-tobi-docs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "this-is-tobi-docs.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "this-is-tobi-docs.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "this-is-tobi-docs.name" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create image pull secret
*/}}
{{- define "this-is-tobi-docs.imagePullSecret" }}
{{- with .Values.imageCredentials }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"email\":\"%s\",\"auth\":\"%s\"}}}" .registry .username .password .email (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}

{{/*
Create container environment variables from configmap
*/}}
{{- define "this-is-tobi-docs.containerEnv" -}}
{{ range $key, $val := .env }}
{{ $key }}: {{ $val | quote }}
{{- end }}
{{- end }}

{{/*
Create container environment variables from secret
*/}}
{{- define "this-is-tobi-docs.containerSecret" -}}
{{ range $key, $val := .secrets }}
{{ $key }}: {{ $val | b64enc | quote }}
{{- end }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "this-is-tobi-docs.docs.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}-docs
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}-docs
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}-docs
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "this-is-tobi-docs.docs.labels" -}}
helm.sh/chart: {{ include "this-is-tobi-docs.chart" . }}
{{ include "this-is-tobi-docs.docs.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "this-is-tobi-docs.docs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "this-is-tobi-docs.name" . }}-docs
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
