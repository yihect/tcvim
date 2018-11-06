#!/bin/bash

OPWD=$(pwd)
#KDATA=/home/yihect/kdev/kdev_data/kdata
#LNX=/home/yihect/kdev/linux-2.6.32.50
#AD4_4KDATA=/home/tom/code/kdev_data/sprd6_k318_dev
PROJ_KDATA_DIR=/home/tcoracle/code/kdev_data/linus_linux
#AD4_4LNX=/home/tom/code/sprd6_k318_dev/kernel
#AD4_4=/home/tom/code/sprd6_k318_dev
export PROJ_DIR=/home/tcoracle/code/linus_linux


cd $PROJ_KDATA_DIR
while getopts "tc" arg
do
	case $arg in
             t)
		rm -rf $PROJ_KDATA_DIR/tags
                ;;
             c)
		rm -rf $PROJ_KDATA_DIR/cscope.*
		rm -rf $PROJ_KDATA_DIR/tags
                ;;
             ?)  # other
		echo "unkonw argument"
		exit 1
		;;
        esac
done

##################################################################
##sub dirctory of ~/code/4.4#######################################
#
#abi  bionic    build	cts	developers   device  external	 hardware
#libcore	    Makefile  out	pdk	   sdk	   tools   vendor
#art  bootable  chipram	dalvik	development  docs    frameworks  kernel
#libnativehelper  ndk       packages	prebuilts  system  u-boot
#




if [ ! -e $PROJ_KDATA_DIR/cscope.files ]
then
  cd /
  echo "generating src.cscope.files..."
  find $PROJ_DIR						\
   -path "$PROJ_DIR/arch/*" ! -path "$PROJ_DIR/arch/x86*" -prune -o 		\
   -name "*.[chxsS]" -exec readlink -f {} \;  >$PROJ_KDATA_DIR/src.cscope.files
#   -name "*.[chxsS]" -print >$PROJ_KDATA_DIR/src.cscope.files

  echo "generating kconfig.cscope.files..."
  find $PROJ_DIR -name "Kconfig*" -not -wholename "*\.pc*" > $PROJ_KDATA_DIR/kconfig.cscope.files

  echo "generating cscope.files..."
  cat $PROJ_KDATA_DIR/src.cscope.files  > $PROJ_KDATA_DIR/cscope.files
fi

#generating cscope.out...
if [ ! -e $PROJ_KDATA_DIR/cscope.out ]
then
  cd $PROJ_KDATA_DIR
  echo "generating cscope.out..."
  cscope -bkqR -i $PROJ_KDATA_DIR/cscope.files
fi
export CSCOPE_DB=$PROJ_KDATA_DIR/cscope.out

#generating tags...
if [ ! -e $PROJ_KDATA_DIR/tags ]
then
  cd $PROJ_KDATA_DIR
  echo "generating tags..."
  ctags -R -L $PROJ_KDATA_DIR/src.cscope.files -f $PROJ_KDATA_DIR/tags
  ctags -a -f $PROJ_KDATA_DIR/tags -L $PROJ_KDATA_DIR/kconfig.cscope.files \
   --langdef=kconfig --language-force=kconfig              \
   --regex-kconfig='/^[[:blank:]]*(menu|)config[[:blank:]]+([[:alnum:]_]+)/\2/'
  ctags -a -f $PROJ_KDATA_DIR/tags -L $PROJ_KDATA_DIR/kconfig.cscope.files \
   --langdef=kconfig --language-force=kconfig              \
   --regex-kconfig='/^[[:blank:]]*(menu|)config[[:blank:]]+([[:alnum:]_]+)/CONFIG_\2/'
fi
export CTAG_DB=$PROJ_KDATA_DIR/tags

cd $OPWD




