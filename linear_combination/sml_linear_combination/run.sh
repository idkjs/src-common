#!/bin/sh

if [ $# -ne 0 ]; then
  echo "Usage: $0 <noargs>"
  exit 1
fi

export OS=$(uname -s)
TARGET_SNAKE=$(basename $(pwd) | sed -e 's/^[^_]*_//')
LANGUAGE=$(basename $(pwd) | awk -F_ '{print  $1}')
EXT=sml
EXAMPLE_CAMEL=elpmaxE
EXAMPLE_SNAKE=elpmaxe

if [ -f /usr/bin/python2 ]; then
  TARGET_CAMEL=$(python2 ../../snakeToCamel.py ${TARGET_SNAKE})
else
  TARGET_CAMEL=$(python ../../snakeToCamel.py ${TARGET_SNAKE})
fi

rm -f ${TARGET_SNAKE}.exe

which mosmlc > /dev/null 2>&1
MOSML_FLAG=$?

which mlton > /dev/null 2>&1
MLTON_FLAG=$?

if [ -f ${TARGET_SNAKE}.${EXT} ]; then
  if [ ! -f Makefile ]; then
    echo "No Makefile exists."
    exit 1
  fi
  if [ "$(uname -s)" = "FreeBSD" ]; then
    if [ ${MLTON_FLAG} -eq 0 ]; then
      gmake mlton
    else
      gmake
    fi
  else
    if [ ${MLTON_FLAG} -eq 0 ]; then
      make mlton
    else
      make
    fi
  fi
  RC=$?
  if [ $RC -eq 0 ]; then
    if [ ! -f ${TARGET_SNAKE}.exe ]; then
      echo "No ${TARGET_SNAKE}.exe exists."
      exit 2
    fi
    ./${TARGET_SNAKE}.exe
    RC=$?
    if [ $RC -eq 0 ]; then
      echo > /dev/null
    else
      echo "${TARGET_SNAKE}.exe execution failure."
    fi
  else
    echo "${TARGET_SNAKE}.exe build failure."
  fi
else
  EXAMPLE_CAMEL=$(echo ${EXAMPLE_CAMEL} | rev)
  EXAMPLE_SNAKE=$(echo ${EXAMPLE_SNAKE} | rev)
  echo -n "No src file found, would you like a copy of the linear_combination src (y/n)? "
  OLD_STTY_CFG=$(stty -g)
  stty raw -echo
  #ANSWER=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
  ANSWER=$(head -c 1)
  stty ${OLD_STTY_CFG}
  if echo ${ANSWER} | grep -iq "^y" ; then
    echo
    cp ../../${EXAMPLE_SNAKE}/${LANGUAGE}_${EXAMPLE_SNAKE}/${EXAMPLE_SNAKE}.${EXT} ${TARGET_SNAKE}.${EXT}
    if [ "$(uname -s)" = "FreeBSD" ]; then
      sed -ir ' '  "s/${EXAMPLE_SNAKE}/${TARGET_SNAKE}/g" ${TARGET_SNAKE}.${EXT}
    else
      sed -e -i "s/${EXAMPLE_SNAKE}/${TARGET_SNAKE}/g" ${TARGET_SNAKE}.${EXT}
    fi
  else
    echo
  fi
fi

exit 0
