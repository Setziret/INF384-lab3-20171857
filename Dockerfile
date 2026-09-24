# Dockerfile del repositorio base.
# Contiene cinco malas practicas deliberadas. Cada una lleva su numero en la
# linea anterior. Corregirlas es el bloque A1 de la guia del laboratorio.

# defecto 1
FROM public.ecr.aws/lambda/nodejs:20 AS build
WORKDIR /app

# defecto 2
COPY package.json package-lock.json ./

# defecto 3
RUN npm ci
COPY src ./src
RUN npm run build && npm prune --omit=dev

# defecto 4
# ENV DB_PASSWORD="inf384-clave-en-texto-plano"
FROM public.ecr.aws/lambda/nodejs:20 AS runtime
ENV NODE_ENV=production
WORKDIR /app

# defecto 5
# RUN dnf install -y procps-ng vim && dnf clean all
COPY --from=build /var/task/dist/handler.js ${LAMBDA_TASK_ROOT}/handler.js
COPY --from=build /app/node_modules ./node_modules

USER node

CMD ["src/handler.handler"]
