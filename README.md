# Project Lemon

I've always wanted a lemon tree.

- Problem1: Canada - Winter is coming (there will be snow).
- Problem2: I'm not going to be living at my current house forever.
- Problem3: I'm a black thumb. 

Solutiuon1:
You get indoor Lemon Trees! What?

Solution2:
An indoor tree means that it's in a pot. It doesn't need to be planted in the ground. It can move when I do.

Solution3:
Enter `Project Lemon`

Intended solution:

1: Use a moisture sensor to measure the lemon tree's hydration levels.  
2: Output values to Discord 

Why discord?
I don't have a small screen to display moisture. I **do** have a discord server.

## Requirements:

Harware:
- Capacative Moisture Sensor
- Raspberry Pi Zero 2 W
- Esp32-C6

Software:
- Arduino IDE for coding

Skills:
- A little soldering know-how  
- A bit of BASH-fu  
- A bit of GPT assistance to give me the ESP microcode  

## How it works
1: The moisture sensor is connected to the esp32-c6 via GPIO.  
2: The esp32-c6 checks on the capacitance values of the moisture sensor every minute.  
3: The esp32-c6 is also atrtached tho the raspberry pi via USB.  
4: The Raspberry Pi runs a timer once an hour to check the capacitance vlaues on the esp32-c6.  
5: Then the Raspberry Pi sends a "command" to a specific Discord URL with the vlaue of the capacitance.

## Result
Once an hour, I get a litte messag in Discord:
<img width="244" height="392" alt="image" src="https://github.com/user-attachments/assets/4d656556-5d7c-4cd6-a3e1-da4112a2bd31" />

## Future:
_Maybe_ some sort of automated watering system.
