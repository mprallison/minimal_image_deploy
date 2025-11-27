FROM python:3.13

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY app .

EXPOSE 8080

CMD ["streamlit", "run", "main_page.py", "--server.port=8080", "--server.address=0.0.0.0"]
