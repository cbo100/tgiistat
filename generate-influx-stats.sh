# Using old influx json format
# python3 /modemtool/tgiistat.py --json | jq -r 'to_entries | map({name : .key, colums : ["value", "host"], points: [.value, "modem"] })'
# New influx line protocl
# weather,location=us-midwest,season=summer temperature=82 1465839830100400200
while sleep 300
do
  python3 /modemtool/tgiistat.py --json \
    | jq -r 'now as $now | to_entries[] | select(.key == ("up_rate", "down_rate", "up_maxrate", "down_maxrate", "up_power", "down_power", "up_noisemargin", "down_noisemargin", "down_attenuation1", "down_attenuation2", "down_attenuation3", "up_attenuation1", "up_attenuation2", "up_attenuation3")) | "modemhistory,host=modem \(.key)=\(.value) \($now|floor)"' \
    | curl -X POST "http://server.budge.ormerod.name:8086/write?db=modemstats&precision=s" --data-binary @-
  echo "Stats written"
done