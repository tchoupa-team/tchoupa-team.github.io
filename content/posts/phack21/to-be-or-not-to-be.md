---
title: "TO BE OR NOT TO BE"
chall_name: "to-be-or-not-to-be"
category: "pwn"
description: ""
date: 2021-07-08T13:57:07-04:00
weight: 20
draft: false
info: ""
points: "64"
author: "BisBis"
---

# To B, or ! to B

First we connect via ssh with given login/password

We when connect, we are prompted with a message : 

![capture1](/files/phack21/to-be-or-not-to-be/c1.PNG)

I checked the rights on the flag file :

![capture2](/files/phack21/to-be-or-not-to-be/c2.PNG)

We can see that only user master can read the file.
It means that we have to do some kinds of privilege escalations in order to read the file.

First thing that come to my mind is to check if there is some commands that we are able to run as others users.

```shell
sudo -l
```

![capture3](/files/phack21/to-be-or-not-to-be/c3.PNG)

We can see that sudo command is not found, it means that it might have been blocked from system administror.

Let's try to enumerate all binaries having SUID permissions by using following command :

```shell
find / -perm -u=s -type f 2>/dev/null
```

For further explanation on the command, i'll suggest you to check the documentation given in the end of my write-up.

And look what we got ! 

![capture4](/files/phack21/to-be-or-not-to-be/c4.PNG)

What does it mean ? It simply means that we can run python3.8 with the user id of root.

From now it's pretty easy to get the flag :

![capture5](/files/phack21/to-be-or-not-to-be/c5.PNG)


<em>Documentation : https://www.hackingarticles.in/linux-privilege-escalation-using-suid-binaries/</em>