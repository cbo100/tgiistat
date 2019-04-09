FROM python:3-slim-stretch

WORKDIR /modemtool/

ADD requirements.txt .
RUN pip install -r requirements.txt

RUN apt-get update && apt-get install -y jq curl

ADD generate-influx-stats.sh .
ADD tgiistat.py .
ADD tgiistat.toml .

#CMD ["python3", "/modemtool/tgiistat.py", "--json"]
CMD ["bash", "/modemtool/generate-influx-stats.sh"]

