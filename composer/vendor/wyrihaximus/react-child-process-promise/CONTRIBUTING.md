# Contributing

Pull requests are highly appreciated. Here's a quick guide.

Fork, then clone the repo:

    git clone git@github.com:your-username/reactphp-child-process-promise.git

Set up your machine:

    composer install

Make sure the tests pass:

    make unit

Make sure the tests pass on all supported PHP versions (requires docker):

    make dunit

Make your change. Add tests for your change. Make the tests pass:

    make dunit && make unit
    
Before committing and submitting your pull request make sure it passes PSR2 coding style, unit tests pass and pass on all supported PHP versions:

    make contrib

Push to your fork and [submit a pull request][pr].

[pr]: https://help.github.com/articles/creating-a-pull-request/

At this point you're waiting on me. I like to at least comment on pull requests
within a day or two. I may suggest some changes or improvements or alternatives.

Some things that will increase the chance that your pull request is accepted:

* Write tests.
* Follow PSR2 (travis will also check for this).
* Write a [good commit message][commit].

[commit]: http://chris.beams.io/posts/git-commit/
