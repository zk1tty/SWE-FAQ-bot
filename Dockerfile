FROM python:3.11-slim
RUN apt-get update && apt-get install -y build-essential cmake software-properties-common && \
    useradd -m -u 1000 appuser && mkdir /data && chmod 777 /data
USER appuser

ENV HOME=/home/appuser \
	PATH=/home/appuser/.local/bin:$PATH

WORKDIR $HOME/app

# Try and run pip command after setting the user with `USER appuser` to avoid permission issues with Python
COPY --chown=appuser requirements.txt $HOME/app
RUN pip3 install --no-cache-dir --upgrade pip -r requirements.txt
COPY --chown=appuser app.py $HOME/app
CMD streamlit run app.py --server.enableXsrfProtection false --server.port 8051

