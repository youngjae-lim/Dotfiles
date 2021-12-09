#!/bin/sh

filename=$1
target="$(dirname "${filename}")/pdf"
outputFile="$(basename "$filename" .md).pdf"

mkdir -p "$target"

pandoc "$filename" \
	--pdf-engine=xelatex \
	-V CJKmainfont="Noto Sans KR" \
	-V geometry:letterpaper \
	-V goemetry:margin=1in \
	-o "$target/$outputFile" &
