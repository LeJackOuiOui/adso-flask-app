FROM python:3.14-slim

WORKDIR /home/myapp

# 1. Actualizar paquetes del sistema operativo
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# 2. Reinstalar y forzar la actualización de pip, setuptools y las dependencias de Python
RUN pip install --no-cache-dir --upgrade --force-reinstall pip setuptools \
    && pip install --no-cache-dir --upgrade --force-reinstall -r requirements.txt

COPY . .

EXPOSE 5050

CMD ["python3", "sample_app.py"]