import dht
import time
my_dht = dht.DHT11(machine.Pin(2))

def measure_humidity(outfile, poll_time_s):
    while True:
        my_dht.measure()
        humidity = my_dht.humidity()
        with open(outfile, 'a') as f:
            f.write(str(humidity) + ",")
        print("humidity: ", humidity)
        time.sleep(poll_time_s)

def measure_temp(outfile, poll_time_s):
    while True:
        my_dht.measure()
        temp = my_dht.temperature()
        with open(outfile, 'a') as f:
            f.write(str(temp) + ",")
        print("temp: ", temp)
        time.sleep(poll_time_s)

def measure_temp_humidity(temp_outfile, humidity_outfile, poll_time_s):
    while True:
        my_dht.measure()
        temp = my_dht.temperature()
        humidity = my_dht.humidity()
        with open(temp_outfile, 'a') as f:
            f.write(str(temp) + ",")
        with open(humidity_outfile, 'a') as f:
            f.write(str(humidity) + ",")
        print("temp: ", temp)
        print("humidity: ", temp)
        time.sleep(poll_time_s)
