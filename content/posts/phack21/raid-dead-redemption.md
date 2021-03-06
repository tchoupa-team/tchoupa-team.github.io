---
title: "RAID DEAD REDEMPTION"
chall_name: "Raid Dead Redemption"
category: "forensic"
description: ""
date: 2021-06-18T20:01:53-07:00
weight: 20
draft: false
info: ""
points: "512"
author: "ChapeauR0uge"
---
# Raid Dead Redemption

## Description

![Raid Dead Redemption - P'Hack'21](/files/phack21/raid-dead-redemption/raid_dead_redemption.PNG)

## Solve

Nous avons deux fichiers:
* `NoticeMastok_3000.pdf` un pdf contenant une documentation technique.
* Un zip, contenant trois fichiers binaires `DISK1.bin`, `DISK2.bin` et `DISK3.bin`.

Je fait une petite analyse rapide de ces fichiers:
```shell
$ ls -l
-rw-rw-r-- 1 chapeaurouge chapeaurouge  662835 Dec 10 07:56 DISK1.bin
-rw-rw-r-- 1 chapeaurouge chapeaurouge       0 Dec 10 07:56 DISK2.bin
-rw-rw-r-- 1 chapeaurouge chapeaurouge  662835 Dec 10 07:56 DISK3.bin
```
Je remarque que le fichier DISK2.bin, celà n'est pas étonnant car les données ont été supprimé par le suspect.

En lisant la documentation technique, je découvre rapidement qu'il s'agit d'une implémentation d'un raid 5.

En lisant la documentation du RAID5, nous savons que nous avons besoin de juste faire un XOR sur les deux autres DISK, pour retrouver les données perdus.

J'utilise donc le logiciel windows `xorfile`, qui me permet de rapidement faire un `xor` sur de gros fichiers :

![xorfile - P'Hack'21](/files/phack21/raid-dead-redemption/xorfile.PNG)

Une rapide vérification sur le fichier, nous permet de voir que le XOR à fonctionner `DISK2_recovered.bin`.

Maintenant nous devons réassembler les fichiers, nous devons donc reconstruire le mapping de la table, pour se faire nous avons la documentation technique:
* Left-Asynchronous 
* Lecture de droite à gauche
* Le bit de parité sur le DISK 3
* Chunk size de 1 octet

Après de très longues et fastidieuse recherche nous mettons en place le mapping suivant :

||DISK1|DISK2|DISK3|
|:-:|:-----:|:-----:|:-----:|
|1|BYTE 1|BYTE 2|PARITY|
|2|BYTE 3|PARITY|BYTE 4|
|3|PARITY|BYTE 5|BYTE 6|
|...|...|...|...|...|
|END|EOF|EOF|EOF|

Toutes les contraintes ci-dessus sont respectées, nous n'avons plus qu'à écrire un programme pour le réassemblage.

Nous avons donc écrit le programme `assembler.py`.

Après éxecution de celui-ci:
```shell
python3 assemler.py
```

J'ai maintenant le dump du disk au complet.

Je decide d'utiliser `foremost` pour extraire tout les fichiers de ce dump:
```shell
------------------------------------------------------------------
File: DISK.img
Start: Mon Apr  5 14:47:11 2021
Length: 1 MB (1325670 bytes)
 
Num	 Name (bs=512)	       Size	 File Offset	 Comment 

0:	00000145.jpg 	       8 KB 	      74408 	 
1:	00000163.jpg 	      33 KB 	      83576 	 
2:	00000230.jpg 	      33 KB 	     118019 	 
3:	00000693.jpg 	      11 KB 	     355137 	 
4:	00000716.jpg 	      11 KB 	     366800 	 
5:	00000738.jpg 	       6 KB 	     378069 	 
6:	00000752.jpg 	      28 KB 	     385213 	 
7:	00001100.jpg 	      17 KB 	     563574 	 
8:	00001134.jpg 	      25 KB 	     581100 	 
9:	00001186.jpg 	      34 KB 	     607329 	 
10:	00001254.jpg 	       8 KB 	     642179 	 
11:	00001271.jpg 	      13 KB 	     650904 	 
12:	00001415.jpg 	       3 KB 	     724988 	 
13:	00001423.jpg 	       8 KB 	     728769 	 
14:	00001440.jpg 	      17 KB 	     737696 	 
15:	00001476.jpg 	       9 KB 	     755920 	 
16:	00001844.jpg 	      13 KB 	     944220 	 
17:	00001871.jpg 	       9 KB 	     958049 	 
18:	00001889.jpg 	      16 KB 	     967420 	 
19:	00001923.jpg 	      12 KB 	     984715 	 
20:	00001947.jpg 	       3 KB 	     997285 	 
21:	00001954.jpg 	       6 KB 	    1000562 	 
22:	00001967.jpg 	       3 KB 	    1007602 	 
23:	00001975.jpg 	      17 KB 	    1011443 	 
24:	00002368.jpg 	      16 KB 	    1212911 	 
25:	00002401.jpg 	      16 KB 	    1229816 	 
26:	00002435.jpg 	      10 KB 	    1247183 	 
27:	00002456.jpg 	      16 KB 	    1257632 	 
28:	00002488.jpg 	       3 KB 	    1274241 	 
29:	00002495.jpg 	      29 KB 	    1277556 	 
30:	00002554.jpg 	      17 KB 	    1307793 	 
31:	00000000.png 	      72 KB 	          0 	  (681 x 498)
32:	00000297.png 	      97 KB 	     152544 	  (439 x 289)
33:	00000492.png 	     100 KB 	     251963 	  (640 x 455)
34:	00000808.png 	     145 KB 	     414115 	  (900 x 900)
35:	00001297.png 	      59 KB 	     664443 	  (400 x 400)
36:	00001494.png 	     174 KB 	     765398 	  (640 x 600)
37:	00002010.png 	     179 KB 	    1029126 	  (490 x 309)
Finish: Mon Apr  5 14:47:11 2021

38 FILES EXTRACTED
	
jpg:= 31
png:= 7
------------------------------------------------------------------

Foremost finished at Mon Apr  5 14:47:11 2021
``` 

Il y a beaucoup de photos à l'intérieur, j'ouvre donc les images une à une et je tombe sur le flag:
![Joker - P'Hack'21](/files/phack21/raid-dead-redemption/flag.jpg)

## Flag

**PHACK{R41d_1s_N1cE_7hANk_U2_m4s7ok_3000!!}**