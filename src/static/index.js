// pull in desired CSS/SASS files
require( './styles/main.scss' );

// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
mountNode = document.getElementById( 'main' );
// generate initial seed for uuid generation
var randomSeed = Math.floor(Math.random()*0x0FFFFFFF);
Elm.Main.embed(mountNode, randomSeed);
