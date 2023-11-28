---
layout: default
title: "arcgis-egdb cookbook"
category: cookbooks
item: arcgis-egdb
version: 1.1.1
latest: true
---

# arcgis-egdb cookbook
 
The arcgis-egdb cookbook creates enterprise geodatabases in SQL Server or PostgreSQL databases and registers them with ArcGIS Server as the site's managed database.

## Platforms

* Windows 8 (8.1)
* Windows 10
* Windows Server 2012 (R2)
* Windows Server 2016
* Windows Server 2019
* Windows Server 2022
* Ubuntu Server 18.04 and 20.04 LTS
* Red Hat Enterprise Linux Server 8
* SUSE Linux Enterprise Server 15
* Oracle Linux 8

## Database Servers

The cookbook was tested with:

* Amazon RDS for SQL Server
* Amazon RDS for PostgreSQL
* Amazon Aurora PostgreSQL-compatible

## Dependencies

The following cookbooks are required:

* arcgis-enterprise

The cookbook uses ArcPy to create and enable geodatabases. ArcPy is installed by the ArcGIS Server setup.

ArcPy does not support creating databases in Amazon RDS database servers. The cookbook uses the sqlcmd and the psql utility for SQL Server and PostgreSQL database servers respectively to create the databases. The 'sqlcmd' and 'psql' recipes could be used to install these utilities. ArcGIS Data Store and Portal for ArcGIS include an embedded PostgreSQL client with psql utility that can be used by the arcgis-egdb cookbook.

## Attributes

* `node['arcgis']['egdb']['engine']` = DB engine `<nil|postgres|sqlserver-se>`. Default DB engine is `nil`.
* `node['arcgis']['egdb']['endpoint']` = DB instance endpoint domain name. Default endpoint is `nil`.
* `node['arcgis']['egdb']['keycodes']` = ArcGIS Server license file path. Default path is `node['arcgis']['server']['keycodes']`.
* `node['arcgis']['egdb']['master_username']` = RDS DB instance master username. Default username is `EsriRDSAdmin`.
* `node['arcgis']['egdb']['master_password']` = RDS DB instance master user password. Default password is `nil`.
* `node['arcgis']['egdb']['db_username']` = Geodatabase username. Default username is `sde`.
* `node['arcgis']['egdb']['db_password']` = Geodatabase user password. Default password is `node['arcgis']['egdb']['master_password']`.
* `node['arcgis']['egdb']['postgresbin']` = Path to PostgreSQL client bin directory. Default path is `C:\Program Files\ArcGIS\DataStore\framework\runtime\pgsql\bin` on Windows and `/arcgis/datastore/framework/runtime/pgsql/bin` on Linux.
* `node['arcgis']['egdb']['sqlcmdbin']` = Path to Microsoft SQL Server Client SDK ODBC Tools 17 Binn directory. Default path is `C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn` on Windows.
* `node['arcgis']['egdb']['connection_files_dir']` = Directory path for geodatabase connection files (.sde) created by the recipes. Default directory is `node['arcgis']['misc']['scripts_dir']/connection_files`.
* `node['arcgis']['egdb']['data_items']` = Array with properties of geodatabases. Default value is as follows:

  ```JSON
  [{
    "database" : "egdb",
    "data_item_path" : "/enterpriseDatabases/registeredDatabase",
    "connection_file": "C:\\chef\\misc_scripts\\connection_files\\RDS_egdb.sde",
    "is_managed" : true,
    "connection_type" : "shared"
  }]
  ```

## Recipes

### default

Creates an enterprise geodatabase and registers it with ArcGIS Server.

Attributes used by the recipe:

```JSON
{
  "arcgis": {
    "version": "11.0",
    "server": {
      "install_dir": "C:\\Program Files\\ArcGIS\\Server",
      "private_url": "https://domain.com:6443/arcgis",
      "admin_username": "admin",
      "admin_password": "changeit"
    },
    "misc": {
      "scripts_dir": "C:\\chef\\misc_scripts"
    },
    "egdb": {
      "engine": "postgres",
      "endpoint": "xxx.cluster-yyy.us-east-2.rds.amazonaws.com",
      "keycodes": "C:\\Program Files\\ESRI\\License11.0\\sysgen\\keycodes",
      "postgresbin" : "C:\\Program Files\\ArcGIS\\DataStore\\framework\\runtime\\pgsql\\bin",
      "master_username": "EsriRDSAdmin",
      "master_password": "changeit",
      "db_password": "changeit",
      "connection_files_dir": "C:\\chef\\misc_scripts\\connection_files",
      "data_items": [{
        "database": "egdb",
        "data_item_path": "/enterpriseDatabases/registeredDatabase",
        "connection_file": "C:\\chef\\msic_scripts\\connection_files\\RDS_egdb.sde",
        "is_managed": true,
        "connection_type": "shared"
      }]
    }
  },
  "run_list": [
    "recipe[arcgis-egdb]"
  ]
}
```

### egdb_postgres

Creates an enterprise geodatabase in PostgreSQL.

Attributes used by the recipe:

```JSON
{
  "arcgis": {
    "version": "11.0",
    "run_as_user": "arcgis",
    "server": {
      "install_dir": "C:\\Program Files\\ArcGIS\\Server"
    },
    "misc": {
      "scripts_dir": "C:\\chef\\misc_scripts"
    },
    "egdb": {
      "engine": "postgres",
      "endpoint": "xxx.cluster-yyy.us-east-2.rds.amazonaws.com",
      "keycodes": "C:\\Program Files\\ESRI\\License11.0\\sysgen\\keycodes",
      "postgresbin" : "C:\\Program Files\\ArcGIS\\DataStore\\framework\\runtime\\pgsql\\bin",
      "master_username": "EsriRDSAdmin",
      "master_password": "changeit",
      "db_password": "changeit",
      "connection_files_dir": "C:\\chef\\misc_scripts\\connection_files",
      "postgresbin": "C:\\Program Files\\ArcGIS\\DataStore\\framework\\runtime\\pgsql\\bin",
      "data_items": [{
        "database": "egdb",
        "data_item_path": "/enterpriseDatabases/registeredDatabase",
        "connection_file": "C:\\chef\\msic_scripts\\connection_files\\RDS_egdb.sde",
        "is_managed": true,
        "connection_type": "shared"
      }]
    }
  },
  "run_list": [
    "recipe[arcgis-egdb::egdb_postgres]"
  ]
}
```

### egdb_sqlserver

Creates an enterprise geodatabase in SQL Server.

Attributes used by the recipe:

```JSON
{
  "arcgis": {
    "version": "11.0",
    "server": {
      "install_dir": "C:\\Program Files\\ArcGIS\\Server"
    },
    "misc": {
      "scripts_dir": "C:\\chef\\misc_scripts"
    },
    "egdb": {
      "endpoint": "xxx.cluster-yyy.us-east-2.rds.amazonaws.com",
      "keycodes": "C:\\Program Files\\ESRI\\License11.0\\sysgen\\keycodes",
      "master_username": "EsriRDSAdmin",
      "master_password": "changeit",
      "db_password": "changeit",
      "data_items": [{
        "database": "egdb",
        "data_item_path": "/enterpriseDatabases/registeredDatabase",
        "connection_file": "C:\\chef\\msic_scripts\\connection_files\\RDS_egdb.sde",
        "is_managed": true,
        "connection_type": "shared"
      }]
    }
  },
  "run_list": [
    "recipe[arcgis-egdb::egdb_sqlserver]"
  ]
}
```

### register_egdb

Registers the database connection file with the specified ArcGIS Server site as the site's managed database.

Attributes used by the recipe:

```JSON
{
  "arcgis": {
    "server": {
      "private_url": "https://domain.com:6443/arcgis",
      "admin_username": "admin",
      "admin_password": "changeit"
    },
    "egdb": {
      "data_items": [{
        "database": "egdb",
        "data_item_path": "/enterpriseDatabases/registeredDatabase",
        "connection_file": "C:\\chef\\msic_scripts\\connection_files\\RDS_egdb.sde",
        "is_managed": true,
        "connection_type": "shared"
      }]
    }
  },
  "run_list": [
    "recipe[arcgis-egdb::register_egdb]"
  ]
}
```

### sql_alias

Creates EGDBHOST alias for SQL Server endpoint domain.

Attributes used by the recipe:

```JSON
{
  "arcgis": {
    "egdb": {
      "engine": "sqlserver-se",
      "endpoint": "xxx.us-east-2.rds.amazonaws.com"
    }
  },
  "run_list": [
    "recipe[arcgis-egdb::sql_alias]"
  ]
}
```

### sqlcmd

Installs the SQL Server ODBC driver and sqlcmd utility used by SQL Server enterprise geodatabase configuration scripts.

Attributes used by the recipe:

```JSON
{
  "run_list": [
    "recipe[arcgis-egdb::sqlcmd]"
  ]
}
```

