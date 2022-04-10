FROM armswdev/arm-tools:bare-metal-compilers

RUN git clone --recursive https://github.com/rsta2/circle.git && \ 
	cd circle && \
	mkdir export -pv && \
	./configure --raspberrypi 4 --realtime --prefix aarch64-none-elf- --multicore --c++17 && \
	./makeall clean && \
	./makeall 

WORKDIR /home/ubuntu/circle

VOLUME /home/ubuntu/circle/export

# Or other sample \
CMD cd ./sample/02-screenpixel && \
	# make the sample
	make && \
	\
	# back to root directory
	cd .. && \
	\
	# Copy to export folder
	cp -R ./02-screenpixel ../export && \  
	\
	# boot folder
	cd ../boot && \
	\
	# build firmware
	make && \
	\
	# build "armstub8-rpi4.bin"
	make armstub64 && \
	\
	# back to root directory
	cd .. && \
	\
	# copy boot folder to export folder
	cp -R ./boot ./export && \
	\
	# manually do:
	# 1. copy 02-screenpixel/kernel8-rpi4.img to sd card
	# 2. copy
	# 		armstub8-rpi4.bin
	# 		bcm2711-rpi-4-b.dtb
	# 		bcm2711-rpi-400.dtb
	# 		bcm2711-rpi-cm4.dtb
	# 		bootcode.bin
	# 		config64.txt (rename to config.txt)
	# 		COPYING.linux
	# 		fixup.dat
	# 		fixup4.dat
	# 		fixup4cd.dat
	# 		fixup_cd.dat
	# 		kernel8-rpi4.img
	# 		LICENCE.broadcom
	# 		start.elf
	# 		start4.elf
	# 		start4cd.elf
	# 		start_cd.elf 
	# 	to sd card
	bash



