import streamlit as st
import os

#get env variables
api_key = os.getenv("some_api_key")
api_key_two = os.getenv("another_api_key")

st.header("This is your app")

st.write(f"an api key from .env: **{api_key}**")
st.write(f"another api key from .env: **{api_key_two}**")