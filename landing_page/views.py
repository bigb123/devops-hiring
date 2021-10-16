from django.shortcuts import render

# Taken from https://docs.djangoproject.com/en/3.2/topics/http/views/
from django.http import HttpResponse
import datetime

def current_datetime(request):
    now = datetime.datetime.now()
    html = "<html><body>It is now %s.</body></html>" % now
    return HttpResponse(html)