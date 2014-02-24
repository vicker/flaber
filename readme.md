> Directly converted from old readme file dated 16 March 2006

***

FLABER (FLAsh-based web BuildER)
Flash it! Drag it! Build it!

SourceForge Project Page
[http://sourceforge.net/projects/flaber](http://sourceforge.net/projects/flaber)

***

# A. Author's Voice

Thanks for all the supports from the public~ The total download count in sourceforge already reached 1000! To celebrate this moment, release 3 is out!! I hope that you will continue supporting FLABER and enjoy building your Flash web pages.

Vicker LEUNG @ 2006 May 4

Student of City University of Hong Kong, SAR


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
	+ img/  *777 with folder contents 666*
	+ page/ *777 with folder contents 666*
	+ style/
	+ index.html
	+ flaber.swf
	+ Flaber.xml    *666*
	+ MenuBar.xml
	+ NavigationMenu.xml	*666*

***

- Enjoy using FLABER by browsing to the http://installation_path/flaber/index.html

# E. Using FLABER

> Apolgy first I dont have much time to prepare a good documentation. I will improve in the forthcoming releases

## E.a. Action Mode

There are actually two main viewpoint of FLABER, "Action Mode" and "Edit Mode".

Action mode is the mode that is in default when anyone browse FLABER. So this can be also called the browsing mode. In this mode, you can browse the web just like any normal web page. Text, Images, Shapes, Links and Navigation Menus are all available.

When you are logged in as an admin, you can enter edit mode by the menu item "Mode"

    Mode > Edit Mode

## E.b. Edit Mode

When you are in edit mode, all the elements is editable. You can try to move your mouse over any element and a small panel will be placed near the element which is called the "Edit Panel".

In order to change the mode, you need admin login which will be mentioned in next paragraph.

## E.c. Admin login

You can enter the admin login by:

    CTRL + E

> Internet Explorer user may experience problem that "CTRL + E" is mapped to other shortcut function. Try "SHIFT + CTRL + E"


The default password is "flaber" without the double quotes.

**You can change the password by editing flaber/function/admin_login.php**

After login, you will notice that a new menu bar come out, here you can access numerous functions including mode change.

## E.d. Add and Edit Items

Currently FLABER supports the following page items:

- TextField
- Image
- Links
- Shapes (Rectangles only)

Adding new element is simple, you can use the "Insert" menu bars
A window will bring up asking for the item details

    e.g. Insert > TextField

Editing existing element will require "Edit Mode". (mentioned in chapter E.b.)

After changing to edit mode, you can left click on any elements to bring up a little panel called edit panel which have numerous editing functions:
(from left to right)

    Move | Resize | Rotate | Properties | Delete

- Move
    - Left click and drag to move the item
- Resize
    - Left click and drag to resize the item (not all items support)
- Rotate
    - Left click and drag to rotate the item (not all items support)
- Properties
    - Left click will bring up an advance dialogue box
- Delete
    - Left click will remove the item

## E.e. Page Properties

Page properties contain all the settings according to the current opening page, including

- Background Color
- Backgroung Image

Page Properties are accessible through the menu item "Modify"

    Modify > Page Properties

## E.f. Web Properties

Web properties are similar as page properties, however the target is on the whole web site. Functions includes

- Index Page
    - that is the first page that FLABER will load when a visitor comes
- Navigation Menu
    - whether a navigation menu will be used throughout the web
- Page Transitions
    - special animation effects when there are page changes

Web Properties are accessible through the menu item "Modify"

	Modify > Web Properties

## E.g. New / Open and Saving

All of these functions can be found through the menu item "File".

**!!!!!!!!!! ALWAYS REMEMBER TO SAVE THE CONTENT BEFORE EXITING THE WEB !!!!!!!!!!**

## E.h. Depth Manager

All the page elements within FLABER are placed in seperate layer (different depth). In order to change the depth of different elements, you can make use of the depth manger.

    Tools > Depth Manger

Inside depth manager, all the page elements are listed. You can change the depth simply by selecting an item and press either + or - (+ stands for moving up vice versa)

## E.i. Image Uploader

If you want to use your own image files in FLABER, instead of using your FTP clients. You can make use of the image uploader.

    Tools > Image Uploader

By default, all the uploaded files are placed in the IMG folder. And file size is limited to 10MB per file. (Additional limit may be present for some servers. Please contact your server provider for details)

## E.j. XML Editing

Actually FLABER is still in development, some of the functions are still not editable through the GUI. And some expert users may like editing codes rather than using the GUI. In this case, you are always welcome to edit the XML files directly.

**!!!!!!!!!!   For non-expert users, try not to edit the XML directly    !!!!!!!!!!**
**!!!!!!!!!!   which may results unbelievable damage to the FLABER data  !!!!!!!!!!**

The XML files are placed in the following manner:

***

+ flaber/
    + function/
	+ img/
	+ page/ *all the seperate pages, you can see it like a single html file*
	    + index.xml
	    + page2.xml
    + style/
    + index.html
    + flaber.swf
    + Flaber.xml *the so called global config file, controlling the page transitions etc...*
	+ MenuBar.xml *the menu bar. no fun in here so I dont guess you will need to edit this*
	+ NavigationMenu.xml *the navigation menu which will appear on EVERY page of the web*

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

Professor in City University of Hong Kong. Experts in Artificial Intelligence and Arts. He is a great professor who provided lots of knowledge and suggestions to me.

***Mr. Tim SHIU, Ka Kei***

A friend of mine and a great programmer in many different languages. He have a very rigid logic and thinking which really helps me a lot during development, especially those OO concepts.

***Ms. Eva SHI, Yi Fan***

My girlfriend and also my first-line tester. I already forgot how many times she sitting besides me watching me typing all those crazy Flash codes. Sorry about that and I love you :)

***Mr. Warenix WONG, Ms. Soki HO and Ms. Christy CHUNG***

My three user testers. Responsible to test whether the product is usable for different users.

***Additional thanks to***

- 00HK Server hosting
- SourceForge Project hosting
- Macromedia Flash
- SEPY ActionScript Editor

- Carmen
- Chris LIANG
- Kay CHEUNG
- Leo (ATIX)
- Michael STOCK
- Olivia
- Sam LAM