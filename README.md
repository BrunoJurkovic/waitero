[![Codemagic build status](https://api.codemagic.io/apps/5e20cf4dc5faa61476296a4b/5e20cf4dc5faa61476296a4a/status_badge.svg)](https://codemagic.io/apps/5e20cf4dc5faa61476296a4b/5e20cf4dc5faa61476296a4a/latest_build)
# Waitero
Waitero is a **smart ordering system** to be used in bars, coffee shops, restaurants and similar places. 

The flow of the system goes in this order:

 1. The client sits down at the bar/coffee shop or other place of installation, and sees a QR code on the table that was placed by the manager which he or his employees will operate the *WaiteroHub*.
 2. The client picks from a list of products which the manager added, and can see the price tag, a name, a picture and possibly more information, this "list of products" is called *WaiteroClient*
 3. The operator of the WaiteroHub will see the order on the monitor where the *WaiteroHub* app is installed on, the operator can see the table number of the order. 

![WaiteroHub Dashboard](https://i.imgur.com/dvt0qx7.png)

> *Waitero* is made from two parts:
> 	- WaiteroHub
> 	- WaiteroClient

# Waitero Client

This module of the *Waitero* system uses a **Flutter Web** app which opens when a client scans the QR code that the manager of the store where *Waitero* is installed. 
