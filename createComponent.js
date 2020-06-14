const fs = require('fs');
const option = process.argv[2]
const component = process.argv[3];
const COLOR_SUCCESS = "\x1b[32m";
const COLOR_ERROR = "\x1b[31m";

const capitalizeFirstLetter = string => string.charAt(0).toUpperCase() + string.slice(1);

const createComponent =  (component, route, dir) => {
  const contentComponent = `import React from react;\n\nimport styles from './index.module.scss';\n\nexport default function ${component}(){\n  return <h1>${component}</h1>;\n}`;
  
  fs.mkdirSync(route, { recursive: true }, (err) => {
    if (err) throw err;
  });

  fs.writeFile(`${route}/index.js`, contentComponent, (err) => {
    if (err) throw err;
    console.log(COLOR_SUCCESS, `${component} creado con exito en src/${dir}/${component}`);
  });
  
  fs.writeFile(`${route}/index.module.scss`, '', (err) => { 
    if(err) throw err;
  });
}

const existDirectory = (option, name) => {
  const dir = (option === '-c') ? 'components' : 'screens';
  const component = capitalizeFirstLetter(name);
  const route = `${__dirname}/src/${dir}/${component}`;
  const exist = fs.existsSync(route);
  
  if(exist) return  console.log(COLOR_ERROR, `Error ${component} ya existe`); 
  return createComponent(component, route, dir);
}

const init = () => {
  if( component  && (option === '-c' || option === '-s') ) return existDirectory(option, component);
  console.log(COLOR_ERROR, 'PARAMETROS INCORRECTOS O INCOMPLETOS');
}

init();
