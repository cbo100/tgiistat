FROM python:3-stretch

WORKDIR /modemtool/

ADD requirements.txt .
RUN pip install -r requirements.txt

ADD tgiistat.py .
ADD tgiistat.toml .

CMD ["python3", "/modemtool/tgiistat.py", "--json"]

