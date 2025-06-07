FROM python:3.13.3

WORKDIR /batch

RUN apt-get update

COPY ./.docker/batch/active.py ./active.py

CMD ["python", "active.py"]
