# docker-icinga2

## Purpose

This Docker Container only serves the purpose for testing the configuration of your monitoring setup. It's purpose is to be spun up by a CI, feeded a directory of configuration and killed again. I did this because all the icinga2 Docker instances on Docker Hub were tagged as latest, and the official Docker container didn't match the version I am currently running.

Therefore no web frontend is being installed, no IDO Database setup is being set up. Only use this to compile/test your configs.

## Usage

Make sure you remove your ido-\* files from the features-enabled directory before running the container, otherwise you'll get a build fail.

`docker run -v $yourbuildcopy:/etc/icinga2 doertedev/icinga2`

## Contribution

As time passes by you might want to test your stuff against a version which is not being integrated yet. You know the drill: fork & PR.

## Links

* [Icinga](https://www.icinga.org)

## License

GPLv3. See [LICENSE](/LICENSE)