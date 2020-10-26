main_file=main.c
elf_file=main.elf
dump_file=main.dump

all: $(elf_file) $(dump_file)

$(elf_file) : $(main_file)
	@riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 $< -o $@
	@echo "created elf file"

$(dump_file) : $(elf_file)
	@riscv64-unknown-elf-objdump -D $< > $@
	@echo "created dump file"

.PHONY: clean
clean:
	@rm -f $(elf_file)
	@rm -f $(dump_file)
	@echo "deleted elf and dump files"