#!/bin/bash

echo "development: packing, this could take a while..."
webpack --config webpack/es6.demo.config.ts

echo -e "development: packing done. \n..."
export FLASK_APP=app.py

echo 'development: starting Flask...'
flask run