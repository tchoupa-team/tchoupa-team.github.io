---
title: "SUDOKUV2"
chall_name: "Sudoku V2"
category: "pwn"
description: ""
date: 2021-07-08T13:52:38-04:00
weight: 20
draft: false
info: ""
points: "256"
author: "BisBis"
---

# Sudoku v2

On this challenge, we got a little hint in the description about the fact that, in order to help the user the system administrator 
enabled asterisks when entering a password.

We connect via ssh with given login/password

We when connect, we are prompted with a message : 

![capture1](/files/phack21/sudokuv2/c1.PNG)


I checked the rights on the flag file :

![capture2](/files/phack21/sudokuv2/c2.PNG)

We can see that only user master can read the file.
It means that we have to do some kinds of privilege escalations in order to read the file.

First thing that come to my mind is to check if there is some commands that we are able to run as others users.

```shell
sudo -l
```

![capture3](/files/phack21/sudokuv2/c3.PNG)

We can see that i'm asked to enter the password of my current user. 
What we don't see on the screenshot is that while I was entering the password, I had the asterisks I talk about earlier.

For example the password of padawan user is : "padawan" so when I entering it I had something like : "*******"

Let's try to enumerate all binaries having SUID permissions by using following command :

```shell
find / -perm -u=s -type f 2>/dev/null
```

![capture4](/files/phack21/sudokuv2/c4.PNG)

Nothing really interesting, I don't know what "abuildsudo" is.

I didn't spend much time on this and I started looking for some privilege escalation when asterisks are enabled on the system.
And I quickly found that there is a pretty recent buffer overflow privilege escalation when this option is enabled.
So in order to test if this is a buffer overflow : 

```shell
perl -e 'print(("A" x 100 . "\x{00}") x 50)' | sudo -S id
```

This command just print a lot of character when the password is prompted.

![capture5](/files/phack21/sudokuv2/c5.PNG)

And that's it ! Segmentation fault, it means that the solution is to use this buffer overflow.

I found a very interesting website that explain the buffer overflow and gives a script to achieve it : https://dylankatz.com/Analysis-of-CVE-2019-18634/

And his git : https://github.com/Plazmaz/CVE-2019-18634

Time to exploit : 

![capture6](/files/phack21/sudokuv2/c6.PNG)

As you can see, the script works flawlessly and we can get the flag !

![capture7](/files/phack21/sudokuv2/c7.PNG)