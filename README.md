# elevator_control_interface

## The Problem of Current Design

One of the elevator control panels on campus:
![Alt text](https://github.com/thinhhoangpham/p1.HoangThinh.Pham/blob/main/reportImages/IMG_802C72CFA484-1.jpeg?raw=true)

In action:

![Alt text](https://github.com/thinhhoangpham/p1.HoangThinh.Pham/blob/main/reportImages/ezgif-4-03908d94f1.gif?raw=true)

Problem:
-	Confusing button layout: Similar buttons stay too far apart (like floor buttons or door open and close buttons are at the opposite ends off the row
-	One button seems to have more than one function and need different actions to execute.
-	Floor canceling function was implemented in the button that is intended to be used in emergency situations by firefighter only (Hence the red color and red instructions.
-	More than one function leads to confusing labels. Labels don’t give obvious difference between function and modes (Like fand setting, the FAN label and different levels of fan speeds have the same font, color and size put around the switch which give more confusion. Furthermore, the LIGHT button only has OFF label and the LIGHT label was seemingly used for switching it on too.
-	Poor color choice: CAR/CALL/CANCEL button is used for cancelling a floor selection but was given a red color which can make user hesitate to use because they may think it is for emergency situations. The Emergency button, on the other hand, is white like normal floor buttons.


## The Solution
How can an elevator control panel can be better?
-	Most frequently used functions like floor selection must be easier to execute.
-	Canceling a floor must be easily done while being hard to accidentally triggered.
-	An interface should give more useful information (like places on each floor).
-	Given information about places on each floor can minimize the problem of selecting a floor by mistake and lead to less confusion of solving the problem.

![Alt text](https://github.com/thinhhoangpham/p1.HoangThinh.Pham/blob/main/reportImages/p1.HoangThinh.Pham.png?raw=true)


Implementing touch user interface:


