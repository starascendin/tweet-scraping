FROM apache/airflow:2.1.0
COPY req.txt .

USER root
# Install git
RUN sudo apt-get update \
    && apt-get install -y --no-install-recommends git \
    && apt-get purge -y --auto-remove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN sudo apt-get update && apt-get install --no-install-recommends -y \
  # dependencies for building Python packages
  build-essential \
  # psycopg2 dependencies
  libpq-dev

RUN sudo apt-get install libffi-dev


USER airflow
# Install requirements
RUN pip install --upgrade pip
RUN pip install --no-cache-dir --user -r req.txt