# Regexp - MongoDB vs MySQL

Simple Regexp Performance comparison between MongoDB and MySQL

## Why

I had a few questions about which was faster and decided to take them for a spin.
It turns out that scientific rigor wasn't needed to get an idea of which one
is better at some simple regexes


## What
* Nearly 3 million lines of very old apache log data, loaded into
  a MongoDB and MySQL (MariaDB) database
* 3 queries
  * bolanchor - Query with an anchor at the beginning of the line
  * msiecount - Count of the number of MSIE browsers in the log data
  * eolanchor - Query with an anchor at the end of the line

## Results
  MongoDB wins.  **NBA Jams ON FIRE style**

### The Numbers
Query|Rows|MongoDB ms|Postgres ms|MySQL ms|Winner
-----|-----:|-----:|-----:|-----:|-----:
bolanchor|128|295ms|2768ms|7769ms|MongoDB
msiecount|371217|8512ms|5278ms|48027ms|Postgres *
eolanchor|566760|3190ms|15892ms|61951ms|MongoDB

* MongoDB wins on the second execution, once it caches some of the data in memory.   MongoDB
Doesn't have a query cache like MySQL, so you can't get instant results for the exact same
query.

### The Patterns
Query|MongoDB Pattern|MySQL/Postgres Pattern
---|---|---
bolanchor|`/^66\.249\.65\.20/`|`^66\.249\.65\.20`
msiecount|`/MSIE [0-9]{1,}[\.0-9]{0,}/i`|`MSIE [0-9]{1,}[\.0-9]{0,}`
eolanchor|`/baidu\.com\/search\/spider\.html\)"$/`|`baidu\.com\/search\/spider\.html\)"$`

These results are entirely non-scientific.  I took the best run of MySQL (MariaDB) and Postgres and the worst run of MongoDB.

## Running these tests
### Prerequisites
* bzip2 - for decompressing the log data
* MySQL (or MariaDB)
* MongoDB
* Postgres
* Patience (mostly for MySQL)

These tests were run on my laptop:
* Lenovo T420
* Fedora 19 (Kernel 3.11.10-200.fc19.x86_64)
* Intel(R) Core(TM) i7-2620M CPU @ 2.70GHz
* 16gb Memory (about 9gb free when the tests were run)
* ST750LX003-1AC154 (SM12) 750gb Seagate Momentus Hybrid Drive (7200rpm
* Fedora 19
* Full desktop (X11/Gnome) environment running


### Beware
Liberties will be taken with your MongoDB, MySQL and Postgres installation.  Specifically:
* MongoDB Liberties
  * A database named `logs` will be created with a collection called `loglines`
  * 2,848,484 rows will be loaded.   Some of the lines are long
  * An index will be added on `loglines` for the column `logline`
  * **Any profile information in your mongo instance will be deleted**

* MySQL Liberties
  * A database named `logs` will be created with a table called `loglines` with a single column
    named logline that is varchar(8192).
  * Index created for the column logline on the loglines table
  * 2,848,484 rows will be loaded.   Some of the lines are long
  * `flush tables` is run at the beginning of the script.  All of your cache is flushed.   Sorry 'bout that
  * Profiling will be turned on for the test script

* Posgres Liberties
  * A database named `logs` will be created with a table called `loglines` with a single column
    named logline that is varchar(8192).
  * Index created for the column logline on the loglines table
  * 2,848,484 rows will be loaded.   Some of the lines are long
  * Timing will be turned on for the test script

### Running the tests
* Clone this repo
* Execute the scripts

  ```
  ./loadmongodb.sh
  ./loadmysql.sh
  ./testmongodb.sh
  ./testmysql.sh
  ./testpostgres.sh
  ```
* Tally the numbers...
