FROM apache/airflow:2.6.3-python3.9
COPY . .
RUN pip install -r requirements.txt