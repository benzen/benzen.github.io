bower install
cp -r bower_components/bootstrap/dist/css .
cp -r bower_components/bootstrap/dist/fonts .
cp -r bower_components/bootstrap/dist/js .
cp -r bower_components/jquery/dist/* js/.
cp -r bower_components/font-awesome/css .
cp -r bower_components/font-awesome/fonts .

jade _layouts/jade --out _layouts --pretty
jekyll serve --watch --drafts
