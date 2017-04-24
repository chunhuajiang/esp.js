BASE ?= linux
TARGET ?= target
JS ?= samples/HelloWorld.js
VARIANT ?= release
DEVICE_NAME ?= "ZJS Device"

# JerryScript options
JERRY_BASE ?= $(ZJS_BASE)/deps/jerryscript
EXT_JERRY_FLAGS ?=	-DENABLE_ALL_IN_ONE=ON \
			-DFEATURE_PROFILE=$(ZJS_BASE)/jerry_feature.profile \
			-DFEATURE_ERROR_MESSAGES=OFF \
			-DJERRY_LIBM=OFF

.PHONY: all
ifeq ($(BASE), linux)
all: linux
else ifeq ($(BASE), esp-idf)
all: esp-idf
else ifeq ($(BASE), zephyr)
all: zephyr
else ifeq ($(BASE), liteos)
else
$(error Not support BASE=$(BASE), try 'make help')
endif

.PHONY: usage
usage:
	@echo ""
	@echo "JavaScript Runtime for ESP32 - Build System"
	@echo ""
	@echo "Usage:"
	@echo "      make BASE=<BASE> TARGET=<target>"
	@echo ""
	@echo "Such as:"
	@echo ""
	@echo "      make BASE=linux   TARGET=linux       **Default** " 
	@echo ""
	@echo "      make BASE=esp-idf TARGET=esp32"
	@echo ""
	@echo "      make BASE=zephyr  TARGET=frdm_k64f"
	@echo "      make BASE=zephyr  TARGET=frdm_kw41z"
	@echo "      make BASE=zephyr  TARGET=arduino_101"
	@echo ""
	@echo "Note, you can modify the default BASE and TARGET in top level Makefile"
	@echo ""

.PHONY: help
help: usage

ifeq ($(ROOT_DIR), )
$(error "ROOT_DIR is not set, run 'source .env' first")
else ifneq ($(ROOT_DIR), $(shell pwd))
$(info "--------------------------- Note ---------------------------")
$(info " Your ROOT_DIR is $(ROOT_DIR) " )
$(info " Your current dir is $(shell pwd) " )
$(info "------------------------------------------------------------")
$(info " WARNIGN: please confirm the ROOT_DIR is your exptected dir ")
$(info $(shell sleep 4))
endif


# Build JerryScript as a library (libjerry-core.a)
$(JERRYLIB):
	@echo "Building" $@
	@rm -rf $(JERRY_BASE)/build/$(BOARD)/
	$(MAKE) -C $(JERRY_BASE) -f targets/zephyr/Makefile.zephyr BOARD=$(BOARD) EXT_JERRY_FLAGS="$(EXT_JERRY_FLAGS)" jerry
	mkdir -p outdir/$(BOARD)/
	cp $(JERRY_BASE)/build/$(BOARD)/obj-$(BOARD)/lib/libjerry-core.a $(JERRYLIB)

# Give an error if we're asked to create the JS file
$(JS):
	$(error The file $(JS) does not exist.)


# Update dependency repBASE
.PHONY: update
update:
	@git submodule update --init

# Explicit clean
.PHONY: clean
clean: cleanlocal
ifeq ($(BOARD), linux)
	@make -f Makefile.linux clean
else
	@rm -rf $(JERRY_BASE)/build/$(BOARD)/;
	@rm -f outdir/$(BOARD)/libjerry-core*.a;
	@make -f Makefile.zephyr clean BOARD=$(BOARD);
	@cd arc/; make clean;
endif


# Linux target
.PHONY: linux
# Linux command line target, script can be specified on the command line
linux: 
	make -f $(ROOT_DIR)/make/Makefile.linux JS=$(JS) VARIANT=$(VARIANT) CB_STATS=$(CB_STATS) V=$(V) SNAPSHOT=$(SNAPSHOT)

# esp-idf target
.PHONY: esp-idf
# Linux command line target, script can be specified on the command line
esp-idf: 
	make -f $(ROOT_DIR)/make/Makefile.espidf espidf  JS=$(JS) VARIANT=$(VARIANT) CB_STATS=$(CB_STATS) V=$(V) SNAPSHOT=$(SNAPSHOT)
