#!/bin/bash

# Iniciar Xvfb em background
Xvfb :99 -screen 0 1280x720x16 &

# Esperar um pouco para garantir que o Xvfb esteja rodando
sleep 3

# Definir a variável DISPLAY
export DISPLAY=:99

# Executar o aplicativo Streamlit
streamlit run app.py --server.port=$PORT --server.address=0.0.0.0 --server.enableCORS=false --server.enableXsrfProtection=false
