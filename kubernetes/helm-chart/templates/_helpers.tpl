{{/*
Expand the name of the chart.
*/}}
{{- define "newApp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "newApp.env" -}}
  {{- $envtype := required "A valid envtype value is required" .Values.labels.envtype -}}
  {{- printf "%s" $envtype -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "newApp.fullname" -}}
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
{{- define "newApp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "newApp.appversion" -}}
{{- printf "%s" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "newApp.labels" -}}
env: {{ template "newApp.env" . }}
application: {{ .Values.labels.app_name }}
customer: {{ .Values.labels.customer }}
techteam: {{ .Values.labels.techteam }}
businessunit: {{ .Values.labels.businessunit }}
app: {{ .Values.labels.app }}
{{- if .Values.newrelic.enabled }}
newrelic: "{{ .Values.newrelic.enabled }}"
{{- end }}
{{- if .Values.istio.labels }}
app: {{ .Values.labels.app_name }}
version: {{ .Values.image.tag }}
{{- end }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "newApp.selectorLabels" -}}
env: {{ template "newApp.env" . }}
application: {{ .Values.labels.app_name }}
customer: {{ .Values.labels.customer }}
techteam: {{ .Values.labels.techteam }}
businessunit: {{ .Values.labels.businessunit }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "newApp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "newApp.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
