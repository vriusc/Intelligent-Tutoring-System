FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000
#ENTRYPOINT ["tail", "-f", "/dev/null"]
#CMD ["flask", "--app", "app", "run"]
#CMD ["python", "app.py"]
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
CMD ["flask", "run"]
