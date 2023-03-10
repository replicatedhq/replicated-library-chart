{{/*
Renders the Persistent Volume Claim objects required by the chart.
*/}}
{{- define "replicated-library.pvc" -}}
  {{- /* Generate pvc as required */ -}}
  {{- range $index, $PVC := .Values.volumes }}
    {{- if and $PVC.enabled (eq (default "pvc" $PVC.type) "pvc") (not $PVC.existingClaim) -}}
      {{- $volumeValues := $PVC -}}
      {{- if not $volumeValues.nameOverride -}}
        {{- $_ := set $volumeValues "nameOverride" $index -}}
      {{- end -}}
      {{- $_ := set $ "ObjectValues" (dict "volume" $volumeValues) -}}
      {{- include "replicated-library.classes.pvc" $ | nindent 0 -}}
    {{- end }}
  {{- end }}
{{- end }}
