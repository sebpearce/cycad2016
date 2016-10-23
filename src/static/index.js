// pull in desired CSS/SASS files
require( './styles/main.scss' );

// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
mountNode = document.getElementById( 'main' );
Elm.Main.embed(mountNode);
