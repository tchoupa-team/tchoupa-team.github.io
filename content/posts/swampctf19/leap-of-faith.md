---
title: "LEAP-OF-FAITH"
chall_name: "Leap of Faith"
category: "forensic"
description: ""
date: 2021-06-18T20:42:02-07:00
weight: 20
draft: false
info: ""
points: "499"
author: "ChapeauR0uge"
---
# Leap of Faith

## Description

![leap_of_faith - SwampCTF'19](/files/swampctf19/leap-of-faith/pres.png)

## Résolution

D'apres la description, il s'agit d'une citation du film matrix, avec comme particularité de nous parler d'outils de stego, avec une [image de neo](/files/swampctf19/leap-of-faith/leap_of_faith.jpg).

La première chose que je fais, c'est une verification du type de fichier :
```bash
file leap_of_faith.jpg
```
![step1 - SwampCTF'19](/files/swampctf19/leap-of-faith/step1.png)

Rien d'anormale dans le fichier, il correspond bien à son type.

J'essaye donc d'extraire les données exif de l'image.
```bash
exiftool leap_of_faith.jpg
```

![step2 - SwampCTF'19](/files/swampctf19/leap-of-faith/step2.png)

Je remarque la présence d'un thumbnail, que j'extrais de la manière suivante:
```bash
exiftool -b -ThumbnailImage leap_of_faith.jpg > thumb1.jpg
```
J'obtiens une image de Morpheus.

![morpheus - SwampCTF'19](/files/swampctf19/leap-of-faith/thumb1.jpg)

Je répète l'opération précédente
```bash
exiftool thumb1.jpg
```
![step3 - SwampCTF'19](/files/swampctf19/leap-of-faith/step3.png)

```bash
exiftool -b -ThumbnailImage thumb1.jpg > thumb2.jpg
```
Nous obtenons le flag, sous forme de fichier jpg.

![flag - SwampCTF'19](/files/swampctf19/leap-of-faith/thumb2.jpg)

## Flag

**flag{FR33_Y0UR_M1ND}**
