// pull in desired CSS/SASS files
require( './styles/main.scss' );

// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
mountNode = document.getElementById( 'main' );

var SERVER_HOSTNAME = 'http://localhost:4567';

function postJSON(url, data) {
  data = data || {
    id: 'test-id-again-5',
    date: '20161217',
    amount: '9999',
    desc: 'lulz',
    category_id: '1',
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

var defaultInitState = {
  seed: randomSeed,
  entries: [],
  categories: []
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

    // elmApp.ports.setStorage.subscribe(function (state) {
    //   // localStorage.setItem('appState', JSON.stringify(state));
    //   console.log(state);
    //   // postJSON();
    //   // getJSON();
    // });

    // elmApp.ports.persistNewTransaction.subscribe(function (json) {
    //   // localStorage.setItem('appState', JSON.stringify(state));
    //   // console.log(JSON.stringify(state));
    //   // do this with elm json.decode instead of js json.stringify:
    //   console.log(json);
    //   console.log(typeof json);
    //   postJSON(SERVER_HOSTNAME + '/transactions/new', json);
    //   // getJSON();
    // });

    elmApp.ports.consoleLog.subscribe(function(json) {
      console.log(json);
    });

    elmApp.ports.selectOnClick.subscribe(function(id) {
      document.getElementById(id).select();
    });

  };
  xhr.send();
})();

// var storedState = localStorage.getItem('appState');
// var startingState = storedState ? JSON.parse(storedState) : defaultInitState;
// startingState['seed'] = randomSeed;



