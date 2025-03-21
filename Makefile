.PHONY: all clean

CC = xelatex
SRC_DIR = src
ASSETS_DIR = assets
OUTPUT_DIR = out
RESUME_SRCS = $(shell find $(SRC_DIR)/resume -name '*.tex')
CV_SRCS = $(shell find $(SRC_DIR)/cv -name '*.tex')
TEXINPUTS = TEXINPUTS=.:$(SRC_DIR):$(ASSETS_DIR):

# Default target builds all documents
all: $(OUTPUT_DIR)/resume.pdf $(OUTPUT_DIR)/cover_letter.pdf

# Create output directory if it doesn't exist
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Ensure assets directory exists
$(ASSETS_DIR):
	mkdir -p $(ASSETS_DIR)

# Build resume
$(OUTPUT_DIR)/resume.pdf: $(SRC_DIR)/resume.tex $(RESUME_SRCS) | $(OUTPUT_DIR)
	$(TEXINPUTS) $(CC) -output-directory=$(OUTPUT_DIR) $<
	$(TEXINPUTS) $(CC) -output-directory=$(OUTPUT_DIR) $<  # Run twice for references

# Build CV
$(OUTPUT_DIR)/cv.pdf: $(SRC_DIR)/cv.tex $(CV_SRCS) | $(OUTPUT_DIR)
	$(TEXINPUTS) $(CC) -output-directory=$(OUTPUT_DIR) $<
	$(TEXINPUTS) $(CC) -output-directory=$(OUTPUT_DIR) $<  # Run twice for references

# Build cover letter
$(OUTPUT_DIR)/cover_letter.pdf: $(SRC_DIR)/cover_letter.tex $(ASSETS_DIR) | $(OUTPUT_DIR)
	$(TEXINPUTS) $(CC) -output-directory=$(OUTPUT_DIR) $<

# Clean built files
clean:
	rm -rf $(OUTPUT_DIR)/*.pdf $(OUTPUT_DIR)/*.aux $(OUTPUT_DIR)/*.log $(OUTPUT_DIR)/*.out
