FROM python:3.14-slim

WORKDIR /home/myapp

# Actualiza paquetes del SO para parchear vulnerabilidades conocidas
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip setuptools
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5050

CMD ["python3", "sample_app.py"]