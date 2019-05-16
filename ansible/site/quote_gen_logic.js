var quotes = [
    'hm. I\'ve lost a machine.. literally _lost_. it responds to ping, it works completely, I just can\'t figure out where in my apartment it is. -erno',
    'Be a voice not an echo. – Unknown',
    'You are the only one who can limit your greatness. – Unknown',
    'Make the most of yourself….for that is all there is of you. \– Ralph Waldo Emerson',
    'It takes courage to grow up and become who you really are. \– E.E. Cummings',
    'The two most important days in your life are the day you are born and the day you find out why. – Mark Twain',
    'You can find a better you inside of you. Why don\’t you search for that? \– Munia Khan',
    'It is never too late to be what you might have been. \– George Eliot',
     'Whatever you are, be a good one. – Abraham Lincoln',
    'The true success is the person who invented himself. \– Al Goldstein',
    'Give up on being perfect and start working on becoming yourself. \– Anna Quindlen',
    'Do something today that your future self will thank you for. \– Unknown',
    'Your time is limited, so don\’t waste it living someone else\’s life. \– Steve Jobs',
    'Whatever you do, do with all your might. – Marcus Tullius Cicero'
]

function newQuote(){
    var randomNumber = Math.floor(Math.random() * (quotes.length));
    document.getElementById('quoteDisplay').innerHTML = quotes[randomNumber];
}