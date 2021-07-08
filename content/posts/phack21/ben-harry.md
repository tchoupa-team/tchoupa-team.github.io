---
title: "BEN HARRY"
chall_name: "Ben & Harry"
category: "misc"
description: ""
date: 2021-07-08T13:23:23-04:00
weight: 20
draft: false
info: ""
points: "128"
author: "BisBis"
---

# Ben & Harry

We have to go on the website : ben-and-harry.phack.fr:1664
 
![capture1](/files/phack21/ben-harry/c1.PNG)

We can see three informations, "b" ,"code" and "msg"

The msg is asking us to answer it so after a while, we manage to understand that the "b" variable is the base used for the number.
So our guess is to decrypt using the base and then send back to the server the answer.

Here is the python script : 

```python
from pwn import *
import json
import time


from math import pow, log
 
def convert(nbr, old_base, new_base):
    " nbr est un str, old_base et new_base des entiers "
    chiffres = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
    nbr_dec = 0
    i = len(nbr) - 1
    for x in nbr:
        nbr_dec += chiffres.index(x) * int(pow(old_base, i))
        i -= 1
    nbr_chars = int(log(nbr_dec)/log(new_base) + 1)
    nbr_final = ""
    for i in range(0, nbr_chars):
        x = int(nbr_dec / pow(new_base, nbr_chars-1-i))
        nbr_dec -= int(x * pow(new_base, nbr_chars-1-i))
        nbr_final += chiffres[x]
    return nbr_final
context(arch = 'i386', os = 'linux')

cpt = 0
r = remote('ben-and-harry.phack.fr', 1664)
v=r.recvline()
res = json.loads(v)

tab_char=[]
for c in res["code"].split(" "):
	tab_char.append(chr(int(str(convert(c,res["b"],10)))))
tab=[]
for c in "oui":
	tab.append(convert(str(ord(c)),10,res["b"]))

r.send("".join(tab_char))
while True:
	time.sleep(1)
	v=r.recvline()
	print(v)	
	res = json.loads(v[3:])
	tab_char=[]
	for c in res["code"].split(" "):
		tab_char.append(chr(int(str(convert(c,res["b"],10)))))
	tab=[]
	for c in "oui":
		tab.append(convert(str(ord(c)),10,res["b"]))
	r.send("".join(tab_char))
	cpt+=1
	
```

Basically what it does : 

    -  Open a connection 
    - Receive and load the json 
    - Convert every number into the decimal base and append it to a list
    - Send the list of converted number

We had to do "one loop" outside the while because after sending the first answer, the json object is a little different that the first one. 
With this we are able to fetch the data and answer the good message as much as the server require to get the flag.

![capture2](/files/phack21/ben-harry/c2.PNG)

And we got the flag ! 