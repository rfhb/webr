LIBJQ_VERSION = 1.6
LIBJQ_TARBALL = $(DOWNLOAD)/LIBJQ-$(LIBJQ_VERSION).tar.gz
LIBJQ_URL = https://github.com/jqlang/jq/releases/download/jq-$(LIBJQ_VERSION)/jq-$(LIBJQ_VERSION).tar.gz

.PHONY: libjq
libjq: $(LIBJQ_WASM_LIB)

$(LIBJQ_TARBALL):
	mkdir -p $(DOWNLOAD)
	wget $(LIBJQ_URL) -O $@

$(LIBJQ_WASM_LIB): $(LIBJQ_TARBALL) $(EM_PKG_CONFIG_PATH)/zlib.pc
	mkdir -p $(BUILD)/libjq-$(LIBJQ_VERSION)/build
	tar -C $(BUILD) -xf $(LIBJQ_TARBALL)
	cd $(BUILD)/libjq-$(LIBJQ_VERSION)/build && \
	  emconfigure ../configure \
	    --enable-shared=no \
	    --enable-static=yes \
	    --prefix=$(WASM) && \
	  emmake make install
