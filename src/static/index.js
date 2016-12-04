// pull in desired CSS/SASS files
require( './styles/main.scss' );

// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
mountNode = document.getElementById( 'main' );


// generate initial seed for uuid generation
var randomSeed = Math.floor(Math.random()*0x0FFFFFFF);

var entries = [

    [20161023, [{
        id: "1",
        amount: -17.54,
        description: "stuff",
        category: 3
    }, {
        id: "2",
        amount: -15,
        description: "things",
        category: 1
    }, {
        id: "3",
        amount: 636,
        description: "",
        category: 5
    }]], [20161024, [{
        id: "4",
        amount: -10111.23,
        description: "stuff",
        category: 3
    }, {
        id: "5",
        amount: -71,
        description: "things",
        category: 2
    }, {
        id: "6",
        amount: 4000,
        description: "",
        category: 4
    }, {
        id: "7",
        amount: -75.9,
        description: "",
        category: 2
    }]]

];

var categories = [
  [1, "Rent"], [2, "Groceries"], [3, "Eating out"], [4, "Salary"], [5, "Partner's salary"], [6, "Gifts"]
];

var storedState = localStorage.getItem('appState');
var startingState = storedState ? JSON.parse(storedState) : null;
startingState['seed'] = randomSeed;
var elmApp = Elm.Main.embed(mountNode, startingState);
// var elmApp = Elm.Main.embed(mountNode, {
//   seed: randomSeed,
//   entries: entries,
//   categories: categories
// });

elmApp.ports.setStorage.subscribe(function (state) {
  localStorage.setItem('appState', JSON.stringify(state))
})


