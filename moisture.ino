// Pins
#define MOISTURE_PIN 2    // GPIO2 / A2
#define SENSOR_PWR   3    // Optional: use a GPIO to power the sensor, or tie to 3V3

// Calibration values (you must measure these)
int dryValue = 3200;   // ADC reading when sensor is in dry air
int wetValue = 1200;   // ADC reading when sensor is in wet soil

void setup() {
  Serial.begin(115200);
  analogReadResolution(12);           // 0-4095
  analogSetAttenuation(ADC_11db);     // Full 0-3.3V range

  pinMode(SENSOR_PWR, OUTPUT);
  digitalWrite(SENSOR_PWR, HIGH);     // If using GPIO for sensor power
}

void loop() {
  int sum = 0;
  int samples = 10;

  // Average multiple readings for stability
  for (int i = 0; i < samples; i++) {
    sum += analogRead(MOISTURE_PIN);
    delay(10);   // small delay between readings
  }

  int raw = sum / samples;

  // Map to percentage (0% = dry, 100% = wet)
  int moisturePercent = map(raw, dryValue, wetValue, 0, 100);
  moisturePercent = constrain(moisturePercent, 0, 100);

  Serial.print("Raw ADC: ");
  Serial.print(raw);
  Serial.print("  |  Moisture %: ");
  Serial.println(moisturePercent);

  delay(1000);  // read every second
}
