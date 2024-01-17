import csv
import random
import datetime
import random


num_points=1000000

def generate_id():
    start_num = [110,111,112,113,114,115,116,117,118,119,120]
    random_pn = random.randrange(0, len(start_num))
    random_num = str(random.randint(0, 99999999))
    id = "{}{:0<8}".format(start_num[random_pn], random_num)
    return id


def generate_utc():
    current_time = datetime.datetime.now()
    utc = current_time.strftime("%d/%m/%Y %H:%M:%S+08")
    return utc


def generate_coordinates():
    longitude=round(random.uniform(130, 140), 7)
    latitude = round(random.uniform(45, 50), 7)
    return longitude,latitude


if __name__ == '__main__':
    with open('data.csv','w',newline="") as file:
        writer = csv.writer(file)
        writer.writerow(['id','utc','lon','lat'])
        for _ in range(num_points):
            id=generate_id()
            utc=generate_utc()
            lon,lat=generate_coordinates()
            writer.writerow([id,utc,lon,lat])
