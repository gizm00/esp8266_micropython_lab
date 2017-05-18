# This file is executed on every boot (including wake-boot from deepsleep)
#import esp
#esp.osdebug(None)
# this boot file can be used to restart the AP if needed
import gc
import network
ap_if = network.WLAN(network.AP_IF)
ap_if.active(True)
import webrepl
webrepl.start()
gc.collect()
import dht
import machine
gc.collect()
dht_module = dht.DHT11(machine.Pin(2))
