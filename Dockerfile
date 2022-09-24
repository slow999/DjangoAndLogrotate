FROM python:3.7-alpine

RUN mkdir /code
WORKDIR /code

# instal dependencies
COPY requirements.txt requirements.txt
RUN apk add python3-dev build-base linux-headers pcre-dev
RUN pip install uwsgi
RUN pip install -r requirements.txt

# web content
COPY mysite/ mysite/
COPY polls/ polls/
COPY static/ static/
COPY manage.py .
COPY Dockerfile .
COPY mysite.uwsgi.ini .

# collect static
RUN python manage.py collectstatic

# expose port
EXPOSE 8000

CMD ["uwsgi", "--ini", "mysite.uwsgi.ini"]