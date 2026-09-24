# Declaración del uso de IA en el laboratorio.
## app.yml
- dependencias: La manera de mostrar esto. 
 with: { node-version: '20' }
      - name: Auditar el árbol completo
        run: |
          npm audit --json > audit.json || true
          {
            echo '### Dependencias vulnerables'
            echo
            echo '| Paquete | Severidad | Directa |'
            echo '|---|---|---|'
            jq -r '.vulnerabilities | to_entries[] | "| \(.key) | \(.value.severity) | \(.value.isDirect) |"' audit.json
          } >> "$GITHUB_STEP_SUMMARY"

- La manera de taggear
       tags: |
            ${{ steps.registro.outputs.registry }}/${{ env.APLICACION }}:${{ steps.corto.outputs.sha }}
            ${{ steps.registro.outputs.registry }}/${{ env.APLICACION }}:prd
            
      - id: referencia
        run: |
          echo "digest=${{ steps.registro.outputs.registry }}/${{ env.APLICACION }}@${{ steps.build.outputs.digest }}" >> "$GITHUB_OUTPUT"






## infra.yml
- Desarrollo de scripts para reglas 1 y 2
- En políticas (esta parte)
 with:
          scan-type: config
          scan-ref: infra
          severity: 'HIGH,CRITICAL'
          exit-code: '1'

- Incluir esto
defaults: { run: { working-directory: infra } }
