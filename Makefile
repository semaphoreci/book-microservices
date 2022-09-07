BUILD = build
BOOKNAME = Monolith_to_Microservices_Handbook
TITLE = title.txt

CHAPTERS = chapters/01-introduction.md \
		    chapters/02-what-are-microservices.md \
			chapters/03-when-microservices-are-a-bad-idea.md \
			chapters/04-how-to-restructure-your-organization-for-microservice.md \
			chapters/05-domain-driven-design.md \
			chapters/06-the-cracking-monolith.md \
			chapters/07-prepare-monolith.md \
			chapters/08-test-microservices.md \
			chapters/09-deploy-microservices.md \
			chapters/10-release-management.md \
			chapters/11-final-words.md

# handle non-intel archs
EXTRA_OPTS =
ARCH = $(shell arch)
ifeq ($(ARCH),arm64)
	EXTRA_OPTS += --platform linux/amd64
endif

all: book 
book: pdf
docx: $(BUILD)/docx/$(BOOKNAME).docx
pdf: $(BUILD)/pdf/$(BOOKNAME).pdf
more: $(BUILD)/pdf/more.pdf

clean:
	rm -r $(BUILD)

$(BUILD)/docx/$(BOOKNAME).docx: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)/docx
	docker run --rm $(EXTRA_OPTS) \
	  --volume `pwd`:/data pandoc/latex:2.19 \
	  -f markdown+implicit_figures \
	  -H make-code-small.tex \
	  -H disable-float-figures.tex \
	  -V geometry:margin=1.0in \
	  -o /data/$@ $^

$(BUILD)/pdf/$(BOOKNAME).pdf: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)/pdf
	docker run --rm $(EXTRA_OPTS) \
	--volume `pwd`:/data pandoc/latex:2.19 \
	-f markdown+implicit_figures \
	-H make-code-small.tex \
	-H disable-float-figures.tex \
	-V geometry:margin=1.0in \
	-o /data/$@ $^

 $(BUILD)/pdf/more.pdf: chapters/12-wait-there-is-more.md
	mkdir -p $(BUILD)/pdf
	docker run --rm $(EXTRA_OPTS) \
	--volume `pwd`:/data pandoc/latex:2.19 \
	-f markdown+implicit_figures \
	-H make-code-small.tex \
	-H disable-float-figures.tex \
	-V geometry:margin=1.0in \
	-V pagestyle=empty \
	-o /data/$@ $^

.PHONY: all book clean pdf html more
