# Recipes

### Summary: Include screen shots or a video of your app highlighting its features
The app fetchs recipes and display them in a list.
![Recipes List](https://raw.githubusercontent.com/yangchen83/Recipes/refs/heads/main/_image/list.png)

User can pull to refresh the list, and also use the cuisine filter on the navigation bar to filter to a specific cuisine type.
![Cuisine Filter](https://raw.githubusercontent.com/yangchen83/Recipes/refs/heads/main/_image/cuisine-filter.png)

Tapping on a recipe will push to the details view, where user can tap to open source website and youtube in web browser.
![Recipe Details](https://raw.githubusercontent.com/yangchen83/Recipes/refs/heads/main/_image/cuisine-details.png)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
1. Get the recipes data and display them correctly, since this is the main purpose of the app.
2. Cache image to disk to avoid unnecessary network calls, since this is the biggest requirement.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
Total time spent 5.5-6 hours.
~1.5 hour to get the data and have a basic list shown
~2.5 hours to make a custom view similar to AsyncImage but cache the image to disk
~1 hour writing tests
~1 hour make the list view better, including adding pull to refresh, cuisine picker, adding a basic details view for navigation destination 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
1. The ImageManager does not have special handling of the case when several requests for the same image url happen at the same time. Currently it would just make multiple requests for the same url, idealy it should only make one. But based on this app current use case, it is unlikely the situation would happen.
2. The image cahcer does not store any meta data about the image usage, and it does not handle removing old images. If the we know the app could fetch a lot of images, some limits on the cache number and size should be implemented. And also some meta data should be stored along with the images, so we know which image to remove when needed. Currently it is just using cachesDirectory, so the system will remove data if needed.

### Weakest Part of the Project: What do you think is the weakest part of your project?
It does not have any styling, it would benefitial to get some input from a designer.
