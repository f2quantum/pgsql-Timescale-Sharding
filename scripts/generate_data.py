import csv
import random
import datetime
import random
import uuid

num_points=100000

def generate_id():
    start_num = [110,111,112,113,114,115,116,117,118,119,120]
    random_pn = random.randrange(0, len(start_num))
    random_num = str(random.randint(0, 99999999))
    id = "{}{:0<8}".format(start_num[random_pn], random_num)
    return id


def generate_utc():
    current_time = datetime.datetime.now()
    utc = current_time.strftime("%Y-%m-%d %H:%M:%S")
    return utc


def generate_coordinates():
    longitude=round(random.uniform(130, 140), 7)
    latitude = round(random.uniform(45, 50), 7)
    return longitude,latitude


if __name__ == '__main__':
    #INSERT INTO time_series (id, time, lon, lat) VALUES (1, '2022-01-01 12:00:00', '123.456', '78.910');

    with open('./data/data.sql','w',newline="") as file:
        file.write("\c gisdb;\n")
        for _ in range(num_points):
            id=generate_id()
            utc=generate_utc()
            lon,lat=generate_coordinates()
            sql = f'''INSERT INTO time_series (id, time, lon, lat) VALUES ({id},'{utc}', '{lon}', '{lat}');\n'''\
            .format(id=id).format(utc=utc).format(lon = lon).format(lat = lat)
            
            file.writelines(sql)
