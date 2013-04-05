find . -name "*.py" ! -name "conf.py" ! -name "davitpydoc.py" | xargs rm -f
find . -name "*.pyc" | xargs rm -f
find . -name "*.rst" -o -name ".*.rst" | xargs rm -f

python davitpydoc.py

make clean html

