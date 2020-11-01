import 'js-autocomplete/auto-complete.css';
import autocomplete from 'js-autocomplete';

const autocompleteSearch = () => {
  console.log("hello from autocomplete out")
  const users = JSON.parse(document.getElementById('search-data').dataset.users)
  const searchInput = document.querySelector('.search-input');

  if (users && searchInput) {
    console.log("hello from autocomplete in")
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      source: function(term, suggest){
          term = term.toLowerCase();
          const choices = users;
          const matches = [];
          for (let i = 0; i < choices.length; i++)
              if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
          suggest(matches);
      },
    });
  }
};

export { autocompleteSearch };
