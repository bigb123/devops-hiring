FROM python:3.9.7
RUN pip install -r requirements.txt
COPY manage.py manage.py
COPY requirements.txt requirements.txt
COPY landing_page landing_page
COPY mysite mysite
COPY polls polls

ENTRYPOINT ./manage.py runserver