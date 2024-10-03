xml2rfc ?= xml2rfc
idnits ?= idnits

draft := $(basename $(lastword $(sort $(wildcard draft-*.xml))))
draft_type := xml

current_ver := $(shell git tag | grep '$(draft)-[0-9][0-9]'| tail -1 | sed 's/.*-//')
ifeq "$(current_ver)" ""
next_ver ?= 00
else
next_ver ?= $(shell printf "%.2d" $$((1$(current_ver)-99)))
endif
next := $(draft)-$(next_ver)

.PHONY: all idnits clean

all: $(next).xml $(next).txt $(next).html

idnits: $(next).txt
	$(idnits) $<

clean:
	rm -f $(draft).txt $(draft).html
	rm -f $(next).txt $(next).html
	rm -f $(draft)-[0-9][0-9].xml
	rm -f $(draft)-[0-9][0-9].v2v3.xml

n:
	echo $(next)

$(next).xml: $(draft).xml
	sed -e"s/$(basename $<)-latest/$(basename $@)/" \
	    -e"s/YYYY-MM-DD/$(shell date +%Y-%m-%d)/" $< > $@
	xml2rfc --v3 $@

.INTERMEDIATE: $(draft).xml
%.txt: %.xml
	$(xml2rfc) --v3 $< -o $@ --text
	@if [ "$(next_ver)" -ne "00" ]; then idnits $@; fi

%.html: %.xml
	$(xml2rfc) --v3 $< -o $@ --html
