// refer fule where my db tables are
using { anubhav.db } from '../db/datamodel';

service CatalogService @(path: 'CatalogService') {
    // Expose my database table as a odata service
    // CURDQ => Create, Update, Read, Delete & Query Data
    //@readonly
    entity EmployeeSrv as projection on db.master.employees;
    //Other entities
    entity BusinessPartnerSet as projection on db.master.businesspartner;
    entity AddressSet as projection on db.master.address;
    entity ProductSet as projection on db.master.product;
    entity PurchaseOrderSet @(odata.draft.enabled: true,
                              Common.DefaultValuesFunction: 'getOrderDefault' ) as projection on db.transaction.purchaseorder{
        *,
        //expression
        case OVERALL_STATUS
            when 'P' then 'Pending'
            when 'A' then 'Approved'
            when 'X' then 'Rejected'
            when 'N' then 'New'
                end as OverallStatus : String(32),
        case OVERALL_STATUS
            when 'P' then 2
            when 'A' then 3
            when 'X' then 1
            when 'N' then 2
                end as IconColor : Int16
    }

    actions{
        // System will automatically pass the primary key
        action  boost() returns PurchaseOrderSet;
    }
    entity POItems as projection on db.transaction.poitems;
//write a custom function which fetch the most expensive po in sap
    function getLargestOrder() returns PurchaseOrderSet;
 // Set default value in the field   
    function getOrderDefault() returns PurchaseOrderSet;

}

