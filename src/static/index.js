// pull in desired CSS/SASS files
require( './styles/main.scss' );

// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
mountNode = document.getElementById( 'main' );

var SERVER_HOSTNAME = 'http://localhost:4567';

function postJSON(url, data) {
  data = data || {
    id: 'test-id',
    date: '20161207',
    amount: '1000',
    desc: '',
    category_id: '2',
  };
  url = url || SERVER_HOSTNAME + '/transactions/new';

  var xhr = new XMLHttpRequest();
  xhr.open('POST', url, true);
  xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');

  xhr.onloadend = function() {
    if (xhr.status === 200) {
      console.log('Successfully created row: ' + xhr.responseText);
    } else {
      console.log('Request failed (' + xhr.status + '). Error: ' + xhr.responseText);
    }
  };

  xhr.send(JSON.stringify(data));
}

function getJSON(url) {
  url = url || SERVER_HOSTNAME;
  var xhr = new XMLHttpRequest();
  xhr.open('GET', url);
  xhr.onloadend = function() {
    if (xhr.status === 200) {
      console.log('Response: ' + xhr.responseText);
    } else {
      console.log('Request failed (' + xhr.status + '). Error: ' + xhr.responseText);
    }
  };

  xhr.send();
}


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

var defaultInitState = {
  seed: randomSeed,
  entries: entries,
  categories: categories
};

function parseAmounts(transactions) {
  newTransactions = transactions.map((day) => {
    var date = day[0];
    var list_of_transactions = day[1];
    return [
      date,
      list_of_transactions.map((t) => {
        t.amount = parseFloat(t.amount);
        return t;
      })
    ];
  });
  return newTransactions;
}

(function getInitState() {
  var startingState;
  var url = SERVER_HOSTNAME;
  var xhr = new XMLHttpRequest();
  xhr.open('GET', url);
  xhr.onloadend = function() {
    if (xhr.status === 200) {
      var res = JSON.parse(xhr.responseText);
      startingState = {
        entries: parseAmounts(res.transactions),
        categories: res.categories,
      }
    } else {
      console.log('Request failed (' + xhr.status + '). Error: ' + xhr.responseText);
      startingState = defaultInitState;
    }
    startingState['seed'] = randomSeed;
    var elmApp = Elm.Main.embed(mountNode, startingState);

    elmApp.ports.setStorage.subscribe(function (state) {
      localStorage.setItem('appState', JSON.stringify(state));
      postJSON();
      // getJSON();
    })
  };
  xhr.send();
})();

// var storedState = localStorage.getItem('appState');
// var startingState = storedState ? JSON.parse(storedState) : defaultInitState;
// startingState['seed'] = randomSeed;



