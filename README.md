##Locale::Maketext Workshop

### How to setup your enviroment

I always try to keep all of my application dependencies as local as possible, it is my oppinion 
that this allows for a better understanding of the requirements which saves you from any nasty 
deployment issues later on ( missing dependencies / wrong version etc ect )

From the base directory you should be able to see

    bin/
    lib/
    templates/
    README.md
    cpanfile

Follow these steps in order to get your application running using local dependencies...

    cpanm local::lib # required to use local dependencies
    cpanm -L local --installdeps . # install the app's dependencies into a local directory
    perl -Mlocal::lib=local ./bin/app.pl # Run the app

You should see this output, try going to the URL given to see a hello world message!

    MyApp: You can connect to your server at http://localhost:5005/

### Task

Translate "Hello World" in the <i>templates/index.html.tt</i> file into something else dynamically using [Locale::Maketext](http://perldoc.perl.org/Locale/Maketext.html).
The code you require already exists in the repo, you just need to wire it up!

#### Instructions

Now that you have your application up and running, you should try to add some simple translations in order to internationalise your website!
Take a look at the doc for [Locale::Maketext](http://perldoc.perl.org/Locale/Maketext.html) - The contents of the "Quick Overview" should be enough to get your translation dream off the ground.
