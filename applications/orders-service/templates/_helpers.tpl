{{- define "orders-service.namespace" -}}
{{- .Values.global.namespace -}}
{{- end -}}

{{- define "orders-service.commonLabels" -}}
app.kubernetes.io/managed-by: {{ .Values.global.managedBy | quote }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | quote }}
{{- range $key, $value := .Values.global.labels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end -}}

{{- define "orders-service.componentLabels" -}}
{{ include "orders-service.commonLabels" . }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/component: {{ .component | quote }}
{{- end -}}

{{- define "orders-service.podSecurityContext" -}}
seccompProfile:
  type: RuntimeDefault
{{- end -}}

{{- define "orders-service.securityContext" -}}
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
capabilities:
  drop:
    - ALL
{{- end -}}
