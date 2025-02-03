import gdown
import pandas as pd
from functools import reduce

# Se extraen los ID de los archivos txt
file_id = ['1NWSYLN3jbS5aeOSNPPa4N7xSZWCv-Bgc', '1fxd0UIjXMNMn31pKXJ62bXywmtRZvg8o']

# Nombres de archivos
file = ['tickets_prueba_v2.txt', 'productos_prueba_v2.txt']

# Se descargan archivos
for i, x in enumerate(file_id):
    url = f'https://drive.google.com/uc?id={x}'
    gdown.download(url, output=file[i], quiet=False)

# Leer los archivos
df_ticket = pd.read_csv(file[0], delimiter=';')
df_producto = pd.read_csv(file[1], delimiter=';', low_memory=False, on_bad_lines='skip', encoding='ISO-8859-1') # Problemas con columnas algunas lineas traen ;;  y codificacion "MacRoman"

########Correccion de tabla producto########
# Se elimina lineas que tengan un error en los registros, todos son campos de ID que continene texto
columnas = [0, 1, 3, 5, 7, 9]

# Caracteres a identificar
patron = r'[aeiouAEIOUxD]'

# Aplicar filtro
df_producto = reduce(lambda df, col: df[~df.iloc[:, col].str.contains(patron, na=False)], columnas, df_producto)

# Campos Nulos
df_producto.iloc[:, 0] = df_producto.iloc[:, 0].fillna(0) 

# Reemplazar caracteres especiales
reemplazos = {
    'Ã': 'Á', 'Ã¡': 'á', 'Ã‰': 'É', 'Ã©': 'é', 
    'Ã': 'Í', 'Ã­': 'í', 'Ã“': 'Ó', 'Ã³': 'ó', 
    'Ãš': 'Ú', 'Ãº': 'ú', 'Ã‘': 'Ñ', 'Ã±': 'ñ',
    'â': '“', 'â': '”', 'â': '‘', 'â': '’',
    'â': '–', 'â': '—', 'â¦': '…', 'Â¡': '¡',
    'Â¿': '¿', 'Âº': 'º', 'Âª': 'ª', 'Ã€': 'À',
    'Ãˆ': 'È', 'ÃŒ': 'Ì', 'Ã’': 'Ò', 'Ã™': 'Ù',
    'Ã§': 'ç', 'Ã‡': 'Ç', 'Ã¤': 'ä', 'Ã«': 'ë',
    'Ã¯': 'ï', 'Ã¶': 'ö', 'Ã¼': 'ü', 'Ã„': 'Ä',
    'Ã‹': 'Ë', 'Ã': 'Ï', 'Ã–': 'Ö', 'Ãœ': 'Ü',
    'Ã‚': 'Â', 'Ãª': 'ê', 'ÃŽ': 'Î', 'Ã´': 'ô',
    'Ã»': 'û', 'Ã»': 'Û', 'Ã´': 'Ô', 'Ã®': 'î',
    'Ã”': 'Ô', 'ÃŠ': 'Ê', 'Ã': 'Ñ'
}

# Columnas a reemplazar
indices_columnas = [2,4,6,8,10,11,12,18,19,20]  

# Aplicar el reemplazo
df_producto.iloc[:, indices_columnas] = df_producto.iloc[:, indices_columnas].replace(reemplazos, regex=True)


