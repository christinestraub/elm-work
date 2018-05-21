Hi,

I am CTO for a small web- based business which has used React for front end development since 2014. Obviously things move fast in the Javascript space, and it has come to our attention that our front end development stack has fallen some way behind "best practices" in this area. In particular -

- we use head.js to build the project, not npm
- we don't use webpack or any alternative bundler
- we don't use jsx, es6, babel or redux

In short - things work, but they are quite primitive :-)

We are in the process of reviewing our front end development stack, and in particular whether to move to -

- vue.js 
- Elm

To this end, we have assembled a sample project which illustrates how we currently do things (see attached zipfile). To run the project -

- add username/password combo to /fixtures/users.json
- python27 server.py
- goto http://localhost:8080/
- login with username/password
- try toggling the 'league' selector
- try switching between different tabs
- you should see different data for each league/tab combination

The main table has the following features -

- sorter (try clicking on table header)
- row selector/highlighter (try clicking on row)
- paginator (for data > 20 rows; try clicking on paginator item)

Your task is to refactor this application in either vue.js or Elm. The application is relatively small, all source code residing in /js/app. We will hire one developer for each version, and pay $100 for each version. You may apply for both versions if you wish, but please specify in advance which versions you are applying for.

All versions need to use npm for local Javascript package installation.

The project will be considered complete when the functionality of the version you are working on *exactly* matches the functionality of the demo.

Please ensure you are experienced with vue.j and/or Elm before applying for this project - we don't want people trying to learn on the job.

Thanks!



