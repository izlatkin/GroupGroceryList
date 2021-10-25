Original App Design Project - README Template
===

# Groceries Galore

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
An app that allows users to add members to a group, create shared grocery lists, and share recipes. Would prevent families or roommates from buying the same groceries or forgetting groceries.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Personal/Social Media
- **Mobile:** This app is intended entirely for mobile since people would not be bringing laptops or desktop computers with them to go grocery shopping.
- **Story:** Allows families, roommates, or any group of people to share a grocery list, allowing all members of the group to add to the list as well as know what needs to still be picked up. Also allows users to connect by sharing recipes.
- **Market:** Families, groups of roomates / friends, people who enjoy cooking. The primary age group is college aged students with roommates, but people of all ages could use the app.
- **Habit:** Multiple times per day when adding items, 1-2 times per week when going shopping
- **Scope:** We will begin by using the Walmart API to possibly show pictures of the items on the grocery list, but it could possibly evolve to include several different types of grocery stores or even youtube for how-to videos for the recipes shared on the app.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Users can search a grocery API and add items to their personal list and mutually shared lists.
* Users can create a profile and add other app users to a group in which a mutually shared grocery list is present.
* Grocery items can be added, removed, and notes/comments can be added for each item.
* As user shops, can move collected items to a separate list to differentiate between items that still need to be collected.
 


**Optional Nice-to-have Stories**

* Direct messaging features
* Maps API to find grocery stores nearby
* Scanning receipts and pulling total cost from it.
* Tracking how much money users in a group spend on groceries

### 2. Screen Archetypes

* Login/Sign Up
   * When opening the app for the first time, the user needs to choose to either login to an existing account or sign-up for a new account.
* Personal Profile Screen
   * User will see their profile picture, name, groups they are in, have the option to add a group, and see what groups they are invited to.
   *When user clicks on a specific group, they are taken to another screen:Individual Group View
     *In individual Group View, the user can see the members of a specific group and has the option to add members
* My Lists Screen
   *User sees the lists they are a part of, has the option to create a new list.
   *When user clicks on a specific list they are taken to the Specific List View screen
      *User has the ability to see what needs to be bought, what has already been picked up, and can move things from one side to the other. User can also add items to the list
   
* Share/Find Recipes (Optional)
   *User can see recipes other users have shared, the rating recipes have recieved, as well as share their own recipe
   *Ingredients View
      *Shows necessary ingredients for a recipe and gives the user the option to add ingredients to a specifc list
        *The user gets a drop-down option of which list to add it to as well as the option to create a new list
* Settings Screen
   *Allows the user to change their profile name, password, image, and viewing mode  
* Messaging Screen (optional)
   * Allows the user to direclty message other users of the app 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* My Profile
* My Lists
* Settings

**Optional Navigation**
* Shared Recipes
* Direct Messaging
**Flow Navigation** (Screen to Screen)

* Login/Signup -> After successful login, user is taken to My Profile Screen with tab bar at the bottom
* My Profile -> Individual Group View
* Shared Recipes-> Ratings Section and Recipe View -> Drop down view of lists
* Messaging Screen -> Individual Direct Messages

## Wireframes
[Paper_wireframe.pdf](https://github.com/izlatkin/GroupGroceryList/files/7412876/Paper_wireframe.pdf)


### [BONUS] Digital Wireframes & Mockups
![Grocery List](https://user-images.githubusercontent.com/88288108/138754194-97716823-2abe-4a4d-8d7e-05694fd00b12.png)


### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]