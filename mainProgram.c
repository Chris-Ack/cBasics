// Note: This program needs to be compiled with the following command:
// gcc mainProgram.c -o mainProgram -lwiringPi -lwiringPiDev
//

// #include         // used to include header files (marked by .h ending)
#include <stdio.h>  // Stands for "Standard Input Output", holds info for input/output functions
#include <stdlib.h> // Stands for "Standard Library", holds info for memory allocation/freeing
#include <string.h>
#include <wiringPi.h>
#include <wiringPiI2C.h>
#include <pcf8574.h>
#include <lcd.h>
#include <time.h>

// the same could be achieved without a header file by initializing printf directly // int printf(const char *text, ...);

//////////////////////////////////// BLINK CODE///////////////////////////////////////////////
#define  ledPin    3	//define the led pin number


void blink(void)
{	
	printf("Program is starting ... \n");
		
	pinMode(ledPin, OUTPUT);//Set the pin mode
	printf("Using pin%d\n",ledPin);	//Output information on terminal
	while(1){
		digitalWrite(ledPin, HIGH);  //Make GPIO output HIGH level
		printf("led turned on >>>\n");		//Output information on terminal
		delay(1000);						//Wait for 1 second
		digitalWrite(ledPin, LOW);  //Make GPIO output LOW level
		printf("led turned off <<<\n");		//Output information on terminal
		delay(1000);						//Wait for 1 second
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////// LCD  CODE///////////////////////////////////////////////
int pcf8574_address = 0x27;        // PCF8574T:0x27, PCF8574AT:0x3F
#define BASE 64         // BASE any number above 64
//Define the output pins of the PCF8574, which are directly connected to the LCD1602 pin.
#define RS      BASE+0
#define RW      BASE+1
#define EN      BASE+2
#define LED     BASE+3
#define D4      BASE+4
#define D5      BASE+5
#define D6      BASE+6
#define D7      BASE+7

int lcdhd;// used to handle LCD
void printCPUTemperature(){// sub function used to print CPU temperature
    FILE *fp;
    char str_temp[15];
    float CPU_temp;
    // CPU temperature data is stored in this directory.
    fp=fopen("/sys/class/thermal/thermal_zone0/temp","r");
    fgets(str_temp,15,fp);      // read file temp
    CPU_temp = atof(str_temp)/1000.0;   // convert to Celsius degrees
    printf("CPU's temperature : %.2f \n",CPU_temp);
    lcdPosition(lcdhd,0,0);     // set the LCD cursor position to (0,0) 
    lcdPrintf(lcdhd,"CPU:%.2fC",CPU_temp);// Display CPU temperature on LCD
    fclose(fp);
}
void printDataTime(){//used to print system time 
    time_t rawtime;
    struct tm *timeinfo;
    time(&rawtime);// get system time
    timeinfo = localtime(&rawtime);//convert to local time
    printf("%s \n",asctime(timeinfo));
    lcdPosition(lcdhd,0,1);// set the LCD cursor position to (0,1) 
    lcdPrintf(lcdhd,"Time:%02d:%02d:%02d",timeinfo->tm_hour,timeinfo->tm_min,timeinfo->tm_sec); //Display system time on LCD
}
int detectI2C(int addr){
    int _fd = wiringPiI2CSetup (addr);   
    if (_fd < 0){		
        printf("Error address : 0x%x \n",addr);
        return 0 ;
    } 
    else{	
        if(wiringPiI2CWrite(_fd,0) < 0){
            printf("Not found device in address 0x%x \n",addr);
            return 0;
        }
        else{
            printf("Found device in address 0x%x \n",addr);
            return 1 ;
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////

int mainMenu() {
    printf("\nHallo Welt!\n");
    printf("We're gonna scribe the shit out of this week.\n");
    printf("\n");
    int number;
    printf("Please enter the number for the command you want to execute. \n");
    printf("\n");
    printf("1.: Turn LED on \n");
    printf("2.: Turn LED off \n");
    printf("3.: Write LCD Line 1 \n");
    printf("4.: Write LCD Line 2 \n");
    printf("5.: Clear Display \n");
    printf("6.: Write CPU Temperature and Time \n");
    printf("0.: Exit Program \n");
    printf("\n");
    scanf("%d", &number);

    if (number == 1) {
        digitalWrite(ledPin, HIGH);
        printf("LED turned on \n");
        mainMenu();
        }
    else if (number == 2) {
        digitalWrite(ledPin, LOW);
        printf("LED turned off \n");
        mainMenu();
    }
    else if (number == 3) {
        getchar();
        char lineOne[16];
        printf("Please enter up to 16 letters: \n");
        fgets(lineOne, 16, stdin);
        lineOne[strlen(lineOne)-1]='\0';
        lcdPosition(lcdhd,0,0);
        lcdPrintf(lcdhd,"%s",lineOne);
        printf("Line One was set to: %s.", lineOne);
        mainMenu();
    }
    else if (number == 4) {
        getchar();
        char lineTwo[16];
        printf("Please enter up to 16 letters: \n");
        fgets(lineTwo, 16, stdin);
        lineTwo[strlen(lineTwo)-1]='\0';
        lcdPosition(lcdhd,0,1);
        lcdPrintf(lcdhd,"%s",lineTwo);
        printf("Line Two was set to: %s.", lineTwo);
        mainMenu();
    }
    else if (number == 5) {
        lcdPosition(lcdhd,0,0);
        lcdPrintf(lcdhd,"                ");
        lcdPosition(lcdhd,0,1);
        lcdPrintf(lcdhd,"                ");
        printf("Display cleared \n");
        mainMenu();
    }
    else if (number == 6) {
        printCPUTemperature();
        printDataTime();
        printf("CPU Temp and Time written to LCD.");
        mainMenu();
    }
    else if (number == 0) {
        return 0;
    }
}


int main()
{
    wiringPiSetup();	//Initialize wiringPi.
    int i;
    printf("Program is starting ...\n");

    if(detectI2C(0x27)){
        pcf8574_address = 0x27;
    }else if(detectI2C(0x3F)){
        pcf8574_address = 0x3F;
    }else{
        printf("No correct I2C address found, \n"
        "Please use command 'i2cdetect -y 1' to check the I2C address! \n"
        "Program Exit. \n");
        return -1;
    }
    pcf8574Setup(BASE,pcf8574_address);//initialize PCF8574
    for(i=0;i<8;i++){
        pinMode(BASE+i,OUTPUT);     //set PCF8574 port to output mode
    } 
    digitalWrite(LED,HIGH);     //turn on LCD backlight
    digitalWrite(RW,LOW);       //allow writing to LCD
	lcdhd = lcdInit(2,16,4,RS,EN,D4,D5,D6,D7,0,0,0,0);// initialize LCD and return “handle” used to handle LCD
    if(lcdhd == -1){
        printf("lcdInit failed !");
        return 1;
    }

    // Start of my code
    mainMenu();
    return 0;
}