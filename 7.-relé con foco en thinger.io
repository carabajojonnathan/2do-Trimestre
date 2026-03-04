#include <WiFi.h>
#include <ThingerESP32.h>

/* ===== THINGER ===== */
#define USERNAME "jonnathan714"
#define DEVICE_ID "jonna"
#define DEVICE_CREDENTIAL "714126"

/* ===== WIFI ===== */
#define SSID "MECATRONICA_3ABC"
#define SSID_PASSWORD "MEC2025@."

/* ===== RELÉ ===== */
#define RELAY_PIN 5   // Cambia si usas otro pin

ThingerESP32 thing(USERNAME, DEVICE_ID, DEVICE_CREDENTIAL);

void setup() {
  Serial.begin(115200);

  pinMode(RELAY_PIN, OUTPUT);
  digitalWrite(RELAY_PIN, HIGH); // Apagado inicial (activo bajo)

  thing.add_wifi(SSID, SSID_PASSWORD);

  // Recurso foco en Thinger
  thing["RELE"] << [](pson &in){
    if(in.is_empty()) {
      in = (digitalRead(RELAY_PIN) == LOW);  // Devuelve estado real
    } else {
      if(in) {
        digitalWrite(RELAY_PIN, LOW);   // ENCENDER (activo bajo)
      } else {
        digitalWrite(RELAY_PIN, HIGH);  // APAGAR
      }
    }
  };
}

void loop() {
  thing.handle();
}
