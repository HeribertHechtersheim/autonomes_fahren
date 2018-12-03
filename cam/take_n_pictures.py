# coding=utf-8
import os
import datetime

date = datetime.datetime.now()

n = int(input("Anzahl an Photos: "))


for i in range(n):
	raw_input("ENTER für Bild " + str(i))
	os.system("raspistill -o " + date.strftime("%d%m%y_%H%M%S") + "_"+ str(i) + ".jpg")
