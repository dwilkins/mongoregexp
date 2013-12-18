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
Query|MongoDB Rows|MySQL Rows|MongoDB ms|MySQL ms|MongoDB
-----|-----:|-----:|-----:|-----:|-----:
bolanchor|128|128|295ms|7769ms|**26x** faster
msiecount|371217|371217|8512ms|48027ms|**5x** faster
eolanchor|566760|566760|3190ms|61951ms|**19x** faster

### The Patterns
Query|MongoDB Pattern|MySQL Pattern
---|---|---
bolanchor|`/^66\.249\.65\.20/`|`^66\.249\.65\.20`
msiecount|`/MSIE [0-9]{1,}[\.0-9]{0,}/i`|`MSIE [0-9]{1,}[\.0-9]{0,}`
eolanchor|`/baidu\.com\/search\/spider\.html\)"$/`|`baidu\.com\/search\/spider\.html\)"$`

These results are entirely non-scientific.  I took the best run of MySQL (MariaDB) and the worst run of MongoDB.

## Running these tests
### Prerequisites
* bzip2 - for decompressing the log data
* MySQL (or MariaDB)
* MongoDB
* Patience (mostly for MySQL)

### Beware
Liberties will be taken with your MongoDB and MySQL installation.  Specifically:
* MongoDB Liberties
  * A database named `logs` will be created with a collection called `loglines`
  * 2,848,484 rows will be loaded.   Some of the lines are long
  * An index will be added on `loglines` for the column `logline`
  * Any profile information in your mongo instance will be deleted

* MySQL Liberties
  * A database named `logs` will be created with a table called `loglines` with a single column
    named logline that is varchar(8192).
  * 2,848,484 rows will be loaded.   Some of the lines are long
  * `flush tables` is run at the beginning of the script.  All of your cache is flushed.   Sorry 'bout that
  * Profiling will be turned on for the script

### Running the tests
* Clone this repo
* Execute the scripts

  ```
  ./loadmongodb.sh
  ./loadmysql.sh
  ./testmongodb.sh
  ./testmysql.sh
  ```
* Tally the numbers...
