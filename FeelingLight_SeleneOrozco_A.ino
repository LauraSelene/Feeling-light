/**
// Feeling light - Selene Orozco, 
// Used with only 1 photoresistor.
Credits:
 * Data from multiple sensors / Processing
 * by BARRAGAN http://barraganstudio.com
 * 
 * Reads values from four photoresistors connected to the
 * analog input pins 0-3. The values read from the sensors are proportional
 * to the amount of light that hits their surface.
 * The values read are printed comma separated through the serial to use them in
 * Processing
 */

int sensorValue1;

void setup() {
  Serial.begin(9600);
}

void loop() {
  sensorValue1 = analogRead(A0);  // read sensor in analog input 0
  Serial.println(sensorValue1);   // print sensor 1
  delay(5);                       // wait 5ms for next reading
}

