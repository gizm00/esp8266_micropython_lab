## PyCon 2017 IoT Tutorial
##### The Internet of Things with MicroPython and Friends

### Setup Instructions
Welcome! Here are some instructions to help you get setup for the tutorial. If you run into problems please file an issue / check existing issues.

 The equipment you will need:
  * A computer with wifi and an available USB (3) port. We will use the USB port to power the microcontroller. You can also use a USB charging stick in lieu of a USB port.

  * A web browser. Chrome preferred, Firefox or Windows Edge will also work.

Programs to install:  
I recommend you create a directory i.e. pycon2017 to keep track of the various collateral needed.

* Clone the [webrepl client](https://github.com/micropython/webrepl). This is a web interface we will use to program the ESP8266.

`cd pycon2017`  
`git clone https://github.com/micropython/webrepl.git`  

* Install [Crouton](https://github.com/edfungus/Crouton).  Time permitting, we will use Crouton to view data. You will need [node](https://nodejs.org/en/download/) and  [grunt_cli](https://github.com/gruntjs/grunt-cli).

When you run grunt, you will see messages as Crouton starts up. Note the web server address and navigate there to view the Crouton dashboard

`Running "connect:server" (connect) task`  
`Started connect web server on http://localhost:9000`

Crouton isn't a critical piece so don't fret if it gives you sass.

* Install the [Mosquitto MQTT broker]( https://mosquitto.org/download/)  
We will be using Mosquitto to transfer messages using the MQTT protocol.  
  - MacOS: `brew install mosquitto`
  - Windows: Download the [Mosquitto Install Files]( http://www.steves-internet-guide.com/downloads/) and place in C:\Program Files (x86)\mosquitto  


[This tutorial](https://www.baldengineer.com/mqtt-tutorial.html) has some helpful tips on installing and testing Mosquitto, such as:  
1. Start the mosquitto service  
  * MacOS: `brew services start mosquitto`
  * Windows: cd to the directory where you installed mosquitto and type `mosquitto`  


2. In another terminal/command window, setup a test subscriber. Remember you need to be in the mosquitto directory on Windows for this to work:  
`mosquitto_sub -h 127.0.0.1 -i testSub -t debug`

3. In another terminal/command window, setup a test publisher and send some messages. You should see these show up in your subscriber terminal  
`mosquitto_pub -h 127.0.0.1 -i testPublish -t debug -m 'Hello World'`

 * Optionally, install the driver for the ESP8266. We won't be using this to connect to the ESP, but if you wanted to have a backup option or are just curious you can add this driver. I've verified that the firmware we are using (see firmware/ in this repo) works with the Mac driver
    - [MacOS](http://www.wch.cn/download/CH341SER_MAC_ZIP.html)  
    - [Windows](http://www.wch.cn/download/CH341SER_ZIP.html)
    - [Linux](http://www.wch.cn/download/CH341SER_LINUX_ZIP.html)

  Unfortunately I don't know how you can test that the driver is working without having an ESP board to plug in to. 
