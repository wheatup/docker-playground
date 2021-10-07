# Hello Docker

1. Install Docker
> https://docs.docker.com/get-docker/

2. Create a `Dockerfile` in your project repository

3. Commands:

```docker
FROM node:14.18.0-alpine3.14
RUN addgroup app && adduser -S -G app app
USER app
WORKDIR /app
COPY package.json .
RUN npm i
COPY . ./
ENV API_URL=http://api.example.com
EXPOSE 3000
ENTRYPOINT ["npm", "start"]
```

## Explain

```docker
FROM node:alpine
```

The environment image of docker, can be `baseImage`, or any images from [docker images](https://hub.docker.com/search?q=node&type=image)

`node` is a node environment runs on Linux, and `alpine` specifies which distribution image of Linux

---

```docker
RUN addgroup app && adduser -S -G app app
```

* Run linux command `addgroup app`: add a group called `app`
* Run linux command `adduser -S -G app app`: add a user called `app` and assign it to group `app`

---

```docker
USER app
```

Set the current user to `app`

---

```docker
WORKDIR /app
```

Similar to `cd` command in linux, this sets the current work directory to `/app`, so all the commands take space using this directory.

---

```docker
COPY package.json .
```

Copy `package.json` to work environment `/app`. We are copying `package.json` first because the next step `RUN npm i` depends on it. If `package.json` is unchanged, the next build of `RUN npm i` can just use the cache so it saves time.

---

```docker
RUN npm i
```

Tells docker to run the command `npm i`

---

```docker
COPY . ./
```

Tells docker to copy all the files as well.

---

```docker
ENV API_URL=http://api.example.com
```

Setup an environment variable called `API_URL`.

---

```docker
EXPOSE 3000
```

Expose the port `3000` from the docker container.

---

```docker
ENTRYPOINT ["npm", "start"]
```

When the build is finished, run `npm start` to start the enviroment.

In contrast, you may run `ENTRYPOINT npm start` but it opens another shell command prompt to run the command. Which for most of the time we don't need it. You may override this entrypoint by running `docker run [container] --entrypoint [command]`.

You may also use `CMD` command to run as an entrypoint but you don't need to specify the `--entrypoint` to override it: `docker run [container] [command]`.

The difference between `CMD`, `ENTRYPOINT` with `RUN` is, `RUN` is for build phase and will only be run when the environment is been built. But `CMD` and `ENTRY POINT` is the only command when the docker image is run.

---

4. Compile the docker image using 

```
docker build -t hello-docker .
```

> `hello-docker` is your project name

5. Check the docker image list

```
docker image ls
```

6. Run the docker image

```
docker run hello-docker
```

# Notes

## Docker Commands

* See all running images

```
docker ps
```

* See all images

```
docker ps -a
```

* Build image

```
docker build -t [tag] [directory]
```

* Run app interactively

```
docker run -it [container]
```

* Start an app runs previously

```
docker ps -a
```

```
docker start -i [CONTAINER_ID]
```

* Start bash in an existing process

```
docker exec -it [CONTAINER_ID] bash
```

```
docker exec -it -u [USER] [CONTAINER_ID] bash
```

* Run container with default app

```
docker run -it [image] [bash|sh]
```

* Remove all dangling images:

```
docker container prune
```

```
docker image prune
```

```
docker image rm [images]
```

* Apply a tag while building an image

```
docker build -t [image]:[tag] .
```

e.g.

```
docker build -t react-app:1.0.1 .
```

* Tag an image manually

```
docker image tag [image] [image]:[tag]
```

e.g.

```
docker image tag 36f react-app:latest
```

* Push an image to DockerHub

  * Go to https://hub.docker.com to create a repository
  * Give the repository a name(e.g. `my-app` => `user/my-app`)
  * Tag an image with the same name (e.g. `docker image tag user/my-app:1.0.0`)
  * Push the imag: `docker push user/my-app:1.0.0`


## Linix Base Directories

| folder name | contents |
|-|-|
| `bin` | Binaries |
| `boot` | Booting files |
| `dev` | Devices |
| `etc` | Editable Text Configurations |
| `home` | Home directory for user contents |
| `root` | Home directory for root user |
| `lib` | Library directory for software dependencies |
| `var` | Variables, lock files and application data etc. |
| `proc` | Files represent running process |

## Linux Commands

* See all packages installed

```
apt list
```

* Update apt

```
apt update
```

* Install package

```
apt install [package]
```

* Uninstall package

```
apt remove [package]
```

* Global Regular Expression Print

```
grep -i [regex] [files]
```

* Find file/directories

```
find
```

> Find all python files
```
find / -type f -iname "*.py"
```

* Check Environment Variables

```
printenv
```

or 

```
echo $[variable]
```

* Set Variable

> temporary

```
export VARIABLE=VALUE
```

> permanent
```
echo VARIABLE=VALUE >> ~/.bashrc
```

* Reload Variables

```
source ~/.bashrc
```

* See processes

```
ps
```

* User

```
useradd [user]
```

```
cat /etc/passwd
```

```
usermod -s /bin/bash [user]
```

```
cat /etc/shadow
```

* Group

```
groupadd [group]
```

```
cat /etc/group
```

```
usermod -G [group] [user] 
```

* Permissions

> Add execute permission to user who own this file
```
chmod u+x [file]
```