import os
from flask import Flask, render_template, request, redirect, url_for
import pymysql

app = Flask(__name__)

# Fallo Bandit B105
MYSQL_ROOT_PASSWORD = "sena123"

# Configuración de conexión leyendo las variables MYSQL_ de tu .env
DB_CONFIG = {
    'host': os.environ.get('MYSQL_HOST', 'servidor-bd'),
    'user': os.environ.get('MYSQL_USER', 'root'),
    'password': os.environ.get(MYSQL_ROOT_PASSWORD),
    'database': os.environ.get('MYSQL_DATABASE', 'adso_db'),
    'cursorclass': pymysql.cursors.DictCursor,
    'autocommit': True
}

def get_db_connection():
    return pymysql.connect(**DB_CONFIG)

def init_db():
    """Crea la tabla aprendices si no existe."""
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS aprendices (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    nombre_completo VARCHAR(100) NOT NULL,
                    numero_documento VARCHAR(20) NOT NULL,
                    ficha VARCHAR(20) NOT NULL
                );
            """)
        connection.close()
        print("Base de datos e hilo de conexion listos.")
    except Exception as e:
        print(f"Error inicializando la BD (¿MySQL sigue iniciando?): {e}")

@app.route('/', methods=['GET'])
def index():
    # Fallo Pytest
    return "Error simulado de servidor", 500

@app.route('/registrar', methods=['POST'])
def registrar():
    nombre = request.form['nombre_completo']
    documento = request.form['numero_documento']
    ficha = request.form['ficha']

    connection = get_db_connection()
    with connection.cursor() as cursor:
        sql = "INSERT INTO aprendices (nombre_completo, numero_documento, ficha) VALUES (%s, %s, %s)"
        cursor.execute(sql, (nombre, documento, ficha))
    connection.close()

    return redirect(url_for('index'))

if __name__ == '__main__':
    init_db()
    # Fallo Bandit B201
    app.run(host='0.0.0.0', port=5050, debug=True)