Nachos
================================

**This is not maintained and not useful.  Use [preflight](https://github.com/rsanheim/preflight). instead**


Because everyone loves Nachos!

Sync your watched repos with Github.  Manage them.  Never leave net access again without all the codes you care about, local.

Getting Started
================================

* Setup your local Github setup -- follow the [Github guide](http://help.github.com/set-your-user-name-email-and-github-token/)
* Run

    nachos sync

Magic - it is now up to date in "~/src" (by default) and ready to go

Release
================================
* bump version in version.rb
* commit and push
* run `rake release` to tag, push, and push gem

Note on Patches/Pull Requests
================================
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
--------------------------------
Copyright (c) 2012 Rob Sanheim. See LICENSE for details.
