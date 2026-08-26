FROM python:3.14-slim

WORKDIR /home/myapp

# 1. Actualizar paquetes del sistema operativo
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# 2. Actualizar pip, setuptools e instalar dependencias
RUN pip install --no-cache-dir --upgrade pip setuptools \
    && pip install --no-cache-dir -r requirements.txt

# 3. Eliminar los metadatos antiguos preinstalados por la imagen base que Trivy sigue detectando
RUN rm -rf /usr/local/lib/python3.14/site-packages/setuptools-70.* \
    && rm -rf /usr/local/lib/python3.14/site-packages/msgpack-1.1.*

COPY . .

EXPOSE 5050

CMD ["python3", "sample_app.py"]