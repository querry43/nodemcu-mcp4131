all:

terminal:
	nodemcu-uploader terminal

upload:
	nodemcu-uploader upload *.lua

.PHONY: all terminal upload
