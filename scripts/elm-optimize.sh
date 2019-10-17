#!/bin/sh

set -e

out="dist/client"

indexfile="public/index.html"
assets="public/assets"
source="src/main.elm"
js="${out}/elm.js"
min="${out}/elm.min.js"

elm make $source --optimize --output=$js $@

uglifyjs $js --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output=$min

cp $indexfile $out
cp -R $assets $out

echo "Compiled size:$(cat $js | wc -c) bytes  ($js)"
echo "Minified size:$(cat $min | wc -c) bytes  ($min)"
echo "Gzipped size: $(cat $min | gzip -c | wc -c) bytes"