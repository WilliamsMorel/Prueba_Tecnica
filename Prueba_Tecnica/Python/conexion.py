from extraer_archivos import df_ticket, df_producto
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker

# Definir la conexion
user = 'postgres'
password = 'password'
host = 'localhost'  
port = '5432' 
database = 'Spaceman'

# Motor de SQLAlchemy
engine = create_engine(f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}')

# Crear una sesión
Session = sessionmaker(bind=engine)
session = Session()

# Nombre de las tablas donde se insertaran los datos
table_ticket = 'tickets_tmp'
table_producto = 'productos_tmp'

# Insertar los DataFrame a las tablas SQL
df_ticket.to_sql(table_ticket, engine, if_exists='replace', index=False)

df_producto.to_sql(table_producto, engine, if_exists='replace', index=False)

# Ejecucion de procedimiento
try:
    session.execute(text(r'CALL public."CRG_TBLS_PRD_TCKTS"()'))  
    session.commit()
    print("Procedimiento ejecutado con éxito")
except Exception as e:
    session.rollback()
    print(f"Error ejecutando el procedimiento: {e}")
finally:
    session.close()

