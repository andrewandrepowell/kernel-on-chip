MISC_DIR = ../../../misc
CROSSGEN = python2 $(MISC_DIR)/gencross.py

CPU_BUS_FLAGS = \
	--slave_count 1 --master_count 3 \
	--address_width 32 --data_width 32 --slave_id_width 0 \
	--slave_names cpu --master_names boot_bram ip cpuid_gpio \
	--master_base_addresses 00000000 01000000 f0000000 \
	--master_high_addresses 0000ffff efffffff f000ffff

INTERCONNECT_FLAGS = \
	--slave_count 3 --master_count 6 \
	--address_width 32 --data_width 32 --slave_id_width 0 \
	--slave_names cpu_0 cpu_1 cpu_2 --master_names ram int timer gpio uart lock \
	--master_base_addresses 01000000 02000000 02010000 02020000 02030000 02040000 \
	--master_high_addresses 01ffffff 0200ffff 0201ffff 0202ffff 0203ffff 0204ffff

all: cpu0_bus cpu1_bus cpu2_bus interconnect

cpu0_bus: 
	$(CROSSGEN) --cross_name cpu_0 $(CPU_BUS_FLAGS)

cpu1_bus: 
	$(CROSSGEN) --cross_name cpu_1 $(CPU_BUS_FLAGS)

cpu2_bus: 
	$(CROSSGEN) --cross_name cpu_2 $(CPU_BUS_FLAGS)

interconnect: 
	$(CROSSGEN) --cross_name interconnect $(INTERCONNECT_FLAGS)


