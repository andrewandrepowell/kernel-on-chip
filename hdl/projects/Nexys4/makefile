MISC_DIR = ../../../../axiplasma/misc
CROSSGEN = python2 $(MISC_DIR)/gencross.py

CPU_BUS_FLAGS = \
	--slave_count 1 --master_count 5 \
	--address_width 32 --data_width 32 --slave_id_width 0 \
	--slave_names cpu --master_names  ip cpuid_gpio int signal timer \
	--master_base_addresses 00000000 f0000000 f0010000 f0020000 f0030000 \
	--master_high_addresses efffffff f000ffff f001ffff f002ffff f003ffff

INTERCONNECT_FLAGS = \
	--slave_count 3 --master_count 7 \
	--address_width 32 --data_width 32 --slave_id_width 0 \
	--slave_names cpu_0 cpu_1 cpu_2 --master_names boot_bram ram int timer gpio uart lock \
	--master_base_addresses 00000000 10000000 20010000 20020000 20030000 20040000 20000000 \
	--master_high_addresses 0000ffff 1fffffff 2001ffff 2002ffff 2003ffff 2004ffff 2000ffff

all: cpu0_bus cpu1_bus cpu2_bus interconnect

cpu0_bus: 
	$(CROSSGEN) --cross_name cpu_0 $(CPU_BUS_FLAGS)

cpu1_bus: 
	$(CROSSGEN) --cross_name cpu_1 $(CPU_BUS_FLAGS)

cpu2_bus: 
	$(CROSSGEN) --cross_name cpu_2 $(CPU_BUS_FLAGS)

interconnect: 
	$(CROSSGEN) --cross_name interconnect $(INTERCONNECT_FLAGS)


