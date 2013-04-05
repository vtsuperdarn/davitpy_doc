find . -name "*.py" ! -name "conf.py" ! -name "davitpydoc.py" | xargs rm -f
find . -name "*.pyc" | xargs rm -f
find . -name "*.rst" -o -name ".*.rst" | xargs rm -f

python davitpydoc.py

make clean html

cp -r build/html/_static build/html/static
cp -r build/html/_sources build/html/sources
cp -r build/html/_modules build/html/modules

