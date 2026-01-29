// Service Definition
using { anubhav.db.master } from '../db/datamodel';

service MyService @(path: 'MyService') {
    // Service end point /hello
    function hello(name: String) returns String;

@readonly
entity ReadEmployeeSrv as projection on master.employees;
@insertonly
entity InsertEmployeeSrv as projection on master.employees;
@updateonly
entity UpdateEmployeeSrv as projection on master.employees;
@deleteonly
entity DeleteEmployeeSrv as projection on master.employees;

}