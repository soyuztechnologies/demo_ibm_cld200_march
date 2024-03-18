using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';

service CatalogService @(path:'CatalogService'){

    //All the CURDQ operations will be created as OData Service
    //defining an entity in odata with name Employee set which will automaically take
    //data from our database table in data model - employee
    entity EmployeeSet as projection on master.employees;    
    entity BusinessPartnerSet as projection on master.businesspartner;  
    entity AddressSet as projection on master.address;
    entity PurchaseOrderItems as projection on transaction.poitems;
    entity POs @( odata.draft.enabled: true ) as projection on transaction.purchaseorder{
        Case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'Pending'
            when 'A' then 'Approved'
            when 'X' then 'Rejected' end as OverallStatus: String(10),
        Case OVERALL_STATUS
            when 'N' then 2
            when 'P' then 2
            when 'A' then 3
            when 'X' then 1 end as Criticality: Integer,
        *,
        Items
    }
    actions{
        @cds.odata.bindingparameter.name : '_anubhav'
        @Common.SideEffects : {
                TargetProperties : ['_anubhav/GROSS_AMOUNT']
            } 
        action boost();
    };
    function largestOrder() returns POs;
    entity ProductSet as projection on master.product;

}