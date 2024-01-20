#line 1 "D:/University Documents/Subjects/(4) 1st Semester 2023/Embedded Systems - 22442/Project/MikroC Projects/Project/Project.c"
#line 19 "D:/University Documents/Subjects/(4) 1st Semester 2023/Embedded Systems - 22442/Project/MikroC Projects/Project/Project.c"
void Rotation60_F();
void Rotation60_B();
void cs_delay(unsigned int);
void delay_us(unsigned int usCnt);
void delay_ms(unsigned int msCnt);
int check_fire_front();
int check_fire_back();
void Rotate_Car_Right();
void Rotate_Car_Left();
void Turn_Car_Right();
void Turn_Car_Left();
int Car_Forward();
void Car_Stop();
int distance_read();
int Car_Forward_Fire();
void ATD_init(void);
unsigned int ATD_read(unsigned char channel);




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




unsigned int us;
unsigned int ms;
unsigned int cc;
unsigned int i, Distance, a;
int temp;
unsigned const int error = 404;
int Servo_F = 404;
int Servo_B = 404;
int Fire_Gone = 0;
int obstacle = 0;
int checker = 0;
unsigned int angle = 0;
unsigned char Alert;
unsigned char channel;
float desp1f;
float volt;
float tempe;
char desp1c[4];
float desp2f;
char desp2c[4];



void interrupt(void)
{

 TMR0 = 178;
 if (Alert == 1)
 {
 PORTD = PORTD|0x04;
 delay_ms(500);
 PORTD = PORTD&0xFB;
 Alert = 0;
 }
 INTCON = INTCON & 0xFB;
}




void main()
{

 TMR0 = 178;
 OPTION_REG = 0x07;
 INTCON = 0xA0;


 T1CON = 0x10;


 T2CON = 0x07;
 CCP1CON = 0x0C;
 CCP2CON = 0x0C;
 PR2 = 250;





 TRISA = 0x01;










 TRISB = 0x80;










 TRISC = 0x20;










 TRISD = 0x01;
#line 162 "D:/University Documents/Subjects/(4) 1st Semester 2023/Embedded Systems - 22442/Project/MikroC Projects/Project/Project.c"
 Lcd_Init();
 delay_ms(1000);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 delay_ms(100);
 Lcd_Cmd(_LCD_CLEAR);
 delay_ms(100);


 PORTA = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;
 PORTD = 0x00;

 PORTD = PORTD|0x02;
 Alert = 0;

 delay_ms(1000);

 while (Fire_Gone == 0)
 {
#line 193 "D:/University Documents/Subjects/(4) 1st Semester 2023/Embedded Systems - 22442/Project/MikroC Projects/Project/Project.c"
 Lcd_Cmd(_LCD_CLEAR);
 delay_ms(100);
 Lcd_Out(1, 1, "FIRE FIGHTER");
 delay_ms(2000);

 Servo_F = check_fire_front();
 if (Servo_F == 404)
 {
 delay_ms(100);
 Servo_B = check_fire_Back();
 }

 delay_ms(100);
 Rotation60_F();
 Rotation60_B();
 delay_ms(100);


 if (Servo_F == 60)
 {
 delay_ms(1000);
 checker = Car_Forward_Fire();
 }




 else if (Servo_F < 60 || (Servo_B > 59 && Servo_B < 140))
 {
 i = 0;
 while ((PORTB&0x80) == 0 && i != 50)
 {
 Rotate_Car_Right();
 i+=1;
 }
 Car_Stop();
 delay_ms(1000);
 checker = Car_Forward_Fire();
 }



 else if ((Servo_F > 60 && Servo_F < 140) || Servo_B < 60)
 {
 i = 0;
 while ((PORTB&0x80) == 0 && i != 50)
 {
 Rotate_Car_Left();
 i+=1;
 }
 Car_Stop();
 delay_ms(1000);
 checker = Car_Forward_Fire();
 }


 if (checker == 1)
 {
 Alert = 1;
 Fire_Gone = 1;
 break;
 }



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



 ATD_init();
 delay_ms(1000);
 desp1f = ATD_read(0);
 volt = desp1f*4.88;
 tempe = volt/10;
 delay_ms(100);
 inttostr(tempe,desp1c);
 delay_ms(1000);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Room Temp");
 Lcd_Out(2, 1, desp1c);

 delay_ms(500);
 if (tempe > 70)
 {
 Alert = 1;
 }
}




int Car_Forward_Fire()
{
 while(distance_read() > 19)
 {
 Distance = Car_Forward();
 }
 Car_Stop();





 delay_ms(3000);
 if (check_fire_front())
 {

 Lcd_Cmd(_LCD_CLEAR);
 delay_ms(100);
 Lcd_Out(1, 1, "FIRE FIGHTER");
 Lcd_Out(2, 1, "Water ON");
 delay_ms(1000);
 Alert = 1;
 PORTD = PORTD|0x08;
 delay_ms(3000);
 PORTD = PORTD&0xF7;
 Lcd_Cmd(_LCD_CLEAR);
 delay_ms(100);
 Lcd_Out(1, 1, "FIRE FIGHTER");
 Lcd_Out(2, 1, "Water OFF");
 delay_ms(1000);
 delay_ms(4000);
 return 1;
 }
}




int Car_Forward()
{

 Distance = distance_read();
 if (Distance > 19)
 {
 CCPR1L = 70;
 CCPR2L = 65;
 delay_ms(2);
 PORTD = PORTD|0x10;
 PORTD = PORTD&0xDF;
 PORTD = PORTD|0x40;
 PORTD = PORTD&0x7F;
 return 0;
 }
 else
 {
 Car_Stop();
 Alert = 1;
 return 1;
 }
}


void Turn_Car_Right()
{
 CCPR1L = 75;
 CCPR2L = 75;
 delay_ms(2);
 PORTD = PORTD&0xEF;
 PORTD = PORTD|0x20;
 PORTD = PORTD|0x40;
 PORTD = PORTD&0x7F;
 delay_ms(800);
 Car_Stop();
}


void Turn_Car_Left()
{
 CCPR1L = 75;
 CCPR2L = 75;
 delay_ms(2);
 PORTD = PORTD|0x10;
 PORTD = PORTD&0xDF;
 PORTD = PORTD&0xBF;
 PORTD = PORTD|0x80;
 delay_ms(800);
 Car_Stop();
}


void Rotate_Car_Right()
{
 CCPR1L = 75;
 CCPR2L = 75;
 delay_ms(100);
 PORTD = PORTD&0xEF;
 PORTD = PORTD|0x20;
 PORTD = PORTD|0x40;
 PORTD = PORTD&0x7F;
 delay_ms(150);
 Car_Stop();
 delay_ms(500);
}


void Rotate_Car_Left()
{
 CCPR1L = 75;
 CCPR2L = 75;
 delay_ms(100);
 PORTD = PORTD|0x10;
 PORTD = PORTD&0xDF;
 PORTD = PORTD&0xBF;
 PORTD = PORTD|0x80;
 delay_ms(150);
 Car_Stop();
 delay_ms(500);
}


void Car_Stop()
{
 CCPR1L = 0;
 CCPR2L = 0;
 PORTD = PORTD&0xEF;
 PORTD = PORTD&0xDF;
 PORTD = PORTD&0xBF;
 PORTD = PORTD&0x7F;
}


int check_fire_front()
{

 int Fire = 0;
 int servo_angle = 0;
 while (Fire == 0)
 {
 for (servo_angle = 0; servo_angle < 140; servo_angle += 10)
 {
 for (i = 0; i < 50; i++)
 {
 PORTC = PORTC|0x08;
 cs_delay(servo_angle);
 PORTC = PORTC&0xF7;
 delay_ms(10);
 }



 if (PORTB&0x80)
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


int check_fire_back()
{

 int Fire = 0;
 int servo_angle = 0;
 while (Fire == 0)
 {
 for (servo_angle = 0; servo_angle < 140; servo_angle += 10)
 {
 for (i = 0; i < 50; i++)
 {
 PORTC = PORTC|0x10;
 cs_delay(servo_angle);
 PORTC = PORTC&0xEF;
 delay_ms(10);
 }



 if (PORTD&0x01)
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


void Rotation60_F()
{
 for (i = 0; i < 50; i++)
 {
 PORTC = PORTC|0x08;
 cs_delay(60);
 PORTC = PORTC&0xF7;
 delay_ms(18);
 }
}


void Rotation60_B()
{
 for (i = 0; i < 50; i++)
 {
 PORTC = PORTC|0x10;
 cs_delay(60);
 PORTC = PORTC&0xEF;
 delay_ms(18);
 }
}


void delay_ms(unsigned int msCnt)
{
 ms = 0;
 cc = 0;
 for (ms = 0; ms < (msCnt); ms++)
 {
 for (cc = 0; cc < 155; cc++);
 }
}


void delay_us(unsigned int usCnt)
{
 us = 0;

 for (us = 0; us < usCnt; us++)
 {
 asm NOP;
 asm NOP;
 }
}


void cs_delay(unsigned int count)
{
 int j = 0;
 delay_us(550);
 for (j = 0; j < count; j++)
 {
 delay_us(6);
 }
}



int distance_read()
{
 TMR1H = 0;
 TMR1L = 0;

 PORTC = PORTC|0x40;
 delay_us(10);
 PORTC = PORTC&0xBF;

 while (!(PORTC&0x20));
 T1CON.F0 = 1;
 while (PORTC&0x20);
 T1CON.F0 = 0;

 a = (TMR1L | (TMR1H << 8));
 a = a / 58.82;
 a = a + 1;
 return a;
}


void ATD_init(void)
{
 ADCON0 = 0b01000001;
 ADCON1 = 0b11000000;
}

unsigned int ATD_read(unsigned char channel)
{

 ADCON0 = (ADCON0 & 0b11000111) | (channel << 3);
 ADCON0 = ADCON0 | 0x04;
 while (ADCON0 & 0x04);
 return (ADRESH << 8) | ADRESL;
}
