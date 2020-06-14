#!/usr/bin/env bash
# ingresar npm run <nombre quee le pongas al script en el package>  c (para component)  nombreComponent  o npm run s (para screen) nombreScreen ejemplo: npm run component c mycomponent 
# if you use it  as script  in  your package.json enter npm run <name-script> <c> <component-names> or npm run <s> <screen-names>. 
# Example: npm run cc c my-component

COLOR_ERROR='\033[1;91m';
COLOR_SUCCESS='\033[1;92m';
COLOR_ROUTE='\033[1;34m';

function createComponent() {
  dir=$1;
  component=${2^};
  route=src/$dir/$component;

  if [ -d $route ];
    then
      echo -e  "${COLOR_ERROR}Error $component already exists in ${COLOR_ROUTE}$route";
    else
      mkdir -p $route;
      touch $route/index.js $route/index.module.scss
      echo -e "import React from 'react';\n\nimport styles from './index.module.scss';\n\nexport default function $component() {
      return <h1>$component</h1>;\n}" > $route/index.js;
      echo -e  "${COLOR_SUCCESS}$component successfully created in ${COLOR_ROUTE}$route";
  fi
}

function createComponents() {
 dir=$1; 
 shift; #delete screen or component
 shift; # delete option s or c 
 components=$@;
 
 if [[ ${components} == '' ]];
  then
   echo -e "${COLOR_ERROR}${0} require one or more components/screen names.\nTry ${0} 'help' for more information.";
   exit 1;
  fi

 for component in $components
   do 
     createComponent $dir $component;
   done;

 exit 0;
}

case "$1" in
    c)createComponents components $@;;
    s)createComponents screens $@;;
    help) echo -e "OPTIONS:\n 1) c <component-name>\n 2) s <screen-name>";;
    *) echo -e "${COLOR_ERROR}Invalid option -- '${1}'.\nTry 'help' for more information";;
esac

