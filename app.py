import streamlit as st
from selenium import webdriver
from selenium.webdriver.firefox.options import Options
import os
from pyvirtualdisplay import Display

st.title("ia-test-backend/")
st.header("Olá sou um test")

# Define the options for Firefox
options = Options()
options.add_argument("--headless")  # Run in headless mode, useful in Docker
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")

# Iniciar o display virtual
display = Display(visible=1, size=(1920, 1080))
display.start()


# Initialize the driver for Firefox
driver = webdriver.Firefox(options=options)
driver.get("https://web.whatsapp.com/")
