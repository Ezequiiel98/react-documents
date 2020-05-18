#!/usr/bin/env bash
# ingresar npm run <nombre quee le pongas al script en el package>  c (para component)  nombreComponent  o npm run s (para screen) nombreScreen ejemplo: npm runcomponent c mycomponent 

function createComponent {
  dir=$1;
  component=${2^};
  route=src/$dir/$component;

  mkdir -p $route;
  touch $route/index.js $route/index.module.scss
  echo -e "import React from 'react';\n\nimport styles from './index.module.scss';\n\nexport default function $component() {
  return <h1>$component</h1>;\n}" > $route/index.js;
}

if [[ ${1} == 'c' && ${2} != '' ]];
  then 
    dir=components;
    createComponent components ${2};
  elif [[ ${1} == 's' && ${2} != '' ]];
    then
     createComponent screens ${2} ;
  else 
    echo "PARAMETROS INCORRECTOS";
    exit 1
fi 

