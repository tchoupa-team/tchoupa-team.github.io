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
	
