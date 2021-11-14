# Templates - Docker mod for projectsend

This mod adds installation options for adding templates to the [Docker image of LinuxServer.io](https://github.com/linuxserver/docker-projectsend) for [ProjectSend](http://www.projectsend.org/). The templates to be installed can be defined with ``TEMPLATES`` as a comma-separated list and can be either installed as ZIP file from a provided URL or the local ``/templates`` volume. Have a look at the [official ProjectSend templates](https://github.com/projectsend/projectsend/tree/develop/templates) for inspiration.

## Using this Docker Mod

To add this Docker Mod to your installation of the ProjectSend [Docker image of LinuxServer.io](https://github.com/linuxserver/docker-projectsend), please add this endpoint ``linuxserver/mods:projectsend-templates`` to the ``DOCKER_MODS`` environment variable. You can install multiple Docker Mods by separating them by ``|``. [Read this page](https://github.com/linuxserver/docker-mods#using-a-docker-mod) for more information.

Now, you can define the designs/templates to be installed with their name to the ``TEMPLATES`` environment variable. You can choose to install multiple templates by separating them with commas. You can either install them by providing the folder name of a subfolder in the new ``/templates`` volume, or the URL and desired name for a template to be downloaded from a ZIP file URL (to be provided with the following syntax: ``https://my-url.com/template.zip;template-name``). The official templates ``default``, ``gallery`` and ``pinboxes`` are automatically installed by the ProjectSend image and do not have to be addressed by this Docker Mod or the ``TEMPLATES`` environment variable.

Full example with ``docker-compose`` (installing both the local ``local-template`` from ``/templates`` and ZIP file ``online-template`` from URL):

```
---
version: "2.1"
services:
  projectsend:
    image: lscr.io/linuxserver/projectsend
    container_name: projectsend
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - MAX_UPLOAD=<5000>
      - DOCKER_MODS=linuxserver/mods:projectsend-templates
      - TEMPLATES=local-template,https://my-url.com/template.zip;online-template
    volumes:
      - <path to data>:/config
      - <path to data>:/data
    ports:
      - 80:80
    restart: unless-stopped
```

### Known limitations

* Templates will only update when rebuilding the base image (``docker-compose down && docker-compose up -d --rebuild``), a simple ``docker-compose restart`` is not sufficient. This is because the [Docker image of LinuxServer.io](https://github.com/linuxserver/docker-projectsend) does not work with mounted volumes inside ``/app/projectsend/templates/``. As a result, template development can be very uncomfortable using this approach. Sorry.
* The ZIP files downloaded from URLs have to contain a root folder that provides the template files. The name provided in the ``TEMPLATES`` environment variable has no effect on the naming of this folder, but is still required.

Pull requests or suggestions are very welcome!

## Source / References
I took inspiration from the Dockerfile of the [Grafana](https://github.com/grafana/grafana/) repository, especially [this file](https://github.com/grafana/grafana/blob/main/packaging/docker/run.sh). Thanks!