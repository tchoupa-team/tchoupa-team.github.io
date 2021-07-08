---
title: "GRADUATED"
chall_name: "Graduated"
category: "pwn"
description: ""
date: 2021-07-08T13:37:51-04:00
weight: 20
draft: true
info: ""
points: "256"
author: "BisBis"
---

# Graduated 

First we connect via ssh with given login/password

We when connect, we are prompted with a message : 

![capture1](/files/phack21/graduated/c1.PNG)


I checked the rights /home/rector directory

![capture2](/files/phack21/graduated/c2.PNG)

We can see that only user master can read the flag file but we can see a lot of different file that are readable for us.

I still check if there is some commands that we are able to run as others users and I also check the SUID for binaries file .

```shell
sudo -l
find / -perm -u=s -type f 2>/dev/null
```

![capture3](/files/phack21/graduated/c3.PNG)

Nothing interesting, I go back investigating on /home/root folder and decide to cat some files.

![capture4](/files/phack21/graduated/c4.PNG)

In the /home/rector/integrator.log, I see that every minutes there is a script that perfoms some actions on the /home/teacher/evaluations directory.
I guess this is the crontab but not with my user.

There is also a database file so I open it : 

![capture5](/files/phack21/graduated/c5.PNG)

My guess is that this database file is being filled with the evaluation of the /home/teacher/evaluation directory.

If I check the files in my user directory : 

![capture6](/files/phack21/graduated/c6.PNG)

And we can see multiples files but the one that interest me is the template one : 

![capture7](/files/phack21/graduated/c7.PNG)

Nothing particular but I still search on internet if it's possible to execute system command throught xml files.
Because since there is a script, probably running by rector user, every minutes that check in the xml file in /home/teacher/evaluations directory, it means
at the time of execution, if we can use a system command, the user that will execute the command is the one calling the script, so the rector user.

And it's posibble and it's called XXE attack. 
You can find all informations about it there : https://www.programmersought.com/article/55164767916/

Let's try that : 

![capture8](/files/phack21/graduated/c8.PNG)

And then we move it into correct folder in order to be evaluated : 

![capture9](/files/phack21/graduated/c9.PNG)

And look what happened in the /home/rector/integratog.log : 

![capture10](/files/phack21/graduated/c10.PNG)

So let's check our database file in /home/rector/graduation.db : 

![capture11](/files/phack21/graduated/c11.PNG)

And we got the flag ! 

**I didn't put the whole file on the last screenshot because I had severals attemps in order to success so the file was a bit messed up**