import dht
import time
from umqtt.simple import MQTTClient

c = MQTTClient("umqtt_client",'192.168.4.2')
my_dht = dht.DHT11(machine.Pin(2))
mqtt_connected = False

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
        print("humidity: ", humidity)
        time.sleep(poll_time_s)

def connect_mqtt():
    if not(mqtt_connected):
        try:
            c.connect()
            mqtt_connected = True
            return True
        except Exception as ex:
            print('unable to connect mqtt:', ex.message)
            return False

def disconnect_mqtt():
    if (mqtt_connected):
        c.disconnect()
        mqtt_connected = False

def temp_humidity_mqtt(poll_time_s):
    #if connect_mqtt():
    while True:
        my_dht.measure()
        temp = my_dht.temperature()
        humidity = my_dht.humidity()
        c.publish(b"/vine_sensor/temp",str(temp))
        c.publish(b"/vine_sensor/humidity",str(humidity))
        print("temp: ", temp)
        print("humidity: ", humidity)
        time.sleep(poll_time_s)
