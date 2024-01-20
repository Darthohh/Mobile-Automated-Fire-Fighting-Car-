
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Project.c,79 :: 		void interrupt(void)
;Project.c,82 :: 		TMR0 = 178;
	MOVLW      178
	MOVWF      TMR0+0
;Project.c,83 :: 		if (Alert == 1)
	MOVF       _Alert+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt0
;Project.c,85 :: 		PORTD = PORTD|0x04; // PORTD.F2 = 1;
	BSF        PORTD+0, 2
;Project.c,86 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_interrupt1:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt1
	DECFSZ     R12+0, 1
	GOTO       L_interrupt1
	DECFSZ     R11+0, 1
	GOTO       L_interrupt1
	NOP
	NOP
;Project.c,87 :: 		PORTD = PORTD&0xFB; // PORTD.F2 = 0;
	MOVLW      251
	ANDWF      PORTD+0, 1
;Project.c,88 :: 		Alert = 0;
	CLRF       _Alert+0
;Project.c,89 :: 		}
L_interrupt0:
;Project.c,90 :: 		INTCON = INTCON & 0xFB;
	MOVLW      251
	ANDWF      INTCON+0, 1
;Project.c,91 :: 		} // clear TMR0IF
L_end_interrupt:
L__interrupt134:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Project.c,96 :: 		void main()
;Project.c,99 :: 		TMR0 = 178;        // count 78 times (10ms) before overflowing
	MOVLW      178
	MOVWF      TMR0+0
;Project.c,100 :: 		OPTION_REG = 0x07; // Internal clock with 256 prescaler, TMR0 increments every 128uS
	MOVLW      7
	MOVWF      OPTION_REG+0
;Project.c,101 :: 		INTCON = 0xA0;     // GIE and T0IE
	MOVLW      160
	MOVWF      INTCON+0
;Project.c,104 :: 		T1CON = 0x10;
	MOVLW      16
	MOVWF      T1CON+0
;Project.c,107 :: 		T2CON = 0x07;   // Enable Timer2 at Fosc/4 with 1:16 prescaler (8 uS percount 2000uS to count 250 counts)
	MOVLW      7
	MOVWF      T2CON+0
;Project.c,108 :: 		CCP1CON = 0x0C; // Enable PWM for CCP1
	MOVLW      12
	MOVWF      CCP1CON+0
;Project.c,109 :: 		CCP2CON = 0x0C; // Enable PWM for CCP2
	MOVLW      12
	MOVWF      CCP2CON+0
;Project.c,110 :: 		PR2 = 250;      // 250 counts = 8uS *250 = 2ms period
	MOVLW      250
	MOVWF      PR2+0
;Project.c,116 :: 		TRISA = 0x01;
	MOVLW      1
	MOVWF      TRISA+0
;Project.c,127 :: 		TRISB = 0x80;
	MOVLW      128
	MOVWF      TRISB+0
;Project.c,138 :: 		TRISC = 0x20;
	MOVLW      32
	MOVWF      TRISC+0
;Project.c,149 :: 		TRISD = 0x01;
	MOVLW      1
	MOVWF      TRISD+0
;Project.c,162 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;Project.c,163 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;Project.c,164 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Project.c,165 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;Project.c,166 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Project.c,167 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
;Project.c,170 :: 		PORTA = 0x00; // All PORTA set to 0
	CLRF       PORTA+0
;Project.c,171 :: 		PORTB = 0x00; // All PORTB set to 0
	CLRF       PORTB+0
;Project.c,172 :: 		PORTC = 0x00; // All PORTC set to 0
	CLRF       PORTC+0
;Project.c,173 :: 		PORTD = 0x00; // All PORTD set to 0
	CLRF       PORTD+0
;Project.c,175 :: 		PORTD = PORTD|0x02; // PORTD.F1 = 1; // LED ON
	BSF        PORTD+0, 1
;Project.c,176 :: 		Alert = 0;
	CLRF       _Alert+0
;Project.c,178 :: 		delay_ms(1000); // Wait 1 sec. to start the program
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;Project.c,180 :: 		while (Fire_Gone == 0)
L_main6:
	MOVLW      0
	XORWF      _Fire_Gone+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main136
	MOVLW      0
	XORWF      _Fire_Gone+0, 0
L__main136:
	BTFSS      STATUS+0, 2
	GOTO       L_main7
;Project.c,193 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Project.c,194 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
;Project.c,195 :: 		Lcd_Out(1, 1, "FIRE FIGHTER");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Project.c,196 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	DECFSZ     R11+0, 1
	GOTO       L_main9
	NOP
;Project.c,198 :: 		Servo_F = check_fire_front(); // Check if there is fire infront of car
	CALL       _check_fire_front+0
	MOVF       R0+0, 0
	MOVWF      _Servo_F+0
	MOVF       R0+1, 0
	MOVWF      _Servo_F+1
;Project.c,199 :: 		if (Servo_F == 404)
	MOVF       R0+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main137
	MOVLW      148
	XORWF      R0+0, 0
L__main137:
	BTFSS      STATUS+0, 2
	GOTO       L_main10
;Project.c,201 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
	NOP
;Project.c,202 :: 		Servo_B = check_fire_Back(); // Check if there is fire behind the car
	CALL       _check_fire_back+0
	MOVF       R0+0, 0
	MOVWF      _Servo_B+0
	MOVF       R0+1, 0
	MOVWF      _Servo_B+1
;Project.c,203 :: 		}
L_main10:
;Project.c,205 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
	NOP
;Project.c,206 :: 		Rotation60_F(); // Return Front servo to original place
	CALL       _Rotation60_F+0
;Project.c,207 :: 		Rotation60_B(); // Return Back servo to original place
	CALL       _Rotation60_B+0
;Project.c,208 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	DECFSZ     R11+0, 1
	GOTO       L_main13
	NOP
;Project.c,211 :: 		if (Servo_F == 60)
	MOVLW      0
	XORWF      _Servo_F+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main138
	MOVLW      60
	XORWF      _Servo_F+0, 0
L__main138:
	BTFSS      STATUS+0, 2
	GOTO       L_main14
;Project.c,213 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	DECFSZ     R11+0, 1
	GOTO       L_main15
	NOP
	NOP
;Project.c,214 :: 		checker = Car_Forward_Fire();
	CALL       _Car_Forward_Fire+0
	MOVF       R0+0, 0
	MOVWF      _checker+0
	MOVF       R0+1, 0
	MOVWF      _checker+1
;Project.c,215 :: 		}
	GOTO       L_main16
L_main14:
;Project.c,220 :: 		else if (Servo_F < 60 || (Servo_B > 59 && Servo_B < 140))
	MOVLW      128
	XORWF      _Servo_F+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main139
	MOVLW      60
	SUBWF      _Servo_F+0, 0
L__main139:
	BTFSS      STATUS+0, 0
	GOTO       L__main131
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _Servo_B+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main140
	MOVF       _Servo_B+0, 0
	SUBLW      59
L__main140:
	BTFSC      STATUS+0, 0
	GOTO       L__main132
	MOVLW      128
	XORWF      _Servo_B+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main141
	MOVLW      140
	SUBWF      _Servo_B+0, 0
L__main141:
	BTFSC      STATUS+0, 0
	GOTO       L__main132
	GOTO       L__main131
L__main132:
	GOTO       L_main21
L__main131:
;Project.c,222 :: 		i = 0;
	CLRF       _i+0
	CLRF       _i+1
;Project.c,223 :: 		while ((PORTB&0x80) == 0 && i != 50) // PORTB.F7 == 1
L_main22:
	MOVLW      128
	ANDWF      PORTB+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main23
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main142
	MOVLW      50
	XORWF      _i+0, 0
L__main142:
	BTFSC      STATUS+0, 2
	GOTO       L_main23
L__main130:
;Project.c,225 :: 		Rotate_Car_Right();
	CALL       _Rotate_Car_Right+0
;Project.c,226 :: 		i+=1;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Project.c,227 :: 		}
	GOTO       L_main22
L_main23:
;Project.c,228 :: 		Car_Stop();
	CALL       _Car_Stop+0
;Project.c,229 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main26:
	DECFSZ     R13+0, 1
	GOTO       L_main26
	DECFSZ     R12+0, 1
	GOTO       L_main26
	DECFSZ     R11+0, 1
	GOTO       L_main26
	NOP
	NOP
;Project.c,230 :: 		checker = Car_Forward_Fire();
	CALL       _Car_Forward_Fire+0
	MOVF       R0+0, 0
	MOVWF      _checker+0
	MOVF       R0+1, 0
	MOVWF      _checker+1
;Project.c,231 :: 		}
	GOTO       L_main27
L_main21:
;Project.c,235 :: 		else if ((Servo_F > 60 && Servo_F < 140) || Servo_B < 60)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _Servo_F+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main143
	MOVF       _Servo_F+0, 0
	SUBLW      60
L__main143:
	BTFSC      STATUS+0, 0
	GOTO       L__main129
	MOVLW      128
	XORWF      _Servo_F+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main144
	MOVLW      140
	SUBWF      _Servo_F+0, 0
L__main144:
	BTFSC      STATUS+0, 0
	GOTO       L__main129
	GOTO       L__main128
L__main129:
	MOVLW      128
	XORWF      _Servo_B+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main145
	MOVLW      60
	SUBWF      _Servo_B+0, 0
L__main145:
	BTFSS      STATUS+0, 0
	GOTO       L__main128
	GOTO       L_main32
L__main128:
;Project.c,237 :: 		i = 0;
	CLRF       _i+0
	CLRF       _i+1
;Project.c,238 :: 		while ((PORTB&0x80) == 0 && i != 50) // PORTB.F7 == 1
L_main33:
	MOVLW      128
	ANDWF      PORTB+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main34
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main146
	MOVLW      50
	XORWF      _i+0, 0
L__main146:
	BTFSC      STATUS+0, 2
	GOTO       L_main34
L__main127:
;Project.c,240 :: 		Rotate_Car_Left();
	CALL       _Rotate_Car_Left+0
;Project.c,241 :: 		i+=1;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Project.c,242 :: 		}
	GOTO       L_main33
L_main34:
;Project.c,243 :: 		Car_Stop();
	CALL       _Car_Stop+0
;Project.c,244 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main37:
	DECFSZ     R13+0, 1
	GOTO       L_main37
	DECFSZ     R12+0, 1
	GOTO       L_main37
	DECFSZ     R11+0, 1
	GOTO       L_main37
	NOP
	NOP
;Project.c,245 :: 		checker = Car_Forward_Fire();
	CALL       _Car_Forward_Fire+0
	MOVF       R0+0, 0
	MOVWF      _checker+0
	MOVF       R0+1, 0
	MOVWF      _checker+1
;Project.c,246 :: 		}
L_main32:
L_main27:
L_main16:
;Project.c,249 :: 		if (checker == 1)
	MOVLW      0
	XORWF      _checker+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main147
	MOVLW      1
	XORWF      _checker+0, 0
L__main147:
	BTFSS      STATUS+0, 2
	GOTO       L_main38
;Project.c,251 :: 		Alert = 1;
	MOVLW      1
	MOVWF      _Alert+0
;Project.c,252 :: 		Fire_Gone = 1;
	MOVLW      1
	MOVWF      _Fire_Gone+0
	MOVLW      0
	MOVWF      _Fire_Gone+1
;Project.c,253 :: 		break;
	GOTO       L_main7
;Project.c,254 :: 		}
L_main38:
;Project.c,258 :: 		for (i = 0; i < 1000; i++)
	CLRF       _i+0
	CLRF       _i+1
L_main39:
	MOVLW      3
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main148
	MOVLW      232
	SUBWF      _i+0, 0
L__main148:
	BTFSC      STATUS+0, 0
	GOTO       L_main40
;Project.c,260 :: 		obstacle = Car_Forward();
	CALL       _Car_Forward+0
	MOVF       R0+0, 0
	MOVWF      _obstacle+0
	MOVF       R0+1, 0
	MOVWF      _obstacle+1
;Project.c,261 :: 		if (obstacle == 1)
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main149
	MOVLW      1
	XORWF      R0+0, 0
L__main149:
	BTFSS      STATUS+0, 2
	GOTO       L_main42
;Project.c,263 :: 		Car_Stop();
	CALL       _Car_Stop+0
;Project.c,264 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main43:
	DECFSZ     R13+0, 1
	GOTO       L_main43
	DECFSZ     R12+0, 1
	GOTO       L_main43
	DECFSZ     R11+0, 1
	GOTO       L_main43
	NOP
	NOP
;Project.c,265 :: 		Turn_Car_Right();
	CALL       _Turn_Car_Right+0
;Project.c,266 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main44:
	DECFSZ     R13+0, 1
	GOTO       L_main44
	DECFSZ     R12+0, 1
	GOTO       L_main44
	DECFSZ     R11+0, 1
	GOTO       L_main44
	NOP
	NOP
;Project.c,267 :: 		break;
	GOTO       L_main40
;Project.c,268 :: 		}
L_main42:
;Project.c,269 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_main45:
	DECFSZ     R13+0, 1
	GOTO       L_main45
	DECFSZ     R12+0, 1
	GOTO       L_main45
	NOP
	NOP
;Project.c,258 :: 		for (i = 0; i < 1000; i++)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Project.c,270 :: 		}
	GOTO       L_main39
L_main40:
;Project.c,271 :: 		Car_Stop();
	CALL       _Car_Stop+0
;Project.c,272 :: 		}
	GOTO       L_main6
L_main7:
;Project.c,276 :: 		ATD_init();
	CALL       _ATD_init+0
;Project.c,277 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main46:
	DECFSZ     R13+0, 1
	GOTO       L_main46
	DECFSZ     R12+0, 1
	GOTO       L_main46
	DECFSZ     R11+0, 1
	GOTO       L_main46
	NOP
	NOP
;Project.c,278 :: 		desp1f = ATD_read(0); // Read Temp. Sensor
	CLRF       FARG_ATD_read_channel+0
	CALL       _ATD_read+0
	CALL       _word2double+0
	MOVF       R0+0, 0
	MOVWF      _desp1f+0
	MOVF       R0+1, 0
	MOVWF      _desp1f+1
	MOVF       R0+2, 0
	MOVWF      _desp1f+2
	MOVF       R0+3, 0
	MOVWF      _desp1f+3
;Project.c,279 :: 		volt = desp1f*4.88; // Convert into Voltage
	MOVLW      246
	MOVWF      R4+0
	MOVLW      40
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _volt+0
	MOVF       R0+1, 0
	MOVWF      _volt+1
	MOVF       R0+2, 0
	MOVWF      _volt+2
	MOVF       R0+3, 0
	MOVWF      _volt+3
;Project.c,280 :: 		tempe = volt/10; // Getting Temp. Values
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _tempe+0
	MOVF       R0+1, 0
	MOVWF      _tempe+1
	MOVF       R0+2, 0
	MOVWF      _tempe+2
	MOVF       R0+3, 0
	MOVWF      _tempe+3
;Project.c,281 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main47:
	DECFSZ     R13+0, 1
	GOTO       L_main47
	DECFSZ     R12+0, 1
	GOTO       L_main47
	DECFSZ     R11+0, 1
	GOTO       L_main47
	NOP
;Project.c,282 :: 		inttostr(tempe,desp1c); // Convert Float to Char for LCD
	MOVF       _tempe+0, 0
	MOVWF      R0+0
	MOVF       _tempe+1, 0
	MOVWF      R0+1
	MOVF       _tempe+2, 0
	MOVWF      R0+2
	MOVF       _tempe+3, 0
	MOVWF      R0+3
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _desp1c+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;Project.c,283 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main48:
	DECFSZ     R13+0, 1
	GOTO       L_main48
	DECFSZ     R12+0, 1
	GOTO       L_main48
	DECFSZ     R11+0, 1
	GOTO       L_main48
	NOP
	NOP
;Project.c,284 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Project.c,285 :: 		Lcd_Out(1, 1, "Room Temp");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Project.c,286 :: 		Lcd_Out(2, 1, desp1c);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _desp1c+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Project.c,288 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main49:
	DECFSZ     R13+0, 1
	GOTO       L_main49
	DECFSZ     R12+0, 1
	GOTO       L_main49
	DECFSZ     R11+0, 1
	GOTO       L_main49
	NOP
	NOP
;Project.c,289 :: 		if (tempe > 70) // Temp. Too Hot
	MOVF       _tempe+0, 0
	MOVWF      R4+0
	MOVF       _tempe+1, 0
	MOVWF      R4+1
	MOVF       _tempe+2, 0
	MOVWF      R4+2
	MOVF       _tempe+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      12
	MOVWF      R0+2
	MOVLW      133
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main50
;Project.c,291 :: 		Alert = 1;
	MOVLW      1
	MOVWF      _Alert+0
;Project.c,292 :: 		}
L_main50:
;Project.c,293 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_Car_Forward_Fire:

;Project.c,298 :: 		int Car_Forward_Fire()
;Project.c,300 :: 		while(distance_read() > 19)
L_Car_Forward_Fire51:
	CALL       _distance_read+0
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Car_Forward_Fire151
	MOVF       R0+0, 0
	SUBLW      19
L__Car_Forward_Fire151:
	BTFSC      STATUS+0, 0
	GOTO       L_Car_Forward_Fire52
;Project.c,302 :: 		Distance = Car_Forward();
	CALL       _Car_Forward+0
	MOVF       R0+0, 0
	MOVWF      _Distance+0
	MOVF       R0+1, 0
	MOVWF      _Distance+1
;Project.c,303 :: 		}
	GOTO       L_Car_Forward_Fire51
L_Car_Forward_Fire52:
;Project.c,304 :: 		Car_Stop();
	CALL       _Car_Stop+0
;Project.c,310 :: 		delay_ms(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_Car_Forward_Fire53:
	DECFSZ     R13+0, 1
	GOTO       L_Car_Forward_Fire53
	DECFSZ     R12+0, 1
	GOTO       L_Car_Forward_Fire53
	DECFSZ     R11+0, 1
	GOTO       L_Car_Forward_Fire53
	NOP
;Project.c,311 :: 		if (check_fire_front()) // PORTB.F7 == 1 PORTB&0x80
	CALL       _check_fire_front+0
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Car_Forward_Fire54
;Project.c,314 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Project.c,315 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_Car_Forward_Fire55:
	DECFSZ     R13+0, 1
	GOTO       L_Car_Forward_Fire55
	DECFSZ     R12+0, 1
	GOTO       L_Car_Forward_Fire55
	DECFSZ     R11+0, 1
	GOTO       L_Car_Forward_Fire55
	NOP
;Project.c,316 :: 		Lcd_Out(1, 1, "FIRE FIGHTER");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Project.c,317 :: 		Lcd_Out(2, 1, "Water ON");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Project.c,318 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_Car_Forward_Fire56:
	DECFSZ     R13+0, 1
	GOTO       L_Car_Forward_Fire56
	DECFSZ     R12+0, 1
	GOTO       L_Car_Forward_Fire56
	DECFSZ     R11+0, 1
	GOTO       L_Car_Forward_Fire56
	NOP
	NOP
;Project.c,319 :: 		Alert = 1;
	MOVLW      1
	MOVWF      _Alert+0
;Project.c,320 :: 		PORTD = PORTD|0x08; // PORTD.F3 = 1;
	BSF        PORTD+0, 3
;Project.c,321 :: 		delay_ms(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_Car_Forward_Fire57:
	DECFSZ     R13+0, 1
	GOTO       L_Car_Forward_Fire57
	DECFSZ     R12+0, 1
	GOTO       L_Car_Forward_Fire57
	DECFSZ     R11+0, 1
	GOTO       L_Car_Forward_Fire57
	NOP
;Project.c,322 :: 		PORTD = PORTD&0xF7; // PORTD.F3 = 0;
	MOVLW      247
	ANDWF      PORTD+0, 1
;Project.c,323 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Project.c,324 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_Car_Forward_Fire58:
	DECFSZ     R13+0, 1
	GOTO       L_Car_Forward_Fire58
	DECFSZ     R12+0, 1
	GOTO       L_Car_Forward_Fire58
	DECFSZ     R11+0, 1
	GOTO       L_Car_Forward_Fire58
	NOP
;Project.c,325 :: 		Lcd_Out(1, 1, "FIRE FIGHTER");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Project.c,326 :: 		Lcd_Out(2, 1, "Water OFF");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Project.c,327 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_Car_Forward_Fire59:
	DECFSZ     R13+0, 1
	GOTO       L_Car_Forward_Fire59
	DECFSZ     R12+0, 1
	GOTO       L_Car_Forward_Fire59
	DECFSZ     R11+0, 1
	GOTO       L_Car_Forward_Fire59
	NOP
	NOP
;Project.c,328 :: 		delay_ms(4000);
	MOVLW      41
	MOVWF      R11+0
	MOVLW      150
	MOVWF      R12+0
	MOVLW      127
	MOVWF      R13+0
L_Car_Forward_Fire60:
	DECFSZ     R13+0, 1
	GOTO       L_Car_Forward_Fire60
	DECFSZ     R12+0, 1
	GOTO       L_Car_Forward_Fire60
	DECFSZ     R11+0, 1
	GOTO       L_Car_Forward_Fire60
;Project.c,329 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	GOTO       L_end_Car_Forward_Fire
;Project.c,330 :: 		}
L_Car_Forward_Fire54:
;Project.c,331 :: 		}
L_end_Car_Forward_Fire:
	RETURN
; end of _Car_Forward_Fire

_Car_Forward:

;Project.c,336 :: 		int Car_Forward()
;Project.c,339 :: 		Distance = distance_read();
	CALL       _distance_read+0
	MOVF       R0+0, 0
	MOVWF      _Distance+0
	MOVF       R0+1, 0
	MOVWF      _Distance+1
;Project.c,340 :: 		if (Distance > 19)
	MOVF       R0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Car_Forward153
	MOVF       R0+0, 0
	SUBLW      19
L__Car_Forward153:
	BTFSC      STATUS+0, 0
	GOTO       L_Car_Forward61
;Project.c,342 :: 		CCPR1L = 70; // Left
	MOVLW      70
	MOVWF      CCPR1L+0
;Project.c,343 :: 		CCPR2L = 65; // Right
	MOVLW      65
	MOVWF      CCPR2L+0
;Project.c,344 :: 		delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_Car_Forward62:
	DECFSZ     R13+0, 1
	GOTO       L_Car_Forward62
	DECFSZ     R12+0, 1
	GOTO       L_Car_Forward62
	NOP
;Project.c,345 :: 		PORTD = PORTD|0x10; // PORTD.F4 = 1;
	BSF        PORTD+0, 4
;Project.c,346 :: 		PORTD = PORTD&0xDF; // PORTD.F5 = 0;
	MOVLW      223
	ANDWF      PORTD+0, 1
;Project.c,347 :: 		PORTD = PORTD|0x40; // PORTD.F6 = 1;
	BSF        PORTD+0, 6
;Project.c,348 :: 		PORTD = PORTD&0x7F; // PORTD.F7 = 0;
	MOVLW      127
	ANDWF      PORTD+0, 1
;Project.c,349 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
	GOTO       L_end_Car_Forward
;Project.c,350 :: 		}
L_Car_Forward61:
;Project.c,353 :: 		Car_Stop();
	CALL       _Car_Stop+0
;Project.c,354 :: 		Alert = 1;
	MOVLW      1
	MOVWF      _Alert+0
;Project.c,355 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
;Project.c,357 :: 		}
L_end_Car_Forward:
	RETURN
; end of _Car_Forward

_Turn_Car_Right:

;Project.c,360 :: 		void Turn_Car_Right()
;Project.c,362 :: 		CCPR1L = 75; // Left
	MOVLW      75
	MOVWF      CCPR1L+0
;Project.c,363 :: 		CCPR2L = 75; // Right
	MOVLW      75
	MOVWF      CCPR2L+0
;Project.c,364 :: 		delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_Turn_Car_Right64:
	DECFSZ     R13+0, 1
	GOTO       L_Turn_Car_Right64
	DECFSZ     R12+0, 1
	GOTO       L_Turn_Car_Right64
	NOP
;Project.c,365 :: 		PORTD = PORTD&0xEF; // PORTD.F4 = 0;
	MOVLW      239
	ANDWF      PORTD+0, 1
;Project.c,366 :: 		PORTD = PORTD|0x20; // PORTD.F5 = 1;
	BSF        PORTD+0, 5
;Project.c,367 :: 		PORTD = PORTD|0x40; // PORTD.F6 = 1;
	BSF        PORTD+0, 6
;Project.c,368 :: 		PORTD = PORTD&0x7F; // PORTD.F7 = 0;
	MOVLW      127
	ANDWF      PORTD+0, 1
;Project.c,369 :: 		delay_ms(800);
	MOVLW      9
	MOVWF      R11+0
	MOVLW      30
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_Turn_Car_Right65:
	DECFSZ     R13+0, 1
	GOTO       L_Turn_Car_Right65
	DECFSZ     R12+0, 1
	GOTO       L_Turn_Car_Right65
	DECFSZ     R11+0, 1
	GOTO       L_Turn_Car_Right65
	NOP
;Project.c,370 :: 		Car_Stop();
	CALL       _Car_Stop+0
;Project.c,371 :: 		}
L_end_Turn_Car_Right:
	RETURN
; end of _Turn_Car_Right

_Turn_Car_Left:

;Project.c,374 :: 		void Turn_Car_Left()
;Project.c,376 :: 		CCPR1L = 75; // Left
	MOVLW      75
	MOVWF      CCPR1L+0
;Project.c,377 :: 		CCPR2L = 75; // Right
	MOVLW      75
	MOVWF      CCPR2L+0
;Project.c,378 :: 		delay_ms(2);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_Turn_Car_Left66:
	DECFSZ     R13+0, 1
	GOTO       L_Turn_Car_Left66
	DECFSZ     R12+0, 1
	GOTO       L_Turn_Car_Left66
	NOP
;Project.c,379 :: 		PORTD = PORTD|0x10; // PORTD.F4 = 1;
	BSF        PORTD+0, 4
;Project.c,380 :: 		PORTD = PORTD&0xDF; // PORTD.F5 = 0;
	MOVLW      223
	ANDWF      PORTD+0, 1
;Project.c,381 :: 		PORTD = PORTD&0xBF; // PORTD.F6 = 0;
	MOVLW      191
	ANDWF      PORTD+0, 1
;Project.c,382 :: 		PORTD = PORTD|0x80; // PORTD.F7 = 1;
	BSF        PORTD+0, 7
;Project.c,383 :: 		delay_ms(800);
	MOVLW      9
	MOVWF      R11+0
	MOVLW      30
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_Turn_Car_Left67:
	DECFSZ     R13+0, 1
	GOTO       L_Turn_Car_Left67
	DECFSZ     R12+0, 1
	GOTO       L_Turn_Car_Left67
	DECFSZ     R11+0, 1
	GOTO       L_Turn_Car_Left67
	NOP
;Project.c,384 :: 		Car_Stop();
	CALL       _Car_Stop+0
;Project.c,385 :: 		}
L_end_Turn_Car_Left:
	RETURN
; end of _Turn_Car_Left

_Rotate_Car_Right:

;Project.c,388 :: 		void Rotate_Car_Right()
;Project.c,390 :: 		CCPR1L = 75; // Left
	MOVLW      75
	MOVWF      CCPR1L+0
;Project.c,391 :: 		CCPR2L = 75; // Right
	MOVLW      75
	MOVWF      CCPR2L+0
;Project.c,392 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_Rotate_Car_Right68:
	DECFSZ     R13+0, 1
	GOTO       L_Rotate_Car_Right68
	DECFSZ     R12+0, 1
	GOTO       L_Rotate_Car_Right68
	DECFSZ     R11+0, 1
	GOTO       L_Rotate_Car_Right68
	NOP
;Project.c,393 :: 		PORTD = PORTD&0xEF; // PORTD.F4 = 0;
	MOVLW      239
	ANDWF      PORTD+0, 1
;Project.c,394 :: 		PORTD = PORTD|0x20; // PORTD.F5 = 1;
	BSF        PORTD+0, 5
;Project.c,395 :: 		PORTD = PORTD|0x40; // PORTD.F6 = 1;
	BSF        PORTD+0, 6
;Project.c,396 :: 		PORTD = PORTD&0x7F; // PORTD.F7 = 0;
	MOVLW      127
	ANDWF      PORTD+0, 1
;Project.c,397 :: 		delay_ms(150); // 150 ms delay
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_Rotate_Car_Right69:
	DECFSZ     R13+0, 1
	GOTO       L_Rotate_Car_Right69
	DECFSZ     R12+0, 1
	GOTO       L_Rotate_Car_Right69
	DECFSZ     R11+0, 1
	GOTO       L_Rotate_Car_Right69
;Project.c,398 :: 		Car_Stop();
	CALL       _Car_Stop+0
;Project.c,399 :: 		delay_ms(500); // 500 ms delay
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_Rotate_Car_Right70:
	DECFSZ     R13+0, 1
	GOTO       L_Rotate_Car_Right70
	DECFSZ     R12+0, 1
	GOTO       L_Rotate_Car_Right70
	DECFSZ     R11+0, 1
	GOTO       L_Rotate_Car_Right70
	NOP
	NOP
;Project.c,400 :: 		}
L_end_Rotate_Car_Right:
	RETURN
; end of _Rotate_Car_Right

_Rotate_Car_Left:

;Project.c,403 :: 		void Rotate_Car_Left()
;Project.c,405 :: 		CCPR1L = 75; // Left
	MOVLW      75
	MOVWF      CCPR1L+0
;Project.c,406 :: 		CCPR2L = 75; // Right
	MOVLW      75
	MOVWF      CCPR2L+0
;Project.c,407 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_Rotate_Car_Left71:
	DECFSZ     R13+0, 1
	GOTO       L_Rotate_Car_Left71
	DECFSZ     R12+0, 1
	GOTO       L_Rotate_Car_Left71
	DECFSZ     R11+0, 1
	GOTO       L_Rotate_Car_Left71
	NOP
;Project.c,408 :: 		PORTD = PORTD|0x10; // PORTD.F4 = 1;
	BSF        PORTD+0, 4
;Project.c,409 :: 		PORTD = PORTD&0xDF; // PORTD.F5 = 0;
	MOVLW      223
	ANDWF      PORTD+0, 1
;Project.c,410 :: 		PORTD = PORTD&0xBF; // PORTD.F6 = 0;
	MOVLW      191
	ANDWF      PORTD+0, 1
;Project.c,411 :: 		PORTD = PORTD|0x80; // PORTD.F7 = 1;
	BSF        PORTD+0, 7
;Project.c,412 :: 		delay_ms(150); // 150 ms delay
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_Rotate_Car_Left72:
	DECFSZ     R13+0, 1
	GOTO       L_Rotate_Car_Left72
	DECFSZ     R12+0, 1
	GOTO       L_Rotate_Car_Left72
	DECFSZ     R11+0, 1
	GOTO       L_Rotate_Car_Left72
;Project.c,413 :: 		Car_Stop();
	CALL       _Car_Stop+0
;Project.c,414 :: 		delay_ms(500); // 500 ms delay
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_Rotate_Car_Left73:
	DECFSZ     R13+0, 1
	GOTO       L_Rotate_Car_Left73
	DECFSZ     R12+0, 1
	GOTO       L_Rotate_Car_Left73
	DECFSZ     R11+0, 1
	GOTO       L_Rotate_Car_Left73
	NOP
	NOP
;Project.c,415 :: 		}
L_end_Rotate_Car_Left:
	RETURN
; end of _Rotate_Car_Left

_Car_Stop:

;Project.c,418 :: 		void Car_Stop()
;Project.c,420 :: 		CCPR1L = 0; // Left
	CLRF       CCPR1L+0
;Project.c,421 :: 		CCPR2L = 0; // Right
	CLRF       CCPR2L+0
;Project.c,422 :: 		PORTD = PORTD&0xEF; // PORTD.F4 = 0;
	MOVLW      239
	ANDWF      PORTD+0, 1
;Project.c,423 :: 		PORTD = PORTD&0xDF; // PORTD.F5 = 0;
	MOVLW      223
	ANDWF      PORTD+0, 1
;Project.c,424 :: 		PORTD = PORTD&0xBF; // PORTD.F6 = 0;
	MOVLW      191
	ANDWF      PORTD+0, 1
;Project.c,425 :: 		PORTD = PORTD&0x7F; // PORTD.F7 = 0;
	MOVLW      127
	ANDWF      PORTD+0, 1
;Project.c,426 :: 		}
L_end_Car_Stop:
	RETURN
; end of _Car_Stop

_check_fire_front:

;Project.c,429 :: 		int check_fire_front()
;Project.c,432 :: 		int Fire = 0;
	CLRF       check_fire_front_Fire_L0+0
	CLRF       check_fire_front_Fire_L0+1
	CLRF       check_fire_front_servo_angle_L0+0
	CLRF       check_fire_front_servo_angle_L0+1
;Project.c,434 :: 		while (Fire == 0)
	MOVLW      0
	XORWF      check_fire_front_Fire_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_fire_front160
	MOVLW      0
	XORWF      check_fire_front_Fire_L0+0, 0
L__check_fire_front160:
	BTFSS      STATUS+0, 2
	GOTO       L_check_fire_front75
;Project.c,436 :: 		for (servo_angle = 0; servo_angle < 140; servo_angle += 10)
	CLRF       check_fire_front_servo_angle_L0+0
	CLRF       check_fire_front_servo_angle_L0+1
L_check_fire_front76:
	MOVLW      128
	XORWF      check_fire_front_servo_angle_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_fire_front161
	MOVLW      140
	SUBWF      check_fire_front_servo_angle_L0+0, 0
L__check_fire_front161:
	BTFSC      STATUS+0, 0
	GOTO       L_check_fire_front77
;Project.c,438 :: 		for (i = 0; i < 50; i++) // Loop to provide continuous train of pulse
	CLRF       _i+0
	CLRF       _i+1
L_check_fire_front79:
	MOVLW      0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_fire_front162
	MOVLW      50
	SUBWF      _i+0, 0
L__check_fire_front162:
	BTFSC      STATUS+0, 0
	GOTO       L_check_fire_front80
;Project.c,440 :: 		PORTC = PORTC|0x08; // PORTC.F3 = 1;
	BSF        PORTC+0, 3
;Project.c,441 :: 		cs_delay(servo_angle); // Servo Angle
	MOVF       check_fire_front_servo_angle_L0+0, 0
	MOVWF      FARG_cs_delay+0
	MOVF       check_fire_front_servo_angle_L0+1, 0
	MOVWF      FARG_cs_delay+1
	CALL       _cs_delay+0
;Project.c,442 :: 		PORTC = PORTC&0xF7; // PORTC.F3 = 0;
	MOVLW      247
	ANDWF      PORTC+0, 1
;Project.c,443 :: 		delay_ms(10); // Speed of Servo
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_check_fire_front82:
	DECFSZ     R13+0, 1
	GOTO       L_check_fire_front82
	DECFSZ     R12+0, 1
	GOTO       L_check_fire_front82
	NOP
;Project.c,438 :: 		for (i = 0; i < 50; i++) // Loop to provide continuous train of pulse
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Project.c,444 :: 		}
	GOTO       L_check_fire_front79
L_check_fire_front80:
;Project.c,448 :: 		if (PORTB&0x80) // PORTB.F7 == 1
	BTFSS      PORTB+0, 7
	GOTO       L_check_fire_front83
;Project.c,450 :: 		Alert = 1; // Alert
	MOVLW      1
	MOVWF      _Alert+0
;Project.c,451 :: 		Fire = 1; //  Fire Detected
	MOVLW      1
	MOVWF      check_fire_front_Fire_L0+0
	MOVLW      0
	MOVWF      check_fire_front_Fire_L0+1
;Project.c,452 :: 		break;
	GOTO       L_check_fire_front77
;Project.c,453 :: 		}
L_check_fire_front83:
;Project.c,436 :: 		for (servo_angle = 0; servo_angle < 140; servo_angle += 10)
	MOVLW      10
	ADDWF      check_fire_front_servo_angle_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       check_fire_front_servo_angle_L0+1, 1
;Project.c,454 :: 		}
	GOTO       L_check_fire_front76
L_check_fire_front77:
;Project.c,456 :: 		}
L_check_fire_front75:
;Project.c,457 :: 		if (Fire == 1)
	MOVLW      0
	XORWF      check_fire_front_Fire_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_fire_front163
	MOVLW      1
	XORWF      check_fire_front_Fire_L0+0, 0
L__check_fire_front163:
	BTFSS      STATUS+0, 2
	GOTO       L_check_fire_front84
;Project.c,459 :: 		return servo_angle;
	MOVF       check_fire_front_servo_angle_L0+0, 0
	MOVWF      R0+0
	MOVF       check_fire_front_servo_angle_L0+1, 0
	MOVWF      R0+1
	GOTO       L_end_check_fire_front
;Project.c,460 :: 		}
L_check_fire_front84:
;Project.c,463 :: 		return 404;
	MOVLW      148
	MOVWF      R0+0
	MOVLW      1
	MOVWF      R0+1
;Project.c,465 :: 		}
L_end_check_fire_front:
	RETURN
; end of _check_fire_front

_check_fire_back:

;Project.c,468 :: 		int check_fire_back()
;Project.c,471 :: 		int Fire = 0;
	CLRF       check_fire_back_Fire_L0+0
	CLRF       check_fire_back_Fire_L0+1
	CLRF       check_fire_back_servo_angle_L0+0
	CLRF       check_fire_back_servo_angle_L0+1
;Project.c,473 :: 		while (Fire == 0)
	MOVLW      0
	XORWF      check_fire_back_Fire_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_fire_back165
	MOVLW      0
	XORWF      check_fire_back_Fire_L0+0, 0
L__check_fire_back165:
	BTFSS      STATUS+0, 2
	GOTO       L_check_fire_back87
;Project.c,475 :: 		for (servo_angle = 0; servo_angle < 140; servo_angle += 10)
	CLRF       check_fire_back_servo_angle_L0+0
	CLRF       check_fire_back_servo_angle_L0+1
L_check_fire_back88:
	MOVLW      128
	XORWF      check_fire_back_servo_angle_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_fire_back166
	MOVLW      140
	SUBWF      check_fire_back_servo_angle_L0+0, 0
L__check_fire_back166:
	BTFSC      STATUS+0, 0
	GOTO       L_check_fire_back89
;Project.c,477 :: 		for (i = 0; i < 50; i++) // Loop to provide continuous train of pulse
	CLRF       _i+0
	CLRF       _i+1
L_check_fire_back91:
	MOVLW      0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_fire_back167
	MOVLW      50
	SUBWF      _i+0, 0
L__check_fire_back167:
	BTFSC      STATUS+0, 0
	GOTO       L_check_fire_back92
;Project.c,479 :: 		PORTC = PORTC|0x10; // PORTC.F4 = 1;
	BSF        PORTC+0, 4
;Project.c,480 :: 		cs_delay(servo_angle); // Servo Angle
	MOVF       check_fire_back_servo_angle_L0+0, 0
	MOVWF      FARG_cs_delay+0
	MOVF       check_fire_back_servo_angle_L0+1, 0
	MOVWF      FARG_cs_delay+1
	CALL       _cs_delay+0
;Project.c,481 :: 		PORTC = PORTC&0xEF; // PORTC.F4 = 0;
	MOVLW      239
	ANDWF      PORTC+0, 1
;Project.c,482 :: 		delay_ms(10); // Speed of Servo
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_check_fire_back94:
	DECFSZ     R13+0, 1
	GOTO       L_check_fire_back94
	DECFSZ     R12+0, 1
	GOTO       L_check_fire_back94
	NOP
;Project.c,477 :: 		for (i = 0; i < 50; i++) // Loop to provide continuous train of pulse
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Project.c,483 :: 		}
	GOTO       L_check_fire_back91
L_check_fire_back92:
;Project.c,487 :: 		if (PORTD&0x01) // PORTD.F0 == 1
	BTFSS      PORTD+0, 0
	GOTO       L_check_fire_back95
;Project.c,489 :: 		Alert = 1;
	MOVLW      1
	MOVWF      _Alert+0
;Project.c,490 :: 		Fire = 1;
	MOVLW      1
	MOVWF      check_fire_back_Fire_L0+0
	MOVLW      0
	MOVWF      check_fire_back_Fire_L0+1
;Project.c,491 :: 		break;
	GOTO       L_check_fire_back89
;Project.c,492 :: 		}
L_check_fire_back95:
;Project.c,475 :: 		for (servo_angle = 0; servo_angle < 140; servo_angle += 10)
	MOVLW      10
	ADDWF      check_fire_back_servo_angle_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       check_fire_back_servo_angle_L0+1, 1
;Project.c,493 :: 		}
	GOTO       L_check_fire_back88
L_check_fire_back89:
;Project.c,495 :: 		}
L_check_fire_back87:
;Project.c,496 :: 		if (Fire == 1)
	MOVLW      0
	XORWF      check_fire_back_Fire_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_fire_back168
	MOVLW      1
	XORWF      check_fire_back_Fire_L0+0, 0
L__check_fire_back168:
	BTFSS      STATUS+0, 2
	GOTO       L_check_fire_back96
;Project.c,498 :: 		return servo_angle;
	MOVF       check_fire_back_servo_angle_L0+0, 0
	MOVWF      R0+0
	MOVF       check_fire_back_servo_angle_L0+1, 0
	MOVWF      R0+1
	GOTO       L_end_check_fire_back
;Project.c,499 :: 		}
L_check_fire_back96:
;Project.c,502 :: 		return 404;
	MOVLW      148
	MOVWF      R0+0
	MOVLW      1
	MOVWF      R0+1
;Project.c,504 :: 		}
L_end_check_fire_back:
	RETURN
; end of _check_fire_back

_Rotation60_F:

;Project.c,507 :: 		void Rotation60_F()
;Project.c,509 :: 		for (i = 0; i < 50; i++) // Loop to provide continuous train of pulse
	CLRF       _i+0
	CLRF       _i+1
L_Rotation60_F98:
	MOVLW      0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Rotation60_F170
	MOVLW      50
	SUBWF      _i+0, 0
L__Rotation60_F170:
	BTFSC      STATUS+0, 0
	GOTO       L_Rotation60_F99
;Project.c,511 :: 		PORTC = PORTC|0x08; // PORTC.F3 = 1 // Send high to control signal terninal
	BSF        PORTC+0, 3
;Project.c,512 :: 		cs_delay(60); // Call delay function
	MOVLW      60
	MOVWF      FARG_cs_delay+0
	MOVLW      0
	MOVWF      FARG_cs_delay+1
	CALL       _cs_delay+0
;Project.c,513 :: 		PORTC = PORTC&0xF7; // PORTC.F3 = 0; // Send low to control signal terninal
	MOVLW      247
	ANDWF      PORTC+0, 1
;Project.c,514 :: 		delay_ms(18);
	MOVLW      47
	MOVWF      R12+0
	MOVLW      191
	MOVWF      R13+0
L_Rotation60_F101:
	DECFSZ     R13+0, 1
	GOTO       L_Rotation60_F101
	DECFSZ     R12+0, 1
	GOTO       L_Rotation60_F101
	NOP
	NOP
;Project.c,509 :: 		for (i = 0; i < 50; i++) // Loop to provide continuous train of pulse
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Project.c,515 :: 		}
	GOTO       L_Rotation60_F98
L_Rotation60_F99:
;Project.c,516 :: 		}
L_end_Rotation60_F:
	RETURN
; end of _Rotation60_F

_Rotation60_B:

;Project.c,519 :: 		void Rotation60_B()
;Project.c,521 :: 		for (i = 0; i < 50; i++) // Loop to provide continuous train of pulse
	CLRF       _i+0
	CLRF       _i+1
L_Rotation60_B102:
	MOVLW      0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Rotation60_B172
	MOVLW      50
	SUBWF      _i+0, 0
L__Rotation60_B172:
	BTFSC      STATUS+0, 0
	GOTO       L_Rotation60_B103
;Project.c,523 :: 		PORTC = PORTC|0x10; // PORTC.F4 = 1; // Send high to control signal terninal
	BSF        PORTC+0, 4
;Project.c,524 :: 		cs_delay(60); // Call delay function
	MOVLW      60
	MOVWF      FARG_cs_delay+0
	MOVLW      0
	MOVWF      FARG_cs_delay+1
	CALL       _cs_delay+0
;Project.c,525 :: 		PORTC = PORTC&0xEF; // PORTC.F4 = 0; // Send low to control signal terninal
	MOVLW      239
	ANDWF      PORTC+0, 1
;Project.c,526 :: 		delay_ms(18);
	MOVLW      47
	MOVWF      R12+0
	MOVLW      191
	MOVWF      R13+0
L_Rotation60_B105:
	DECFSZ     R13+0, 1
	GOTO       L_Rotation60_B105
	DECFSZ     R12+0, 1
	GOTO       L_Rotation60_B105
	NOP
	NOP
;Project.c,521 :: 		for (i = 0; i < 50; i++) // Loop to provide continuous train of pulse
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Project.c,527 :: 		}
	GOTO       L_Rotation60_B102
L_Rotation60_B103:
;Project.c,528 :: 		}
L_end_Rotation60_B:
	RETURN
; end of _Rotation60_B

_delay_ms:

;Project.c,531 :: 		void delay_ms(unsigned int msCnt)
;Project.c,533 :: 		ms = 0;
	CLRF       _ms+0
	CLRF       _ms+1
;Project.c,534 :: 		cc = 0;
	CLRF       _cc+0
	CLRF       _cc+1
;Project.c,535 :: 		for (ms = 0; ms < (msCnt); ms++)
	CLRF       _ms+0
	CLRF       _ms+1
L_delay_ms106:
	MOVF       FARG_delay_ms_msCnt+1, 0
	SUBWF      _ms+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delay_ms174
	MOVF       FARG_delay_ms_msCnt+0, 0
	SUBWF      _ms+0, 0
L__delay_ms174:
	BTFSC      STATUS+0, 0
	GOTO       L_delay_ms107
;Project.c,537 :: 		for (cc = 0; cc < 155; cc++); // 1ms
	CLRF       _cc+0
	CLRF       _cc+1
L_delay_ms109:
	MOVLW      0
	SUBWF      _cc+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delay_ms175
	MOVLW      155
	SUBWF      _cc+0, 0
L__delay_ms175:
	BTFSC      STATUS+0, 0
	GOTO       L_delay_ms110
	INCF       _cc+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cc+1, 1
	GOTO       L_delay_ms109
L_delay_ms110:
;Project.c,535 :: 		for (ms = 0; ms < (msCnt); ms++)
	INCF       _ms+0, 1
	BTFSC      STATUS+0, 2
	INCF       _ms+1, 1
;Project.c,538 :: 		}
	GOTO       L_delay_ms106
L_delay_ms107:
;Project.c,539 :: 		}
L_end_delay_ms:
	RETURN
; end of _delay_ms

_delay_us:

;Project.c,542 :: 		void delay_us(unsigned int usCnt)
;Project.c,544 :: 		us = 0;
	CLRF       _us+0
	CLRF       _us+1
;Project.c,546 :: 		for (us = 0; us < usCnt; us++)
	CLRF       _us+0
	CLRF       _us+1
L_delay_us112:
	MOVF       FARG_delay_us_usCnt+1, 0
	SUBWF      _us+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delay_us177
	MOVF       FARG_delay_us_usCnt+0, 0
	SUBWF      _us+0, 0
L__delay_us177:
	BTFSC      STATUS+0, 0
	GOTO       L_delay_us113
;Project.c,548 :: 		asm NOP; // 0.5 uS
	NOP
;Project.c,549 :: 		asm NOP; // 0.5uS
	NOP
;Project.c,546 :: 		for (us = 0; us < usCnt; us++)
	INCF       _us+0, 1
	BTFSC      STATUS+0, 2
	INCF       _us+1, 1
;Project.c,550 :: 		}
	GOTO       L_delay_us112
L_delay_us113:
;Project.c,551 :: 		}
L_end_delay_us:
	RETURN
; end of _delay_us

_cs_delay:

;Project.c,554 :: 		void cs_delay(unsigned int count)
;Project.c,556 :: 		int j = 0;
	CLRF       cs_delay_j_L0+0
	CLRF       cs_delay_j_L0+1
;Project.c,557 :: 		delay_us(550);              // Delay to move the servo at 0�
	MOVLW      2
	MOVWF      R12+0
	MOVLW      108
	MOVWF      R13+0
L_cs_delay115:
	DECFSZ     R13+0, 1
	GOTO       L_cs_delay115
	DECFSZ     R12+0, 1
	GOTO       L_cs_delay115
	NOP
;Project.c,558 :: 		for (j = 0; j < count; j++) // Repeat the loop equal to as much as angle
	CLRF       cs_delay_j_L0+0
	CLRF       cs_delay_j_L0+1
L_cs_delay116:
	MOVF       FARG_cs_delay_count+1, 0
	SUBWF      cs_delay_j_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__cs_delay179
	MOVF       FARG_cs_delay_count+0, 0
	SUBWF      cs_delay_j_L0+0, 0
L__cs_delay179:
	BTFSC      STATUS+0, 0
	GOTO       L_cs_delay117
;Project.c,560 :: 		delay_us(6); // Delay to displace servo by 1�
	MOVLW      3
	MOVWF      R13+0
L_cs_delay119:
	DECFSZ     R13+0, 1
	GOTO       L_cs_delay119
	NOP
	NOP
;Project.c,558 :: 		for (j = 0; j < count; j++) // Repeat the loop equal to as much as angle
	INCF       cs_delay_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       cs_delay_j_L0+1, 1
;Project.c,561 :: 		}
	GOTO       L_cs_delay116
L_cs_delay117:
;Project.c,562 :: 		}
L_end_cs_delay:
	RETURN
; end of _cs_delay

_distance_read:

;Project.c,566 :: 		int distance_read()
;Project.c,568 :: 		TMR1H = 0; // Sets the Initial Value of Timer
	CLRF       TMR1H+0
;Project.c,569 :: 		TMR1L = 0; // Sets the Initial Value of Timer
	CLRF       TMR1L+0
;Project.c,571 :: 		PORTC = PORTC|0x40; // PORTC.F6 = 1; // TRIGGER HIGH
	BSF        PORTC+0, 6
;Project.c,572 :: 		delay_us(10); // 10uS Delay
	MOVLW      6
	MOVWF      R13+0
L_distance_read120:
	DECFSZ     R13+0, 1
	GOTO       L_distance_read120
	NOP
;Project.c,573 :: 		PORTC = PORTC&0xBF; // PORTC.F6 = 0; // TRIGGER LOW
	MOVLW      191
	ANDWF      PORTC+0, 1
;Project.c,575 :: 		while (!(PORTC&0x20));  // PORTC.F5// Waiting for Echo
L_distance_read121:
	BTFSC      PORTC+0, 5
	GOTO       L_distance_read122
	GOTO       L_distance_read121
L_distance_read122:
;Project.c,576 :: 		T1CON.F0 = 1; // Timer Starts
	BSF        T1CON+0, 0
;Project.c,577 :: 		while (PORTC&0x20);   // PORTC.F5 // Waiting for Echo goes LOW
L_distance_read123:
	BTFSS      PORTC+0, 5
	GOTO       L_distance_read124
	GOTO       L_distance_read123
L_distance_read124:
;Project.c,578 :: 		T1CON.F0 = 0; // Timer Stops
	BCF        T1CON+0, 0
;Project.c,580 :: 		a = (TMR1L | (TMR1H << 8)); // Reads Timer Value
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _a+0
	MOVF       R0+1, 0
	MOVWF      _a+1
;Project.c,581 :: 		a = a / 58.82;              // Converts Time to Distance
	CALL       _word2double+0
	MOVLW      174
	MOVWF      R4+0
	MOVLW      71
	MOVWF      R4+1
	MOVLW      107
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      _a+0
	MOVF       R0+1, 0
	MOVWF      _a+1
;Project.c,582 :: 		a = a + 1;                  // Distance Calibration
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _a+0
	MOVF       R0+1, 0
	MOVWF      _a+1
;Project.c,583 :: 		return a;
;Project.c,584 :: 		}
L_end_distance_read:
	RETURN
; end of _distance_read

_ATD_init:

;Project.c,587 :: 		void ATD_init(void)
;Project.c,589 :: 		ADCON0 = 0b01000001; // ON, Channel 0, Fosc/16== 500KHz, Dont Go
	MOVLW      65
	MOVWF      ADCON0+0
;Project.c,590 :: 		ADCON1 = 0b11000000; // All Analog
	MOVLW      192
	MOVWF      ADCON1+0
;Project.c,591 :: 		}
L_end_ATD_init:
	RETURN
; end of _ATD_init

_ATD_read:

;Project.c,593 :: 		unsigned int ATD_read(unsigned char channel)
;Project.c,596 :: 		ADCON0 = (ADCON0 & 0b11000111) | (channel << 3);
	MOVLW      199
	ANDWF      ADCON0+0, 0
	MOVWF      R2+0
	MOVF       FARG_ATD_read_channel+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	IORWF      R2+0, 0
	MOVWF      ADCON0+0
;Project.c,597 :: 		ADCON0 = ADCON0 | 0x04; // GO
	BSF        ADCON0+0, 2
;Project.c,598 :: 		while (ADCON0 & 0x04); // wait until DONE
L_ATD_read125:
	BTFSS      ADCON0+0, 2
	GOTO       L_ATD_read126
	GOTO       L_ATD_read125
L_ATD_read126:
;Project.c,599 :: 		return (ADRESH << 8) | ADRESL;
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;Project.c,600 :: 		}
L_end_ATD_read:
	RETURN
; end of _ATD_read
