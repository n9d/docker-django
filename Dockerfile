FROM python:3.11
WORKDIR /src

COPY . /src

RUN pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry config virtualenvs.in-project true && \
    poetry install --without dev

# 必要に応じgnicornにすること
CMD python manage.py runserver 0.0.0.0:8000
# project = basename $(dirname $(find . -name "wsgi.py" | head -1))
#CMD gunicorn project.wsgi -b 0.0.0.0

