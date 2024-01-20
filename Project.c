

// ***************************************************************************
//  File Name      : Project.c
//  Version        : 1.0
//  Description    : Robotic Built Car Fire Extinguisher
//  Authors        : Omar, Hadeel, Zaid
//  Target         : PIC16F877A Board
//  Compiler       : MPLAB IPE v6.15
//  IDE            : mikroC Pro for PIC v7.6.0
//  Programmer     : PICKit3
//  Last Updated   : 20 Jan 2024
//  Libraries Used : Lcd, Conversions
// ***************************************************************************


// =============================================== [ Functions ] ============================================

void Rotation60_F();                              // Front Servo Set to Front
void Rotation60_B();                              // Back Servo Set to Front
void cs_delay(unsigned int);                      // Delay for Servo Motors
void delay_us(unsigned int usCnt);                // Delay in us
void delay_ms(unsigned int msCnt);                // Delay in ms
int check_fire_front();                           // Check fire infront of car
int check_fire_back();                            // Check fire behind of car
void Rotate_Car_Right();                          // Rotate car Right
void Rotate_Car_Left();                           // Rotate car Left
void Turn_Car_Right();                            // Turn the Car Right
void Turn_Car_Left();                             // Turn the Car Left
int Car_Forward();                                // Move Car Forward
void Car_Stop();                                  // Stop Car from Moving
int distance_read();                              // Ultrasonic Sensor Function
int Car_Forward_Fire();                           // Moving Car FWD till Distance < X && Fire Detected == 1
void ATD_init(void);                              // Analog Configuration
unsigned int ATD_read(unsigned char channel);     // Read From Analog Pins

// =============================================== [ LCD ] ==================================================

// LCD module connections
sbit LCD_RS at RB1_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RB3_bit;
sbit LCD_D5 at RB4_bit;
sbit LCD_D6 at RB5_bit;
sbit LCD_D7 at RB6_bit;
sbit LCD_RS_Direction at TRISB1_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISB3_bit;
sbit LCD_D5_Direction at TRISB4_bit;
sbit LCD_D6_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB6_bit;
// End LCD module connections

// =============================================== [ Variables ] ============================================

unsigned int us; // For Delay Functions
unsigned int ms; // For Delay Functions
unsigned int cc; // For Delay Functions
unsigned int i, Distance, a; // Other
int temp; // Temp Variable
unsigned const int error = 404; // Predefined Error
int Servo_F = 404; // Servo Variable
int Servo_B = 404; // Servo Variable
int Fire_Gone = 0; // To check if Fire Extinguished
int obstacle = 0; // To check if obstacle found
int checker = 0; // Used with Fire_Gone
unsigned int angle = 0; // Angle of Servo Motor
unsigned char Alert; // Alert Variable
unsigned char channel; // Used to choose which bit of ADCON0
float desp1f; // First Line of LCD Float
float volt; // Voltage of LM35
float tempe; // Temp. of LM35
char desp1c[4]; // First Line of LCD Char
float desp2f; // Second Line of LCD Float
char desp2c[4]; // Second Line of LCD Char

// =============================================== [ Interrupt ] ============================================

void interrupt(void)
{ // get into here every 10 ms
  // Turn ON Buzzer
  TMR0 = 178;
  if (Alert == 1)
  {
    PORTD = PORTD|0x04; // PORTD.F2 = 1;
    delay_ms(500);
    PORTD = PORTD&0xFB; // PORTD.F2 = 0;
    Alert = 0;
  }
  INTCON = INTCON & 0xFB;
} // clear TMR0IF


// =============================================== [ Main ] =================================================

void main()
{
  // INTCON Register - Timer Interrupt Timer 0
  TMR0 = 178;        // count 78 times (10ms) before overflowing
  OPTION_REG = 0x07; // Internal clock with 256 prescaler, TMR0 increments every 128uS
  INTCON = 0xA0;     // GIE and T0IE

  // Timer 1 Module for Ultrasonic Sensor
  T1CON = 0x10;

  // Timer2 & PWM for Motors
  T2CON = 0x07;   // Enable Timer2 at Fosc/4 with 1:16 prescaler (8 uS percount 2000uS to count 250 counts)
  CCP1CON = 0x0C; // Enable PWM for CCP1
  CCP2CON = 0x0C; // Enable PWM for CCP2
  PR2 = 250;      // 250 counts = 8uS *250 = 2ms period

  // ##########################################################################################################
  
 
  //  PORTA
  TRISA = 0x01;
  // TRISA.F0 = 1; // PORTA 0 LM35 Input
  // TRISA.F1 = 0; // PORTA 1
  // TRISA.F2 = 0; // PORTA 2
  // TRISA.F3 = 0; // PORTA 3 
  // TRISA.F4 = 0; // PORTA 4 
  // TRISA.F5 = 0; // PORTA 5
  // TRISA.F6 = 0; // PORTA 6
  // TRISA.F7 = 0; // PORTA 7

  // PORTB
  TRISB = 0x80;
  // // TRISB.F0 = 0; // PORTB 0
  // // TRISB.F1 = 0; // PORTB 1 RS
  // // TRISB.F2 = 0; // PORTB 2 EN
  // // TRISB.F3 = 0; // PORTB 3 D4 
  // // TRISB.F4 = 0; // PORTB 4 D5
  // // TRISB.F5 = 0; // PORTB 5 D6
  // // TRISB.F6 = 0; // PORTB 6 D7
  //TRISB.F7 = 1; // PORTB 7 Fire Sensor Digital Front - INPUT

  // PORTC
  TRISC = 0x20;
  // TRISC.F0 = 0; // PORTC 0
  // TRISC.F1 = 0; // PORTC 1 CCP2 Motor Enable Right  - OUTPUT CCPRL2
  // TRISC.F2 = 0; // PORTC 2 CCP1 Motor Enable Left - OUTPUT CCPRL1
  // TRISC.F3 = 0; // PORTC 3 Servo (1) Front - OUTPUT
  // TRISC.F4 = 0; // PORTC 4 Servo (2) Back - OUTPUT
  // TRISC.F5 = 1; // PORTC 5 Ultrasonic Sensor Echo Pin - INPUT
  // TRISC.F6 = 0; // PORTC 6 Ultrasonic Sensor Trigger Pin - OUTPUT
  // TRISC.F7 = 0; // PORTC 7

  // PORTD
  TRISD = 0x01;
  // TRISD.F0 = 1; // PORTD 0 Fire Sensor Digital Back - INPUT
  // TRISD.F1 = 0; // PORTD 1 LED ON - To make sure the pic is on - OUTPUT
  // TRISD.F2 = 0; // PORTD 2 Buzzer - OUTPUT
  // TRISD.F3 = 0; // PORTD 3 Relay - Water Pump - OUTPUT
  // TRISD.F4 = 0; // PORTD 4 Motor - OUTPUT
  // TRISD.F5 = 0; // PORTD 5 Motor - OUTPUT
  // TRISD.F6 = 0; // PORTD 6 Motor - OUTPUT
  // TRISD.F7 = 0; // PORTD 7 Motor - OUTPUT

  // ##########################################################################################################

  // LCD Initialize 
  Lcd_Init();
  delay_ms(1000);
  Lcd_Cmd(_LCD_CURSOR_OFF);
  delay_ms(100);
  Lcd_Cmd(_LCD_CLEAR);
  delay_ms(100);

  // Set Ports to OFF
  PORTA = 0x00; // All PORTA set to 0
  PORTB = 0x00; // All PORTB set to 0
  PORTC = 0x00; // All PORTC set to 0
  PORTD = 0x00; // All PORTD set to 0

  PORTD = PORTD|0x02; // PORTD.F1 = 1; // LED ON
  Alert = 0;

  delay_ms(1000); // Wait 1 sec. to start the program

  while (Fire_Gone == 0)
  {
    // LCD 
    // // Read Distance
    // desp2f = distance_read();
    // delay_ms(100);
    // floattostr(desp2f,desp2c);
    // delay_ms(100);
    // // Lcd_Out(1, 1, "FIRE FIGHTER");
    // // Lcd_Out(2, 1, desp2c);
    // Lcd_Out_Cp(desp2c);
    // delay_ms(500);
    // Lcd_Cmd(_LCD_CLEAR);
    Lcd_Cmd(_LCD_CLEAR);
    delay_ms(100);
    Lcd_Out(1, 1, "FIRE FIGHTER");
    delay_ms(2000);

    Servo_F = check_fire_front(); // Check if there is fire infront of car
    if (Servo_F == 404)
    {
      delay_ms(100);
      Servo_B = check_fire_Back(); // Check if there is fire behind the car
    }

    delay_ms(100);
    Rotation60_F(); // Return Front servo to original place
    Rotation60_B(); // Return Back servo to original place
    delay_ms(100);

    // Case 1 (Fire is perfectly infront)
    if (Servo_F == 60)
    {
      delay_ms(1000);
      checker = Car_Forward_Fire();
    }

    // Case 2 (Fire is on the Right Side of the car)
    // Front Servo Angle 0 ~ 59
    // Back Servo Angle 60 ~ 140
    else if (Servo_F < 60 || (Servo_B > 59 && Servo_B < 140))
    {
      i = 0;
      while ((PORTB&0x80) == 0 && i != 50) // PORTB.F7 == 1
      {
        Rotate_Car_Right();
        i+=1;
      }
      Car_Stop();
      delay_ms(1000);
      checker = Car_Forward_Fire();
    }
    // Case 3 (Fire is on the Left Side of the car)
    // Front Servo Angle 61 ~ 140
    // Back Servo Angle 0 ~ 59
    else if ((Servo_F > 60 && Servo_F < 140) || Servo_B < 60)
    {
      i = 0;
      while ((PORTB&0x80) == 0 && i != 50) // PORTB.F7 == 1
      {
        Rotate_Car_Left();
        i+=1;
      }
      Car_Stop();
      delay_ms(1000);
      checker = Car_Forward_Fire();
    }

    // Fire Extinguished?
    if (checker == 1)
    {
      Alert = 1;
      Fire_Gone = 1;
      break;
    }

    //FWD 
    //Check each 1 ms if there is an obstacle for 3 sec.
    for (i = 0; i < 1000; i++)
    {
      obstacle = Car_Forward();
      if (obstacle == 1)
      {
        Car_Stop();
        delay_ms(1000);
        Turn_Car_Right();
        delay_ms(1000);
        break;
      }
      delay_ms(1);
    }
    Car_Stop();
  }


  // Read LM35 Once
  ATD_init();
  delay_ms(1000);
  desp1f = ATD_read(0); // Read Temp. Sensor
  volt = desp1f*4.88; // Convert into Voltage
  tempe = volt/10; // Getting Temp. Values
  delay_ms(100);
  inttostr(tempe,desp1c); // Convert Float to Char for LCD
  delay_ms(1000);
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Out(1, 1, "Room Temp");
  Lcd_Out(2, 1, desp1c);
  //Lcd_Out_Cp(desp1c);
  delay_ms(500);
  if (tempe > 70) // Temp. Too Hot
  {
    Alert = 1;
  }
}

// =============================================== [ Functions ] ============================================

// Moving Car FWD till Distance < X && Fire Detected == 1
int Car_Forward_Fire()
{
  while(distance_read() > 19)
  {
    Distance = Car_Forward();
  }
  Car_Stop();
  // Lcd_Cmd(_LCD_CLEAR);
  // delay_ms(100);
  // Lcd_Out(1, 1, "FIRE FIGHTER");
  // Lcd_Out(2, 1, "Checking Fire?");
  // delay_ms(100);
  delay_ms(3000);
  if (check_fire_front()) // PORTB.F7 == 1 PORTB&0x80
  {
    // Turn ON pump
    Lcd_Cmd(_LCD_CLEAR);
    delay_ms(100);
    Lcd_Out(1, 1, "FIRE FIGHTER");
    Lcd_Out(2, 1, "Water ON");
    delay_ms(1000);
    Alert = 1;
    PORTD = PORTD|0x08; // PORTD.F3 = 1;
    delay_ms(3000);
    PORTD = PORTD&0xF7; // PORTD.F3 = 0;
    Lcd_Cmd(_LCD_CLEAR);
    delay_ms(100);
    Lcd_Out(1, 1, "FIRE FIGHTER");
    Lcd_Out(2, 1, "Water OFF");
    delay_ms(1000);
    delay_ms(4000);
    return 1;
  }
}

// Move Car Forward
// Return 0 means no obstacle found
// Return 1 means obstacle found and Stop
int Car_Forward()
{
  // Check if there is any obstacle infront
  Distance = distance_read();
  if (Distance > 19)
  {
    CCPR1L = 70; // Left
    CCPR2L = 65; // Right
    delay_ms(2);
    PORTD = PORTD|0x10; // PORTD.F4 = 1;
    PORTD = PORTD&0xDF; // PORTD.F5 = 0;
    PORTD = PORTD|0x40; // PORTD.F6 = 1;
    PORTD = PORTD&0x7F; // PORTD.F7 = 0;
    return 0;
  }
  else
  {
    Car_Stop();
    Alert = 1;
    return 1;
  }
}

// Turn the Car Right
void Turn_Car_Right()
{
  CCPR1L = 75; // Left
  CCPR2L = 75; // Right
  delay_ms(2);
  PORTD = PORTD&0xEF; // PORTD.F4 = 0;
  PORTD = PORTD|0x20; // PORTD.F5 = 1;
  PORTD = PORTD|0x40; // PORTD.F6 = 1;
  PORTD = PORTD&0x7F; // PORTD.F7 = 0;
  delay_ms(800);
  Car_Stop();
}

// Turn the Car Left
void Turn_Car_Left()
{
  CCPR1L = 75; // Left
  CCPR2L = 75; // Right
  delay_ms(2);
  PORTD = PORTD|0x10; // PORTD.F4 = 1;
  PORTD = PORTD&0xDF; // PORTD.F5 = 0;
  PORTD = PORTD&0xBF; // PORTD.F6 = 0;
  PORTD = PORTD|0x80; // PORTD.F7 = 1;
  delay_ms(800);
  Car_Stop();
}

// Rotate car from Right 
void Rotate_Car_Right()
{
  CCPR1L = 75; // Left
  CCPR2L = 75; // Right
  delay_ms(100);
  PORTD = PORTD&0xEF; // PORTD.F4 = 0;
  PORTD = PORTD|0x20; // PORTD.F5 = 1;
  PORTD = PORTD|0x40; // PORTD.F6 = 1;
  PORTD = PORTD&0x7F; // PORTD.F7 = 0;
  delay_ms(150); // 150 ms delay
  Car_Stop();
  delay_ms(500); // 500 ms delay
}

// Rotate car from Left
void Rotate_Car_Left()
{
  CCPR1L = 75; // Left
  CCPR2L = 75; // Right
  delay_ms(100);
  PORTD = PORTD|0x10; // PORTD.F4 = 1;
  PORTD = PORTD&0xDF; // PORTD.F5 = 0;
  PORTD = PORTD&0xBF; // PORTD.F6 = 0;
  PORTD = PORTD|0x80; // PORTD.F7 = 1;
  delay_ms(150); // 150 ms delay
  Car_Stop();
  delay_ms(500); // 500 ms delay
}

// Stop the Car from Moving
void Car_Stop()
{
  CCPR1L = 0; // Left
  CCPR2L = 0; // Right
  PORTD = PORTD&0xEF; // PORTD.F4 = 0;
  PORTD = PORTD&0xDF; // PORTD.F5 = 0;
  PORTD = PORTD&0xBF; // PORTD.F6 = 0;
  PORTD = PORTD&0x7F; // PORTD.F7 = 0;
}

// Check fire infront of car
int check_fire_front()
{
  // Check Front Servo
  int Fire = 0;
  int servo_angle = 0;
  while (Fire == 0)
  {
    for (servo_angle = 0; servo_angle < 140; servo_angle += 10)
    {
      for (i = 0; i < 50; i++) // Loop to provide continuous train of pulse
      {
        PORTC = PORTC|0x08; // PORTC.F3 = 1;
        cs_delay(servo_angle); // Servo Angle
        PORTC = PORTC&0xF7; // PORTC.F3 = 0;
        delay_ms(10); // Speed of Servo
      }
      //delay_ms(10);
      // temp = ATD_read(0);
      // delay_ms(100);
      if (PORTB&0x80) // PORTB.F7 == 1
      {
        Alert = 1; // Alert
        Fire = 1; //  Fire Detected
        break;
      }
    }
    break;
  }
  if (Fire == 1)
  {
    return servo_angle;
  }
  else
  {
    return 404;
  }
}

// Check fire infront of car
int check_fire_back()
{
  // Check Back Servo
  int Fire = 0;
  int servo_angle = 0;
  while (Fire == 0)
  {
    for (servo_angle = 0; servo_angle < 140; servo_angle += 10)
    {
      for (i = 0; i < 50; i++) // Loop to provide continuous train of pulse
      {
        PORTC = PORTC|0x10; // PORTC.F4 = 1;
        cs_delay(servo_angle); // Servo Angle
        PORTC = PORTC&0xEF; // PORTC.F4 = 0;
        delay_ms(10); // Speed of Servo
      }
      //delay_ms(10);
      // temp = ATD_read(3);
      // delay_ms(100);
      if (PORTD&0x01) // PORTD.F0 == 1
      {
        Alert = 1;
        Fire = 1;
        break;
      }
    }
    break;
  }
  if (Fire == 1)
  {
    return servo_angle;
  }
  else
  {
    return 404;
  }
}

// Front Servo Set to Front
void Rotation60_F()
{
  for (i = 0; i < 50; i++) // Loop to provide continuous train of pulse
  {
    PORTC = PORTC|0x08; // PORTC.F3 = 1 // Send high to control signal terninal
    cs_delay(60); // Call delay function
    PORTC = PORTC&0xF7; // PORTC.F3 = 0; // Send low to control signal terninal
    delay_ms(18);
  }
}

// Back Servo Set to Front
void Rotation60_B()
{
  for (i = 0; i < 50; i++) // Loop to provide continuous train of pulse
  {
    PORTC = PORTC|0x10; // PORTC.F4 = 1; // Send high to control signal terninal
    cs_delay(60); // Call delay function
    PORTC = PORTC&0xEF; // PORTC.F4 = 0; // Send low to control signal terninal
    delay_ms(18);
  }
}

// Delay in ms
void delay_ms(unsigned int msCnt)
{
  ms = 0;
  cc = 0;
  for (ms = 0; ms < (msCnt); ms++)
  {
    for (cc = 0; cc < 155; cc++); // 1ms
  }
}

// Delay in us
void delay_us(unsigned int usCnt)
{
  us = 0;

  for (us = 0; us < usCnt; us++)
  {
    asm NOP; // 0.5 uS
    asm NOP; // 0.5uS
  }
}

// Delay For Servo Motors
void cs_delay(unsigned int count)
{
  int j = 0;
  delay_us(550);              // Delay to move the servo at 0�
  for (j = 0; j < count; j++) // Repeat the loop equal to as much as angle
  {
    delay_us(6); // Delay to displace servo by 1�
  }
}

// Ultrasonic Sensor Function
// 10 is eequal to 5cm
int distance_read()
{
  TMR1H = 0; // Sets the Initial Value of Timer
  TMR1L = 0; // Sets the Initial Value of Timer

  PORTC = PORTC|0x40; // PORTC.F6 = 1; // TRIGGER HIGH
  delay_us(10); // 10uS Delay
  PORTC = PORTC&0xBF; // PORTC.F6 = 0; // TRIGGER LOW

  while (!(PORTC&0x20));  // PORTC.F5// Waiting for Echo
  T1CON.F0 = 1; // Timer Starts
  while (PORTC&0x20);   // PORTC.F5 // Waiting for Echo goes LOW
  T1CON.F0 = 0; // Timer Stops

  a = (TMR1L | (TMR1H << 8)); // Reads Timer Value
  a = a / 58.82;              // Converts Time to Distance
  a = a + 1;                  // Distance Calibration
  return a;
}

// Analog Functions
void ATD_init(void)
{
  ADCON0 = 0b01000001; // ON, Channel 0, Fosc/16== 500KHz, Dont Go
  ADCON1 = 0b11000000; // All Analog
}

unsigned int ATD_read(unsigned char channel)
{
  // Set the ADC channel based on the 'channel' argument
  ADCON0 = (ADCON0 & 0b11000111) | (channel << 3);
  ADCON0 = ADCON0 | 0x04; // GO
  while (ADCON0 & 0x04); // wait until DONE
  return (ADRESH << 8) | ADRESL;
}