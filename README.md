# docker-icinga2

## Purpose

This Docker Container only serves the purpose for testing the configuration of your monitoring setup. It's purpose is to be spun up by a CI, feeded a directory of configuration and killed again. I did this because all the icinga2 Docker instances on Docker Hub were tagged as latest, and the official Docker container didn't match the version I am currently running.

Therefore no web frontend is being installed, no IDO Database setup is being set up. Only use this to compile/test your configs.

## Usage

Make sure you remove your ido-\* files from the features-enabled directory before running the container, otherwise you'll get a build fail.
```bash
yourbuildcopy=/home/doertedev/icinga2/build
docker run -v $yourbuildcopy:/etc/icinga2 doertedev/icinga2
```
**Note:** The example above is for icinga2 while the example below is for icinga2-ci

So, this is it really. Let's assume you're like me and use gitlab-ci, create a shell job runner using the following config:

```bash
rm features-enabled/ido-* &> /dev/null
docker run --rm -v $(pwd)/build:/etc/icinga2 doertedev/icinga2-ci:latest
```

Watch for upcoming releases/branches of this repo (or the equivalent [Docker registry hub repo](https://registry.hub.docker.com/u/doertedev/icinga2-ci/)). More versions of the icinga2 container are coming.

## Notes
Copy the dockerfile to the machine where your docker server lives
```bash
docker build -t "doertedev:icinga2-ci" .
```
To Allow gitlab-runner to Run Docker Containers run
```bash
sudo usermod -aG docker gitlab-runner
```
Install
## Contribution

As time passes by you might want to test your stuff against a version which is not being integrated yet. You know the drill: fork & PR.

## Links / Thanks

* [Icinga](https://www.icinga.org) for being powerful.
* [Gitlab-CI](https://about.gitlab.com/gitlab-ci/) for being simple.
* [Jordan's icinga2 Dockerfile](https://registry.hub.docker.com/u/jordan/icinga2/dockerfile/) for providing a good working example of a full stack container.

## License

GPLv3. See [LICENSE](/LICENSE)
