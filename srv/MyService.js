// loading dependency on cap framework
const cds = require('@sap/cds');
const { DELETE } = require('@sap/cds/lib/ql/cds-ql');
// Define Module that inherit standard sap class- part of syntax
module.exports = class MyService extends cds.ApplicationService { init() {
  // Add event handler for hello - implementation
  this.on ('hello', async (req) => {
    return "Hey Friend" + req.data.name + "Welcome to cap service";
  });

  let { ReadEmployeeSrv, InsertEmployeeSrv, UpdateEmployeeSrv, DeleteEmployeeSrv }   = cds.entities('MyService');

  this.on("READ" , ReadEmployeeSrv, async(req) => {

    let results = await SELECT.from(ReadEmployeeSrv).limit(5);
    for(let record of results){
      record.nameMiddle = '***Changeed***';
    }
    return results;
  });  

  this.on("CREATE" , InsertEmployeeSrv, async(req) => {
    let myData = req.data;
    let results = await INSERT.into(InsertEmployeeSrv).entries(myData);
    return results;
  });  

  this.on("UPDATE" , UpdateEmployeeSrv, async(req) => {
    let myData = req.data;
    let results = await UPDATE.into(InsertEmployeeSrv).set({nameFirst : myData.nameFirst})
                              .where({ID : myData.ID})
    return results;
  }); 

  this.on("DELETE" , DeleteEmployeeSrv, async(req) => {
    let myData = req.data;
    let results = await DELETE.from(InsertEmployeeSrv).where({ID : myData.ID});
    return results;
  });

  return super.init()
}}
