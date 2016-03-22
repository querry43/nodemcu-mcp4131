export NODEMCU_UPLOADER ?= nodemcu-uploader
export PORT ?= 
export SPEED ?= 

all:

terminal:
	$(NODEMCU_UPLOADER) $(SPEED) $(PORT) terminal

restart:
	$(NODEMCU_UPLOADER) $(SPEED) $(PORT) node restart

upload:
	$(NODEMCU_UPLOADER) $(SPEED) $(PORT) upload --compile *.lua

.PHONY: all terminal restart upload
