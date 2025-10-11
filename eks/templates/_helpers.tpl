{{- define "mychart.app" }}
  app: {{ .Values.appName }}
{{- end }}

{{- define "init.cont" }}
 - name: {{ .Values.appName }}-init
   image: {
   { .Values.initimage }}
 {{- end }}