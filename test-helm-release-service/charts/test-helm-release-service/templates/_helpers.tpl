{{/*
Common labels
*/}}
{{- define "deploy.labels" -}}
{{ include "deploy.selectorLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "deploy.selectorLabels" -}}
app: {{ include "deploy.appName" . }}
{{- end -}}

{{/*
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "deploy.appName" -}}
{{ .Values.appName }}
{{- end -}}