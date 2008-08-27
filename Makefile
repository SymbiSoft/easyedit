UID=0x20003AFF
MAJORVERSION=2
MINORVERSION=01
SRC=./trunk
APPNAME=EasyEdit
SHORTCAPTION=EasyEdit
CAPTION=EasyEdit text editor
SVGICON=./artwork/easyedit.svg
MBMICON=./artwork/easyedit.mbm

ENSYMBLE=./build/ensymble/ensymble.py
PY2SISNG=./build/py2sisng/py2sisng.py
OUTPUTDIR=./release

COMMONOPTS=--uid=$(UID) --appname="$(APPNAME)" --lang=EN --shortcaption="$(SHORTCAPTION)" --caption="$(CAPTION)"

all_3rd_edition:	$(OUTPUTDIR)/easyedit_$(MAJORVERSION).$(MINORVERSION)-3rd.sis
.PHONY: all_3rd_edition

all:	$(OUTPUTDIR)/easyedit_$(MAJORVERSION).$(MINORVERSION)-3rd.sis $(OUTPUTDIR)/easyedit_$(MAJORVERSION).$(MINORVERSION)-2nd.sis $(OUTPUTDIR)/easyedit_$(MAJORVERSION).$(MINORVERSION)-1st.sis
.PHONY: all

$(OUTPUTDIR)/easyedit_$(MAJORVERSION).$(MINORVERSION)-1st.sis: $(SRC)/*
	echo 1

$(OUTPUTDIR)/easyedit_$(MAJORVERSION).$(MINORVERSION)-2nd.sis: $(SRC)/*
	env PATH=.:/usr/bin python "$(PY2SISNG)" $(COMMONOPTS) --version="$(MAJORVERSION).$(MINORVERSION)" $(SRC) $@

$(OUTPUTDIR)/easyedit_$(MAJORVERSION).$(MINORVERSION)-3rd.sis: $(SRC)/*
	python "$(ENSYMBLE)" py2sis $(COMMONOPTS) --version="$(MAJORVERSION).$(MINORVERSION).0" --icon="$(SVGICON)" --vendor=chetbox $(SRC) $@
	@echo "NOTE: Please visit https://www.symbiansigned.com/app/page/public/openSignedOnline.do to self-sign this version"

clean:
	rm -rf $(OUTPUTDIR)/easyedit*.sis
.PHONY: clean
