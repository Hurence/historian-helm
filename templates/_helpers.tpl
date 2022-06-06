{{/*
Expand the name of the chart.
*/}}
{{- define "historian-helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "historian-helm.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "historian-helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "historian-helm.labels" -}}
helm.sh/chart: {{ include "historian-helm.chart" . }}
{{ include "historian-helm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "historian-helm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "historian-helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels for server
*/}}
{{- define "historian.server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "historian.server-name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Selector labels for scraper
*/}}
{{- define "historian.scraper.selectorLabels" -}}
app.kubernetes.io/name: {{ include "historian.scraper-name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels for compactor
*/}}
{{- define "historian.compactor.selectorLabels" -}}
app.kubernetes.io/name: {{ include "historian.compactor-name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Define the name of the historian server
*/}}
{{- define "historian.server-name" -}}
{{- printf "%s-%s" (include "historian-helm.fullname" .) "server" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Define the name of the historian scraper
*/}}
{{- define "historian.scraper-name" -}}
{{- printf "%s-%s" (include "historian-helm.fullname" .) "scraper" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Define the name of the historian compactor
*/}}
{{- define "historian.compactor-name" -}}
{{- printf "%s-%s" (include "historian-helm.fullname" .) "compactor" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "historian-helm.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "historian-helm.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate key-value content for config maps
*/}}
{{- define "historian-helm.configMap.content" -}}
{{ $.configMapKey }}: {{ toYaml (tpl $.configMapValue $) }}
{{- end }}
