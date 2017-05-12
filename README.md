## PyCon 2017 IoT Tutorial
##### The Internet of Things with MicroPython and Friends
Welcome!
This repo is mainly here to provide info on how to get setup for the tutorial. I might add some more interesting files later on, Ill email the class if I do.

You will be learning to program in micropython using the ESP8266 microcontroller with the WeMos D1 mini development board. Phew! Basically the WeMos is the blue part of the picture below and the ESP is the silver & black part with the weird wave form looking thing (its an antenna).  The WeMos gives us some nice extras, like a reset button and a mini USB connection to power and communicate with the board. When I talk about 'the board' I'm referring to the WeMos.

![photo of board and USB cable](photos/board.jpg)

 We will be creating a Thing to connect to the Internet that monitors temperature and humidity (the light blue boxy thing beneath the WeMos). There will be blinking LEDs, sensing and communicating, and discussions of basic security for IoT networks. There will also be snacks, I'm told.

### Setup Instructions
Here are some instructions to help you get setup for the tutorial. If you run into problems please file an issue / check existing issues. Failing that you can contact me through the PyCon email interface.

 The equipment you will need:
  * A computer with wifi and an available USB (3) port. We will use the USB port to power the ESP8266 microcontroller. You can also use a USB charging brick instead of a USB port.

  * A web browser. Chrome preferred, Firefox or Windows Edge will also work. The webrepl client behaves a little finicky depending on browser, particularly for copy and paste. These 3 worked well.

#### Programs to install:  
I recommend you create a directory i.e. pycon2017 to keep track of the various collateral needed.

* Clone the [webrepl client](https://github.com/micropython/webrepl). This is a web interface we will use to program the ESP8266.

`cd pycon2017`  
`git clone https://github.com/micropython/webrepl.git`  

* Install [Crouton](https://github.com/edfungus/Crouton).  Time permitting, we will use Crouton to view data. Crouton isn't a critical piece so don't fret if it gives you sass. You will need [node](https://nodejs.org/en/download/) and  [grunt_cli](https://github.com/gruntjs/grunt-cli).

When you run grunt, you will see messages as Crouton starts up. Note the web server address and navigate there to view the Crouton dashboard

`Running "connect:server" (connect) task`  
`Started connect web server on http://localhost:9000`


* Install the [Mosquitto MQTT broker]( https://mosquitto.org/download/)  
We will be using Mosquitto to transfer messages using the MQTT protocol.  
  - MacOS: `brew install mosquitto`
  - Windows: Download the [Mosquitto Install Files]( http://www.steves-internet-guide.com/downloads/) and place in C:\Program Files (x86)\mosquitto  
  - Linux: You probably know better than me, check the [Mosquitto website]( https://mosquitto.org/download/)


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
