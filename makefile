# title for output, omit file ending
FILE_NAME = Toolbox

# base commands and constants
CONF_DIR = pandoc/
OUT_DIR = out/
PANDOC = pandoc -s -S
TO_PDF = --no-tex-ligatures -t latex
TO_HTML = --self-contained -c $(CONF_DIR)style.css -t html

# configuration of chapters and order
PAGES = \
win_cmd.md \
MsSqlServer.md \
regex.md \
JavaScript.md \
c\#.md \
php.md


PDF_FILES = $(CONF_DIR)title-properties.yaml $(CONF_DIR)style.yaml $(PAGES)
HTML_FILES = $(CONF_DIR)title-properties.yaml $(PAGES)

OUT_PATH = $(OUT_DIR)$(FILE_NAME)

# default target
all: out pdf html

# ensure existence of output dir
out:
	mkdir $@

pdf:
	$(PANDOC) $(PDF_FILES) $(TO_PDF) -o $(OUT_PATH).pdf

html:
	$(PANDOC) $(HTML_FILES) $(TO_HTML) -o $(OUT_PATH).html

# clean output folder
clean:
	rm $(OUT_DIR)*.*