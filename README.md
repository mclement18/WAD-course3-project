# WAD-course3-project
Course project on Ruby on Rails - third course of the Web Application Development program of the EPFL Extension School

## Project guidelines

### General notes
A User indicates someone who has identified themselves within the application by registering and logging in.

A Visitor indicates anyone visiting the website that has not identified themselves by registering and logging in as well as Users.

### Option 1: Pin you images
Create an application that allows people to create a virtual pinboard for images and photos that they find online. It will be a similar but more basic experience to the popular website Pinterest website

Implement the following features in your application, that allow:

1. Visitors to open a simple static HTML page, about.html, that includes the title of the project option, a brief description of what the website is for and who built it. This page does not need to include any of the bootstrap styling indicated below.
2. Visitors to register and log in as a User with their :email using a basic sign up and log in form. Use a model named User for this task.
3. Users to create Pins that include a :title, an :image_url for the image that they want to “pin", and a :tag, which is a phrase or category relevant to the Pin. Use a model called Pin for this task. The Pin needs to be associated with the User that created it.
4. Visitors to view the six most-recently created Pins on the homepage / root path.
5. Visitors to search for Pins with a search term that will match on either :title or :tag from a form on the homepage. The form should submit in a way that the URL for any particular search can be copied and sent to others.
6. Visitors to view all of the details for a Pin plus all Comments related to that Pin on one view. The :title and :tag should be displayed as text and the :image_url used to display the image at that URL. This view will be linked from the individual Pins displayed on the search results view.
7. Users to edit all details of a Pin by clicking on a link from the “Show pin” view.
8. Users to save new or updated Pins only if a :title is provided i.e. :title is required, and that a :tag is no longer than 30 characters in length, although a :tag is optional. Any validation errors should be displayed helpfully for User.
9. Users to add a comment on a “show pin” view when they are signed in. Use a model named Comment for this task. The Comment needs to be associated with the Pin that it was created from and the User that created it.
10. Users to add any Pin created by any User to their "personal Pin list" from the show Pin view. It should not be possible to add a Pin more than once. Their personal Pin list should be available on a separate view, listing all of the Pins that they’ve saved. A link to the form to create a new Pin needs to be included on this view.
11. Visitors to have a link to the homepage, the about page, and the login/register view in the header of every view.
12. Users to have a link to the homepage, the about page, and their personal pin list in the header of every view.

### Project requirements
The outlines above don't go into as much detail as previous course projects: this is to assess your ability to interpret the project brief and create the appropriate models, controllers, views, and routes based on the guidelines below. In particular, the project submission must demonstrate all aspects of developing with the Ruby on Rails framework taught in this course, including:

* Use of views, partials, and layouts.
* Use of the Rails asset pipeline for CSS rules and images (see CSS, JavaScript and app design below for guidance on what CSS rules you should use)
* Use of the Rails router, including resources.
* Use of controllers, controller actions and the application controller.
* Use of models, associations, and validations.
* Use of automated system and model tests.
* Use of Active Record and database interactions.
* Use of migrations and managing database table structures.

It's also necessary to demonstrate the following principles of software development:

* Good source control management with git.
* Good code structure and reuse.
* Good naming and organisation of automated tests.
* Good code formatting throughout a project codebase.

### CSS, JavaScript and app design
The project does not need to demonstrate CSS techniques, document structure with HTML, or interactive front-ends with JavaScript beyond anything indicated in the project briefs above. The visual layout of views must be clear in order for assessors to understand the functionality but beyond that there are no grades associated with style, HTML structure or use of CSS.


## Ruby version
ruby 2.3.3p222 (2016-11-21 revision 56859) [x86_64-darwin19]
