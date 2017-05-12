# This file is executed on every boot (including wake-boot from deepsleep)
#import esp
#esp.osdebug(None)
import gc
import webrepl
webrepl.start()
gc.collect()
import dht
import machine
gc.collect()
dht_module = dht.DHT11(machine.Pin(2))
