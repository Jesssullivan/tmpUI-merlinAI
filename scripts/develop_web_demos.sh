#!/bin/bash

# A cringy build script for web demos
#
# Includes launchers for both Debian & Mac OSX


# stdout to these log files instead of to the console
FLASKLOG=flask.log
PACKLOG=pack.log

#  bash --> browser:
DEBBROWSER=google-chrome
MACBROWSER=open

# check python path:
VENVPATH=$(which python3)


## precheck ##


# check node modules:
if [[ ! -d "./node_modules" ]] ; then

  echo -e "\n ...did not find ./node_modules!
  please install node node depends, e.g.


  npm install


  ...and try again. \n"

  exit 0

fi


# make sure we actually in the right venv:
if [[ ! $VENVPATH == *_venv/bin/* ]] ; then

  echo -e "\n  ...venv path not contain identified!
  please source into venv and try again, e.g. \n

    # create new venv:
    python3 -m venv merlinai_venv

    # source:
    source merlinai_venv/bin/activate

    # install Python depends:
    pip3 install -r requirements.txt
    \n"

  exit 0

fi


## build ##


# use a trap to make sure we quit child processes,
# upon receiving ` ^C `
# (e.g. flask @ `stdin`)
trap "kill 0" EXIT

# lol
echo """
      ___  ___          _ _        ___ _____
      |  \/  |         | (_)      / _ |_   _|
      | .  . | ___ _ __| |_ _ __ / /_\ \| |
      | |\/| |/ _ | '__| | | '_ \|  _  || |
      | |  | |  __| |  | | | | | | | | _| |_
      \_|  |_/\___|_|  |_|_|_| |_\_| |_\___/

     """

echo "development: ...entering & packing demos, this could take a while..."

echo -ne  '(#                              (5%)\r'

# initialize log files if they aren't already there:
touch $FLASKLOG
touch $PACKLOG

# copy web assets if they aren't already there:
# cp -rf ./icons/tmpUI.MerlinAI-favicon-light/* ./demos/ &> $FLASKLOG &
cp -rf ./icons/tmpUI.MerlinAI-favicon-dark/* ./demos/ &> $FLASKLOG &
# cp -rf ./icons/Leaflet.annotation-favicon-dark/* ./demos/ &> $FLASKLOG &


## webpack ##


# run primary webpack within its own process, really does takes while
webpack --config webpack/es6.demo.config.ts &> $PACKLOG &

# relax, and watch this chintzy loading graphic load while webpack runs
sleep 2
echo -ne '(##                            (10%)\r'
sleep 2
echo -ne '(####                         (15%)\r'
sleep 2
echo -ne '(#####                        (20%)\r'
sleep 2
echo -ne '(######                       (25%)\r'
sleep 2
echo -ne '(#######                      (30%)\r'
sleep 2
echo -ne '(########                     (35%)\r'
sleep 2
echo -ne '(#########                    (40%)\r'
sleep 1
echo -ne '(##########                   (45%)\r'

# wait for initial webpack to finish:

echo -ne '(###########                  (50%)\r'

wait

echo -ne '(###########                  (50%)\r'

echo -e "development: ...entering & packing annotators..."

echo -ne '(############                 (55%)\r'

echo "development: ...packing leaflet annotator tool..."

webpack --config webpack/webpack.annotator_tool.js &> $PACKLOG &

echo -ne '(#############                (60%)\r'

echo "development: ...packing photo annotator..."

echo -ne '(##############                (65%)\r'

# webpack --config webpack/webpack.annotator_photo.ts &> $PACKLOG &

echo -ne '(###############              (70%)\r'

echo "development: ...packing audio annotator..."

echo -ne '(################             (75%)\r'

# webpack --config webpack/webpack.annotator_audio.ts &> $PACKLOG &


## Flask ##


echo -ne '(#################            (80%)\r'

echo "development: ...packing done!"

echo -ne '(##################           (80%)\r'

echo "development: ...(re)rendering html pages..."

echo -ne '(##################           (80%)\r'

find '.' -name "*_render.html" -delete &> $PACKLOG &

echo -ne '(###################          (85%)\r'

wait

echo -ne '(###################          (85%)\r'

echo "development: setting up flask..."

echo -ne '(###################          (85%)\r'

rm -rf __pycache__/ &> flask.log &


## launch ##


echo -ne '(#####################        (90%)\r'

flask run &> flask.log &

echo -ne '(##########################   (90%)\r'

echo 'development: Launching...'

echo -ne '(##########################   (95%)\r'

if [[ "$OSTYPE" == "darwin"* ]] ; then

  echo -ne '(######################### (100%)\r'

  echo -e "\ndevelopment: Detected fruit-based operating system, using browser cli" $MACBROWSER "\n"

  echo -ne '(######################### (100%)\r'

  BROWSER=$MACBROWSER

else

  echo -ne '(######################### (100%)\r'

  echo -e "\n\ndevelopment: Detected penguin-based operating system, using browser cli " $DEBBROWSER "\n"

  echo -ne '(######################### (100%)\r'

  BROWSER=$DEBBROWSER

fi

# just to make sure disk catches up to us:
sleep 2

# launches in browser:
$BROWSER http://127.0.0.1:5000/

# check status like this:
# ps aux | grep flask
# echo -e "\nExiting Merlin AI Web Demos..."

wait
