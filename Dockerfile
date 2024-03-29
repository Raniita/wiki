FROM python:3-alpine as builder
RUN apk add build-base
COPY mkdocs /mkdocs/
WORKDIR /mkdocs/
RUN pip install mkdocs mkdocs-material
RUN mkdocs build

FROM bitnami/nginx:1.19
COPY nginx.conf /opt/bitnami/nginx/conf/server_blocks/site.conf
COPY --from=builder /mkdocs/site /app
CMD ["nginx", "-g", "daemon off;"]