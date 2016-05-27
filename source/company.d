import vibe.d;

import dpq.connection;
import dpq.value;
import dpq.attributes;
import dpq.query;
import dpq.result;


interface IRest {
  struct Company {
      int id;
      string name;
  }
  
  @path("/companies")
  Company[] getCompanies();
}

class Rest : IRest {
  private Company[] companies;
  private Connection database;

  this() {
    database = Connection("host=172.17.0.3 dbname=ecratum user=postgres password=postgres");
  };
  
  Company[] getCompanies() {
    Query q = Query(database, "SELECT id, name from companies LIMIT 10000");
    Result r = q.run();
    
    foreach (row; r) {
      Company company = Company(row["id"].as!int, row["name"].as!string);
      companies ~= company;
    }

    return companies;
  }
}