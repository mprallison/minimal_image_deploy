import streamlit as st
import os
import sys
sys.path.append("code")
from maths import squared

#get env variables
api_key = os.getenv("API_KEY")
api_key_two = os.getenv("ANOTHER_API_KEY")

st.header("This is your app")

st.write(f"an api key from .env: **{api_key}**")
st.write(f"another api key from .env: **{api_key_two}**")
st.write(f"using an imported function: 5 squared is **{squared(5)}**")