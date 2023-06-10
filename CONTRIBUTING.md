# Contributing to ProjectX
Glad to have you on board with me! To ensure your contribution is a great one, make sure to follow these guidelines!
## Contents
* [Intial Thinking](#inital-thinking)
  * [Title and Description](#title-and-description)
  * [Tags and Difficulty](#tags-and-difficulty)
  * [Colour and Language](#colour-and-language)
  * [Content](#content)
* [JSON Format](#json-format)
* [Opening A PR](#opening-a-pr)

## Initial Thinking
Before you proceed with making an app idea and opening a pull request, you will need to think about different aesthetics, difficulty, content and more. You will need to decide on a title, some tags, a description, a colour that will suit the topic, the difficulty, a good language to use, and of course the content itself. Here are some guidelines and examples to get you started:

### Title and Description
The title has to be short and snappy, for example 'Recipe Finder' or 'AI Chatbot'. Try keeping it generic as it is up to the user on how they decide to use it. I recommend only using two words and keeping a maximum of four in the title.
With the description, only use one, decently sized sentence. It shouldn't be too long or too short! It should include the language it uses and a few words on what it actually is. For example, 'A Python app that will allow users to find their favourite recipes with the ingredients they have.' or 'An AI Chatbot built with JavaScript that can generate textual responses with the help of an LLM'. Here is an example:
```json
{
  "title": "Recipe Finder",
  "description": "A Python program that can help users discover and explore new recipes based on their preferences and dietary restrictions!"
}
```

### Tags and Difficulty
Within the tags, make sure to include the language the project will use. Then, pick some key words that describe what the project does. As an example, `python, recipe, food` or `javascript, ai, ml`. You should probably use at least three tags including the language. The more the merrier!
With regards to the difficulty, make sure it is accurate! If you think that most people would not be able to make the project, label it as hard. If most people would have a hard time making the project but eventually would be able to complete it, label it as medium. If most people would brush it off as simple, label it easy. Make sure to ONLY pick from those three difficulties. Here is a full example:
```json
{
  "tags": ["python", "recipe", "cooking", "food"],
  "difficulty": "easy"
}
```

### Colour and Language
As you have probably realised by now, you need to come up with a good language to build the project with. This can be Python, JavaScript, Swift, Ruby, Go, Dart or whatever you think is best for the app. With Python and JavaScript, they must be shortened to `py` or `js` in the `lang` field.
The colour is quite interesting; you need to decide on a good colour (in the form of a hex code) that suits the project. For example, `#F5F5DC` (beige) for a recipe finder or `#00BFFF` (deep sky blue) for an AI chatbot. Here is an example:
```json
{
  "lang": "py",
  "colour": "#F5F5DC"
}
```

### Content
The most important part of the project idea is the content. This will act as an article explaining different frameowkrs, libraries or methods the user can use to build the project. ProjectX does support most markdown (except headings) and you should use backticks to denote code and a double newline character (\n\n) to show a new paragraph.
The content should have 4-5 paragraphs and should include a description of what the project should do and the different features the user could try to implement. You should also remember to put a basic roadmap the user could try to follow. As an example: 'Signup for a recipe API, use `requests` to make an API call, show the data to the user'.

## JSON format
Now that you've got your idea, you should now compile that into the JSON format that can be understood by ProjectX. This is as follows:
```json
{
  "title": "YOUR AWESOME TITLE HERE",
  "tags": ["SOME", "USEFUL", "TAGS", "GO", "HERE"]
  "colour": "#C0105R",
  "difficulty": "DIFFICULTY HERE",
  "lang": "LANGUAGE HERE",
  "description": "PUT THE SHORT DESCRIPTION OF YOUR PROJECT HERE, REMEMBERING TO GIVE IT A GOOD LENGTH.",
  "content": "NOW FOR THE BIG ONE! HERE IS WHERE YOU SHOULD PUT THE LONG CONTENTS OF YOUR PROJECT, MAKING SURE YOU INCLUDE SOME FRAMEOWRKS AND METHODS THE USER CAN USE AND A SIMPLE ROADMAP TO GIVE A WAY OF HOW TO GO AROUND BUILING THE PROJECT."
}
```
Make sure to fill in those fields correctly with the correct name and order. Also remember commas, and to put a comma after the previous project idea. All in all it should look something like this all together:
```json
 {
  "title": "Hangman",
  "tags": ["python", "textual", "games"],
  "colour": "#1E90FF",
  "difficulty": "easy",
  "lang": "py",
  "description": "Engage your users in a thrilling text-based language game where they must guess a secret word, keeping them captivated and eager for more challenges!",
  "content": "Hangman is a popular gamethat challenges users to search through the dictionary in their brain and guess the hidden word correctly! This is a great beginner friendly project and is quite simple to make! All you will need is a large library of words (as a challenge try keeping these in a seperate text file!) and a robust Python program that can display the word with the gaps as underscores, and the infamous diagram of the stickman being hung as you lose more lives!\n\nCreate a file named `main.py` and create a list full of all the words you know; the more the better! Then, using the `random` module you can pick a random word from the list and show it to the user, remembering to not reveal it! Keep track of the letters the user has guessed correctly and keep track of the lives that remain too. As a challenge, try showing the stickman too via ASCII art! Good luck!"
},
{
  "title": "Fitness Tracker",
  "tags": ["javascript", "fitness", "health", "exercise"],
  "colour": "#FF4500",
  "difficulty": "easy",
  "lang": "js",
  "description": "A web-based app that helps users track their fitness activities, set goals, and monitor progress.",
  "content": "A Fitness Tracker app built with JavaScript can provide users with a comprehensive platform to monitor and track their fitness journey. JavaScript's versatility and wide browser support make it an ideal choice for developing an interactive and responsive user interface. The app can leverage JavaScript frameworks like React or Angular to create reusable components for displaying fitness data, such as workout logs, step count, and heart rate measurements. It can integrate with fitness wearables or mobile sensors to gather real-time data. JavaScript's robust charting libraries can be used to visualize progress and display insights. Additionally, the app can incorporate local storage or backend APIs to store user data securely and provide synchronization across devices. Developing the Fitness Tracker app with JavaScript will empower users to take control of their fitness goals in an engaging and interactive way."
},
{
  "title": "Recipe Finder",
  "tags": ["python", "food", "recipes", "cooking"],
  "colour": "#F5DEB3",
  "difficulty": "medium",
  "lang": "py",
  "description": "A Python program that can help users discover and explore new recipes based on their preferences and dietary restrictions!",
  "content": "This Python Recipe Finder app will utilize Python's powerful libraries and frameworks to create a user-friendly recipe discovery platform. By leveraging web scraping techniques via `beautifulsoup` or `selenium`, the app can fetch recipes from various cooking websites and store them in a database. Users can search for recipes based on specific ingredients, cooking time, or dietary preferences. The app can employ natural language processing algorithms to analyze recipe descriptions and provide personalized recommendations. Additionally, the app can include features like user reviews, recipe rating system, and the ability to save favorite recipes for future reference. With Python's flexibility and extensive libraries, building the Python Recipe Finder app will be an exciting project for food enthusiasts and aspiring developers alike!"
},
```

## Opening a PR
Once you have got the JSON format of your project, copy it for later. Fork this repository and in `projects.json`, put a comma at the end of the last project idea and paste yours in after in the `projects` key. Then open your pull request to send your changes upstream! Make sure to note the idea and other info you think I should know about in the PR description. If you have followed all these steps correctly, then you should have your pull request merged soon! Happy contributing :)
