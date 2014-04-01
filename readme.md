# FLABER (FLAsh-based web Builder)

Updated in Apr 2014

## Introduction

FLABER is a project developed by Hong Kong developer Vicker Leung ([LinkedIn](http://hk.linkedin.com/in/vicker/)) in 2006 as his BSc Computer Science final year project. At that time Adobe Flash is commonly used as a platform to deploy rich web content, ranging from an animated banner, mini games to a complete web site. However the creation of Flash content heavily relies on the desktop Adobe Flash authoring tool that is not easy to master and maintain, that is why the concept of FLABER emerged.

Instead of having the content pre-compiled inside the Flash document, the content is constructed during runtime according to a XML document. Together with the built-in intuitive editing tool, users can edit the Flash content anytime, anywhere with ease.

A demo video of FLABER v1 is available at Vimeo [(https://vimeo.com/87391440)](https://vimeo.com/87391440)

P.S. The whole concept is very similar as the product Wix ([website](http://www.wix.com/)), where the company was founded in the same year as FLABER was built :p

## Awards

- Asia Pacific ICT Awards (APICTA) Tertiary Student Project Merit Award (2006)
- Hong Kong ICT Awards (HKICTA) eYouth Grand Award and Software Gold Award (2006)
- Pan-Pearl River Delta Region University IT Project Competition First Class Award, Best Practicality Award and Best Presentation Award (2006)

## Status

The 2006 FLABER is still compatible with the latest 2014 technologies (Flash Player 12 and PHP 5) and there are still quite a number of websites on the Internet still using FLABER. However as the source code is not updated for so many years, please be warned that there may be flaws and security concerns.

## Roadmap

The development of FLABER v1 have been suspended for many years. The original project was hosted at SourceForge ([website](https://sourceforge.net/projects/flaber/)) and recently migrated to GitHub with complete version history as a snapshot.

There was an unfinished FLABER v2 prototype developed using Adobe Flex 3, developers who are interested to have a copy of the unfinished source code can leave a message in GitHub. The source may be polished and released if there is a very high demand.

FLABER Mobile is currently in brainstorming stage, subscribe this repository to get notified about future updates.


> ***
>
> !!! All the contents below this are the original readme that was written back in 2006
>
> ***

# A. Author's Voice

There are many memerable moments since the last release till now. FLABER won three awards from a University IT Project Competition. And the first language translation of FLABER (Simplified Chinese) is done by Raymond@openlink.cn. SourceForge records more than 3000 downloads. All of these achievements will never exists without your support! I am sure FLABER will become more famous and perfect with your contribution! Thanks a lot!!

Vicker LEUNG [at] JULY 17th 2006


# B. About FLABER?

FLABER is a pure ActionScript 2.0 driven Flash Rich Internet Application (RIA). The structure of FLABER is mainly divided into three components - Flash RIA (the graphic user interface and core), PHP (server-side scripting language) and XML (data storage format).

This project is first started as my final year project in City University of Hong Kong. (in other words… homework…) Since the first public release in SourceForge, I received many great feedbacks from the public. That is why I decided to make FLABER an open source product so that everyone can benefits from it :)

# C. Why FLABER?

A well designed and coded web page is very important to attract users. Unfortunately, not everyone is good at designing and coding. Using our FLABER tool, anyone - even a kid - can build a user-friendly and accessible website with great multimedia experience. FLABER not only benefits the web owner, but also improves the user experience.

From a business point of view, web maintenance is always a problem. Companies need to hire an expert in web design or train a staff to update the web contents. This problem will be more crucial if Flash contents are used. With FLABER, companies can cut down resources used in maintaining the web site. Moreover with better content presentation, it may boost their sales as well.

# D. System Requirements

**Server side:**

- Microsoft IIS or Apache HTTP Server
- PHP 4.0 or above

**Client side:**

Any internet browser with Flash Player 8.0 or above

# E. Installation Guide

1. Download the latest package of FLABER from SourceForge
    - If you simply want to use FLABER, download the “flaber” package
    - If you also want to modify FLABER, download the “flaber_source” package
2. Unzip the package
3. Upload the unzipped content to your own web server
4. Change the file and folder permission as follows
5. Browse to
    http://www.your_domain.com/installation_path/flaber/index.html
6. What's more?!?! Go ahead and enjoy FLABER now~


# E.a. Permission Settings

| Folder / File | Permission |
| ------ | ------ |
| flaber/ | |
| flaber/function/ | |
| flaber/function/password.php | 666 |
| flaber/img/ | 777 |
| flaber/img/*.* | 666 |
| flaber/page/ | 777 |
| flaber/page/*.* | 666 |
| flaber/style/ | |
| index.html | |
| flaber.swf | |
| Flaber.xml | 666 |
| MenuBar.xml | |
| NavigationMenu.xml | 666 |


# F. How to use FLABER

Please accept my apology first… I don't have much time and experience in preparing a good documentation. If you would like to offer me some help, I will always welcome and appreciated! Your participation is one of the criteria to make FLABER perfect!

# F.a. Site Administrator

In order to protect your web page from non-authorized editing, FLABER has an authentication mechanism. The advanced functions such as editing will become accessible, only if the user can provide the administrative password to the system.

# F.a.i. Login Panel (Updated)

You can bring up the login panel or context menu anytime by pressing a hotkey when FLABER is within focus. Different operating systems and browsers use different hotkey or mouse click which are listed as follows:

| | IE (Win) | Opera (Win) | Firefox (Win) | Safari (Mac) | Opera (Mac) |
| ------ | ------ | ------ | ------ | ------ | ------ |
| Mouse | Right mouse click | Right mouse click | Right mouse click | Control + Click | Control + Click |
| Keyboard | Ctrl + Shift + E | Ctrl + E | Ctrl + E | Not supported | Mac + E |

If the password is correct, a new menu bar will be available at the top with all the advanced functions.

# F.a.ii. Changing Password (Updated)

    Tool > Change Password

Starting from version 1.1, you can change the password in a much simpler way than before by making use of the new change password dialogue box. Simply enter your original password and new password to do the changes.

# F.b. The Mode Concept

In FLABER, it can be divided into two modes (or viewpoint). They are “Action Mode” and “Edit Mode”. Different modes will give the page contents a different behavior and functionality.

# F.b.i. Action Mode

    Mode > Action Mode

This is the default mode when FLABER is opened, you can see it as the “Display Mode”. Within this mode, all the page contents will act normally like those in traditional XHTML web pages. For example, you can highlight and copy the text fields.

# F.b.ii. Edit Mode

    Mode > Edit Mode

This is the mode where you do all the page editings. When you try to mouse over the page elements, they will be highlighted. Clicking on the elements will bring up a small panel known as “ Edit Panel”. Making use of this little panel, you can perform move, resize, rotate, properties and delete functions on the target element.

# F.b.iii. Mode Switching

    Mode > xxxxxx

In order to switch between the two operation modes, you have to login as an administrator. For information concerning login, please refer to F.a.i) Login Panel.

After authentication, you can trigger a mode switching using the “Mode” menu item, for example:

    Mode > Edit Mode

You will notice the change when you try to mouse over the page elements on the stage. In edit mode, mouse over the page elements will have a highlight effect where action mode don't.

# F.c. Page Functions

    File > xxxxxx

Each screen you browse inside FLABER is known as a page and it is stored in a XML file. You can do many page functions just like you are using other software applications, such as:

- New Page
- Open Page
- Save Page

>
> !!!!!! Since FLABER don't have auto saving mechanism yet, !!!!!!
>
> !!!!!! PLEASE ALWAYS REMEMBER TO SAVE THE CONTENTS before leaving FLABER !!!!!!
>

# F.d. Page Elements and Editing

Currently FLABER supports four page elements including:

- TextFields
- Images
- Links
- Shapes
    - Rectangles
    - Oval
- Navigation Menu
    - Navigation Item

# F.d.i. Adding New Elements

    Insert > xxxxxx

You can add new elements to the stage using the “Insert” menu item, for example:

    Insert > Textfield

# F.d.ii. Editing Existing Elements

First of all, make sure you are in Edit Mode. Then you can left click on any page element to bring up a handler object that covers the whole element. This handler replaces the edit panel in previous versions to give you more direct manipulation on the elements.

| | | R |
| ------ | ------ | ------ |
| | The Page Element | |
| B | | Y |

The functions of the handlers are listed as follows

| Move | Left click on the page element and drag |
| ------ | ------ |
| Resize | Left click on the Yellow Handler (Y) and drag |
| Scale Resize | Press Shift while resizing |
| Special Resize (for Sqaure and Circle) | Press Ctrl while resizing |
| Rotate | Left click on the Blue Handler (B) and drag |
| Delete | Left click on the Red Handler (R) |
| Properties | (PC) Right click on the page element (MAC) Control + Click on the page element |

Actually not all the page elements have all the functions, the detailed list is as follows:

| | Move | Resize | Rotate | Properties | Delete |
| ------ | ------ | ------ | ------ | ------ | ------ |
| TextField | O | O | | O | O |
| Image | O | O | O | O | O |
| Link | O | | | O | O |
| Shape | O | O | O | O | O |
| Navigation Menu | O | | | O | |
| Navigation Item | O |  | | O | O |

# F.e. Page Properties

    Modify > Page Properties

Inside page properties, it contains all the settings concerning with the currently opened page including:

- Background Color
- Background Image

# F.f. Web Properties (Updated)

    Modify > Web Properties

Web properties are quite similar as the page properties, however the target is on the entire web site. Functions include:

- Index Page (the very first page that FLABER will load when started)
- Status Message (switching on / off the status message bar)
- Navigation Menu
- Page Transition (special animation effects during page change)
    - Iris
    - Fade
    - Fly
    - Pixel Dissolve
    - Wipe

# F.g. Depth Manager (Updated)

    Tools > Depth Manager

All the page elements within FLABER are placed in seperate layers (different depths). In order to change the depth of different elements, you can make use of the depth manager.

Inside depth manager, all the movable page elements are listed. You can change the depth simply by selecting an item and press either the button + or - (+ stands for moving up and - for moving down)

In version 1.1 RC1, you can also edit or delete the page elements through the depth manager. Simply select the target element from the list and press the corresponding button.

# F.h. Image Uploader

    Tools > Image Uploader

If you want to use your own image files, you have to upload the file from local to the server. Instead of using your personal FTP clients, you can also make use of the image uploader inside FLABER.

By default, all the upload files are placed inside the “IMG” folder, and file size is limited to “10MB per file”. (Additional limit may be present for some servers. Please contact your server provider for details)

# F.i. XML Editing

Actually FLABER is still under rapid development. Some of the functions are not editable through the GUI. Expert users like you may like code editing rather than using the GUI. In this case, you are always welcome to edit the XML files directly.

> !!!!!! For non-expert users, try not to edit the XML directly        !!!!!!
>
> !!!!!! which may results unpredictable corruption to the FLABER data !!!!!!

The following is a brief explanation on the XML documents:

| Folder / File | Remarks |
| ----- | ----- |
| flaber/ | |
| flaber/function/ | |
| flaber/img/ | |
| flaber/page/ | This is where all the pages are placed… |
| flaber/page/index.xml | Every page is placed in a seperate XML file like HTML |
| flaber/page/page2.xml | |
| flaber/style/ | |
| index.html | |
| flaber.swf | |
| Flaber.xml | The is the global config file, controlling the page transitions, etc… |
| MenuBar.xml | FLABER's menu bar, no editing is suggested except language translation |
| NavigationMenu.xml | The navigation menu which appears on EVERY page of the web |

# H. Acknowledgements

Here, I grab the chance to thank some of the people who helped me a lot in the success of this project.

- Dr. Andy CHUN, Hon Wai *(Associate Professor - City University of Hong Kong)*

    My final year project supervisor, expert in artificial intelligence and a great artist. He is a great professor who provided me with lots of knowledge and suggestions throughout the year.

- Mr. Tim SHIU, Ka Ki *(FLABER's Strategic Master & FARSER's founder)*

    One of my best friend and a great programmer in many different languages. He has a very rigid logic and thinking which really helps me a lot during FLABER's early development, especially those OO concepts.


- Mr. Chris LIANG, Li *(FLABER's Strategic and Algorithmic Master)*

    Another best friend and great thinker. No algorithm can troubles him. That is why whenever I got some Maths problem in FLABER, I will throw them to Chris XD


- Ms. Eva SHI, Yi Fan *(FLABER's Tester)*

    My girlfriend and also my first-line tester. I already forgot how many times she sat beside me watching me typing all those crazy Flash codes. Sorry about that and I love you :)


- Mr. Warenix WONG, Ms. Soki HO and Ms. Christy CHUNG *(FLABER's Testers)*

    Three user testers during the second release. They really gave me a lot of comments that I never thought of and are important for all the users. Thanks.


- FLABER Supporters

    ATIX, BeVeR, Catherine, Claudio, David Prouty, elomibao, John Petitjean, Kevin Airgid, kristjan dekleva, Liam, Paul, Scott AKA Stri, shauryaanand, Sven Schaetzl, Vesselin Drangajov, Zac Raybould … (Have I missed your name?!?! Let me know!)


- Special thanks to
    - 00HK (Project hosting company)
    - SourceForge (Project hosting community)
    - Adobe Flash (Development platform)
    - PSPad (Code editor)
    - SEPY ActionScript Editor (Code editor)