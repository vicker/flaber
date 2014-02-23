> Directly converted from old readme file dated 16 March 2006

***

FLABER (FLAsh-based web BuildER)
Flash it! Drag it! Build it!

SourceForge Project Page
[http://sourceforge.net/projects/flaber](http://sourceforge.net/projects/flaber)

***

# A. Author's Voice

Is been a long time since I started this project. Finally I have a chance to present the very first release. Counting my fingers, this project is running for nearly a year already. I wont say that this product is great, however I will say that you will have fun with it!

Vicker LEUNG @ 2006 Mar 16

Student of City University of Hong Kong, SAR



# B. Why FLABER?

FLABER is a pure ActionScripts 2 driven Flash Rich Internet Application (RIA), while the server side scriptings relies on PHP, data storage mainly using XML.

This project is first started as my personal final year project. (University homework... in other words =.=) And when I developed it further, I want to make it an open source product. So now this project is hosted in SourceForge under General Public License (GPL).

The main usage of FLABER is to allow any people with different skillsets, even you know nothing about Flash can still build up your own personal Flash-based website.



# C. System Requirements

**Server side:**

IIS / Apache with PHP 4.0 or above

**Client side:**

Flash Player 8 is a must

# D. Installation

- Go to download the latest package of FLABER from http://sourceforge.net/projects/flaber
- Unzip the package
- Copying the whole FLABER folder to your personal web space
- Change the file and folder permission as follows

***

+ flaber/
    + function/
	+ img/          *666, including all folder contents*
	+ page/			666, including all folder contents
	+ style/
	+ MenuBar.xml
	+ NavigationMenu.xml	666
	+ release.html
	+ release.swf

***

- Enjoy using FLABER by browsing to the http://installation_path/flaber/release.html

# E. Using FLABER

> Apolgy first I dont have much time to prepare a good documentation. I will improve in the forthcoming releases

There are actually two main viewpoint of FLABER, "Action Mode" and "Edit Mode".

## E.a. Action Mode

Action mode is the mode that is in default when anyone browse FLABER. So this can be also called the browsing mode. In this mode, you can browse the web just like any normal web page. Text, Images, Shapes, Links and Navigation Menus are all available.

## E.b. Edit Mode

When you are in edit mode, all the elements is editable. You can try to move your mouse over any element and a small panel will be placed near the element which is called the "Edit Panel".

In order to change the mode, you need admin login which will be mentioned in next paragraph.

## E.c. Admin login

You can enter the admin login by:

Pressing "CTRL + E"

> Internet Explorer user may experience problem that "CTRL + E" is mapped to other shortcut function. Try "SHIFT + CTRL + E"


The default password is "flaber" without the double quotes.

**You can change the password by editing flaber/function/admin_login.php**

After login, you will notice that a new menu bar come out, here you can access numerous functions including mode change.

## E.d. Add and Edit Items

Adding new element is simple, you can use the menu bars

- Insert > TextField
- Insert > Image
- etc...

A window will bring up asking for the item details

Editing existing element will require "Edit Mode".
Accessable by the menu bar

- Mode > Edit Mode

After changing to edit mode, you can rollover any elements to bring up a little panel which have numerous editing functions: (from left to right)
Move | Resize | Rotate | Properties

## E.e. XML Editing

Because not all the functions in FLABER are implemented, you may experienced that serveral items are not changeble right now. For example, background color, wallpaper, etc.

And some expert users may like editing codes rather than using the GUI. In this case, you are always welcome to edit the XML files directly.

**For normal users, try not to edit the XML directly which may results unbelievable damage to the FLABER data**

The XML files are placed in the following manner:

***

+ flaber/
    + function/
	+ img/
	+ page/ *all the seperate pages, you can see it like a single html file*
    + style/
	+ MenuBar.xml *the menu bar. no fun in here so I dont guess you will need to edit this*
	+ NavigationMenu.xml *the navigation menu which will appear on EVERY page of the web*
	+ release.html
	+ release.swf

***

# F. Contacts

For general issues, such as suggestions making, bug reporting, commenting, donation etc. Please kindly move one more step to the SourceForge project forum.

[http://sourceforge.net/forum/?group_id=152518](http://sourceforge.net/forum/?group_id=152518)

Your support is always welcome and valuable for me to develope even more products.

For other issues, such as joining me as the development team. Please dont hesitate to contact me directly through email.

vicker[at]gmail.com

ICQ also welcomes at 25264936.

# G. Special Thanks

Here, I grab the chance to thank some of the people who helped me a lot in the succeed in this project.

***Dr. Andy CHUN, Hon Wai***

Professor in City University of Hong Kong. He is a great professor who provided lots of knowledge and suggestions to me.

***Mr. Tim SHIU, Ka Kei***

A friend of mine and a great programmer in many different languages. He have a very rigid logic and thinking which really helps me a lot during development, especially those OO concepts.

***Ms. Eva SHI, Yi Fan***

My girlfriend and also my first-line tester. I already forgot how many times she sitting besides me watching me typing all those crazy Flash codes. Sorry about that and I love you :)

***Ms. CHEUNG, Pui Ling***

My first fans haha~ Thanks for the testing efforts and kind support.

***Additional thanks to***

- 00HK Server hosting
- SourceForge Project hosting