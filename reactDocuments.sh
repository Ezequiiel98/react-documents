#!/bin/bash
echo  "";
read -p 'Nombre/Ruta del proyecto a crear: ' route;
echo  "";

if [ "$route" ];
  then  
    read -p "Su proyecto usa  Sass (.scss) (Si/No)? " choiceExtensionCss;
    echo  "";
    read -p 'Dependencias: ' dependencies;
    echo  "";
    read -p 'Dependencias de desarrollo: ' devDependencies;
    echo "";
    read -p 'Componentes: ' components;
    echo "";
    read -p "Abrir vscode y correr el proyecto (Si/No) ? " choiceProyect;
    create-react-app $route;
  else 
    echo "Debe ingresar el nombre del proyecto del proyecto";
fi

case "$choiceExtensionCss" in
    Si|si|sI|SI ) 
       extensionCss='module.scss' ;;
   * ) extensionCss='module.css' ;;
esac

# creo carpetas y modifico archivos 
# -d comprueba si el directorio existe
if [ -d $route/src ]; 
  then 
    rm -f  $route/public/logo*;
    
    cd  $route/src;

    mkdir -p components/App assets constants;
    
    ## App.js
    touch components/App/index.${extensionCss};
     
    #borro lineas innecesarias, cambio la ruta del css y agrego un h1 con el nombre del proyecto
    sed -i  "7,23d; 2,3d" App.js; 
    sed -i "s/return (/return <h1> Proyecto ${route} <\/h1>;/" App.js;
    sed -i "1a import styles from \'./index.${extensionCss}'\ " App.js;
    mv App.js components/App/index.js
    
    ## index.js 
    sed -i 's/\/App/\/components\/App/g' index.js;
    #lo guardo en un archivo temporal porque si no no se puede hacer
    head -n 8 index.js | grep -v "serviceWorker" > indexTmp;
    mv indexTmp index.js;
    rm logo* App* se*.js;
fi

if [[ ${extensionCss} ==  'module.scss' ]];
  then  
    npm install node-sass;
fi

#depencencies
if [[ ${dependencies} != '' ]]; 
  then  
    for i in ${dependencies[@]}
      do
      npm install $i  
    done
fi

#devDepencencies
if [[ ${devDependencies} != '' ]]; 
  then  
    for i in ${devDependencies[@]}
      do
       npm install --save-dev $i;
    done
fi

#COMPONENTS
if [[ ${components} != '' ]]; 
  then  
    for i in ${components[@]}
      do
       mkdir -p components/$i;
       touch components/$i/index.{js,"$extensionCss"};
       echo "import React from 'react'; " > components/$i/index.js;
    done
fi



case "$choiceProyect" in
  Si|si|sI|SI ) 
        cd ../; 
        code . ; 
        npm start ;;
  * ) echo "" ;;
esac
