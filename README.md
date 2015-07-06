##Locale::Maketext Workshop

### How to setup your enviroment

From the base directory you should be able to see

    bin/
    lib/
    templates/
    README.md
    cpanfile

Follow these steps in order to get your application running...

    cpanm --installdeps . # install the app's dependencies
    perl ./bin/app.pl # Run the app

You should see this output, try going to the URL given to see a hello world message!

    MyApp: You can connect to your server at http://localhost:5005/

### Task

Translate "Hello World" in the <i>templates/index.html.tt</i> file into something else dynamically using [Locale::Maketext](http://perldoc.perl.org/Locale/Maketext.html).
The code you require already exists in the repo, you just need to wire it up!

#### Instructions

Now that you have your application up and running, you should try to add some simple translations in order to internationalise your website!
Take a look at the doc for [Locale::Maketext](http://perldoc.perl.org/Locale/Maketext.html) - The contents of the "Quick Overview" should be enough to get your translation dream off the ground.

Tip:

    1. Look in lib/MyApp/I18N/
    2. Look at the method we are passing into template toolkit in the index method of MyApp
