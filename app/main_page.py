import streamlit as st
import os
import sys

#append path and import function
current_dir = os.path.dirname(os.path.abspath(__file__))
code_dir = os.path.join(current_dir, "code")
sys.path.append(code_dir)
from maths import squared

#get env variables
api_key = os.getenv("API_KEY")
api_key_two = os.getenv("ANOTHER_API_KEY")

st.header("This is your app")

st.write(f"an api key from .env: **{api_key}**")
st.write(f"another api key from .env: **{api_key_two}**")
st.write(f"using an imported function: 5 squared is **{squared(5)}**")