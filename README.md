# Nobel Laureate Data Conversion

The aim of this project is to create a conversion process between JSON data and MySQL (MariaDB).

## Setup
Replace `your_shared_dir` with a directory on your local machine that will be linked to `/home/cs143/shared/` in the Docker container.
```console
$ docker container rm mysql-apache
$ docker run -it -v {your_shared_dir}:/home/cs143/shared -p 8888:80 --name mysql-apache junghoo/mysql-apache
```
After creating the container, run with
```console
$ docker start -i mysql-apache
```
In your container, git clone this repository into your shared directory, then remove the `~/www/` folder and its contents and symlink a new `~/www/` folder to the cloned git repo. E.g.
```console
$ cd ~/shared/
$ git clone https://github.com/ajpfahnl/Nobel-Laureate-Data-Conversion.git
$ cd ../
$ rm -rf www/
$ ln -s shared/Nobel-Laureate-Data-Conversion/ www
```
Then go to [http://localhost:8888/laureate.php](http://localhost:8888/laureate.php) on your local machine to view the JSON output from the API.

# Pretext

The JSON schema that will be converted to relational table format is as follows:
```
"laureates": {
    "id", "givenName", "familyName", "gender",
    "birth: {
        "date",
        "place": {
            "city", "country"
        }
    },
    "orgName",
    "founded": {
        "date",
        "place": {
            "city", "country"
        }
    },
    "nobelPrizes": [{
        "awardYear", "category", "sortOrder", 
        "affiliations": [{
            "name", "city", "country"
        }]
    }]
}
```
