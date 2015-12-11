# docker-icinga2-ci

## Purpose

This Docker Container only serves the purpose of testing the configuration of your monitoring setup. It's purpose is to be spun up by a CI, feed a directory of configuration files and killed again. I did this because all the icinga2 Docker instances on Docker Hub were tagged as latest, and the official Docker container didn't match the version I am currently running.

Therefore no web frontend is being installed, no IDO Database setup is being set up. Only use this to compile/test your configs.

## Usage
Clone the Repository to the machine where docker lives
```bash
git clone https://github.com/TechIsCool/icinga2-ci
cd icinga2-ci
docker build -t "doertedev:icinga2-ci" .
```
### Install Gitlab Runner
Add Gitlab repository
```bash
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash
```
Install the runner software
```bash
apt-get install gitlab-ci-multi-runner
```

Configure gitlab-runner
```bash
sudo gitlab-ci-multi-runner register
```
When prompted answer all the question.
Make sure to select **shell**

To Allow gitlab-runner to Run Docker Containers run
```bash
sudo usermod -aG docker gitlab-runner
```

Register your CI runner to the Job in GitLab

Make sure to place [.gitlab-ci.yml](.gitlab-ci.yml) in the root of your repository on GitLab


#### try commit some changes.


### If you want to run this manually without GitLab
```bash
localbuildcopy=/home/doertedev/icinga2/build
docker run -v $localbuildcopy:/etc/icinga2 doertedev/icinga2-ci:latest
```

**Note:** Make sure you remove your ido-\* files from the features-enabled directory before running the container, otherwise you'll get a build fail.
**Warning: Don't remove them from your production environment

Watch for upcoming releases/branches of this repo (or the equivalent [Docker registry hub repo](https://registry.hub.docker.com/u/doertedev/icinga2-ci/)). More versions of the icinga2 container are coming.


## Contribution

As time passes by you might want to test your stuff against a version which is not being integrated yet. You know the drill: fork & PR.

## Links / Thanks

* [Icinga](https://www.icinga.org) for being powerful.
* [Gitlab-CI](https://about.gitlab.com/gitlab-ci/) for being simple.
* [Jordan's icinga2 Dockerfile](https://registry.hub.docker.com/u/jordan/icinga2/dockerfile/) for providing a good working example of a full stack container.

## License

GPLv3. See [LICENSE](/LICENSE)
