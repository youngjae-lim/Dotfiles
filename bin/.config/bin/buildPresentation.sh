#!/bin/sh

# This script will turn a markdown file into a pdf presentation
# The pdf presentation will be saved in cwd/presentation directory

filename=$1
target="$(dirname "${filename}")/presentation"
outputFile="$(basename "$filename" .md)_p.pdf"

# Make a presentation directory in the current workding dir that contains the markdown file
mkdir -p "$target"

# Run pandoc command to generate a pdf presentation
pandoc "$filename" \
	--pdf-engine=xelatex \
	-V CJKmainfont="Noto Sans KR" \
	-t beamer \
	-o "$target/$outputFile" &
