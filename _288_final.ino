const int button1pin = 2;
const int button2pin = 3;
const int analog1 = A0;
int button1state = 0;
int button2state = 0;
int analog1value = 0;
int analog1temp = analog1value;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(button1pin, INPUT);
  pinMode(button2pin, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  button1state = digitalRead(button1pin);
  button2state = digitalRead(button2pin);
  analog1value = analogRead(analog1);
  if(analog1value != analog1temp)
  {
    Serial.println("c: " + analog1value);
    analog1temp = analog1value;
  }
  if(button1state == LOW)
  {
    Serial.println("a");
  }
  if(button2state == LOW)
  {
    Serial.println("b");
  }
}
