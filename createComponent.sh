#!/usr/bin/env bash
# ingresar npm run <nombre quee le pongas al script en el package>  c (para component)  nombreComponent  o npm run s (para screen) nombreScreen ejemplo: npm run component c mycomponent 

function createComponent {
  dir=$1;
  component=${2^};
  route=src/$dir/$component;
 
  if [ -d $route ];
    then
      echo "$component ya existe en $route";
      exit 1;
    else
      mkdir -p $route;
      touch $route/index.js $route/index.module.scss
      echo -e "import React from 'react';\n\nimport styles from './index.module.scss';\n\nexport default function $component() {
      return <h1>$component</h1>;\n}" > $route/index.js;
      echo "** $dir  $component creado en $route/$component **";
  fi
}

if [[ ${1} != '-c' && ${1} != '-s'  || ${2} == ''  ]]; 
  then  
    echo "PARAMETROS INCORRECTOS";
    exit 1;
fi

if [[ ${1} == '-c' ]];
  then 
    dir=components;
    createComponent components ${2};
  elif [[ ${1} == '-s' ]];
    then
     createComponent screens ${2} ;
fi 

