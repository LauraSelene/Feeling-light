/* Feeling light - Selene Orozco, 
   Used with only 1 photoresistor.
   This code takes the imput frome the photoresistor conectet to the Arduino, 
   and changes de amplitude and frequency of the sound
Credits:
Data from multiple sensors / Processing
by BARRAGAN http://barraganstudio.com */

import processing.serial.*;
import processing.sound.*;

SinOsc sine;
SoundFile soundfile;
Serial myPort;
int linefeed = 10;   // Linefeed in ASCII
int numSensors = 1;  // we will be expecting for reading data from 1 sensor
int sensors[];       // array to read the values
int pSensors[];      // array to store the previuos reading, usefur for comparing
int p=0;
int limit1=200, limit2=900; // Variables to calibrate on site


void setup() {
  size(200, 200);
  background(255);

  // List all the available serial ports in the output pane.
  // You will need to choose the port that the Wiring board is
  // connected to from this list. The first port in the list is
  // port #0 and the third port in the list is port #2.
  println(Serial.list());

  myPort = new Serial(this, Serial.list()[3], 9600);
  // read bytes into a buffer until you get a linefeed (ASCII 10):
  myPort.bufferUntil(linefeed);

  // Load a soundfile
  soundfile = new SoundFile(this, "vibraphon.aiff");

  // Play the file in a loop
  soundfile.loop();

  // create the sine oscillator.
  sine = new SinOsc(this);
}
void draw() {
  if ((pSensors != null)&&(sensors != null)) {
    // Control de sonido con la fotocelda
    sine.amp(0.01);
    sine.play();
    // Map the photoresistor value from 80Hz to 1000Hz for the sine frequency
    float frequency = map(sensors[0], limit1, limit2, 80, 1000);
    sine.freq(frequency);
    // Map the photoresistor value from 0 to 1 for volume
    float a = map(sensors[0], limit1, limit2, 0, 1.0);
    soundfile.amp(a);
    // Map the photoresistor value from -1 to 1 for left to right panning
    float position = map(sensors[0], limit1, limit2, -1.0, 1.0);
    soundfile.pan(position);
  }
}
void serialEvent(Serial myPort) {
  // read the serial buffer:
  String myString = myPort.readStringUntil(linefeed);

  // if you got any bytes other than the linefeed:
  if (myString != null) {
    myString = trim(myString);

    // split the string at the commas
    // and convert the sections into integers:

    pSensors = sensors;
    sensors = int(split(myString, ','));

    // print out the values you got:

    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
      int numero=sensorNum+1;
      print("Sensor " + numero + ": " + sensors[sensorNum] + "\t");
    }
    print(p);
    // add a linefeed after all the sensor values are printed:
    println();
  }
}
