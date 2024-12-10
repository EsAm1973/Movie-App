# Movie App

## Description
A Flutter project that displays a collection of movies fetched from an API.

## Features
- Create a personal account for user registration and data saving.
- Browse a collection of movies categorized into **Categories**.
- Search for movies by name.
- View detailed information about each movie, including:
  - Name
  - Year
  - Description
  - Rating
  - Watch the **Trailer** of the movie.
- Add movies to your favorites list and save them to your account.
- Toggle between **Dark Mode** and **Light Mode**.
- Save user data, such as:
  - Login information
  - User preferences  
  These settings will persist when reopening the app.

## Requirements and Technologies Used
- **SQLite Database**: To store users and favorite movies.
- **API**: To fetch movie data and details.
- **Cubit State Management**: To manage interactions between the **API**, database, and UI.
- **Animation UI**: For smooth animations on the **HomePage**.
- **SharedPreference**: To store user settings and login details.

## How to Run the Project
### Run the Application
1. Create a new account through the **Sign Up** page.
2. Log in using the **Login** page.
3. Browse movies and search for the ones you like.

### Run the Project Locally
You might encounter the error **Status Code = 429**, indicating that the number of requests for the provided **API Key** has been exceeded. To resolve this issue:
1. Visit this website:  
   [IMDB Top 100 Movies API](https://rapidapi.com/rapihub-rapihub-default/api/imdb-top-100-movies).
2. Create a new account and subscribe to the **API**.
3. Copy your **API Key**.
4. Open the project files and navigate to:  
   **`movie_app\lib\data\api\movie_api.dart`**.
5. Replace the existing **API Key** in the **Headers** with your new **API Key**.
6. Now, you can modify the project and fetch movie data successfully.
