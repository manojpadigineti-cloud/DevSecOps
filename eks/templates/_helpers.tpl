{{- define "common_values" }}
appName: "{{ .Values.appName }}"
project: "roboshop"
releaseName: "{{ .Release.Name }}"
{{- end }}

{{- define "project" }}
project: "roboshop"
{{- end }}