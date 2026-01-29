const cds = require('@sap/cds')
const { orderBy, SELECT } = require('@sap/cds/lib/ql/cds-ql')

module.exports = class CatalogService extends cds.ApplicationService { init() {

  const { EmployeeSrv, BusinessPartnerSet, AddressSet, ProductSet, PurchaseOrderSet, POItems } = cds.entities('CatalogService')

  this.before (['CREATE', 'UPDATE'], EmployeeSrv, async (req) => {
    console.log('Before CREATE/UPDATE EmployeeSrv', req.data)
    // Step1 : incoming data for create & update
    var salary = parseFloat(req.data.salaryAmount);
    if(salary >= 1000000) {
      req.error(500, "Salary can not be more than 1mn");
    }
  })
  this.after ('READ', EmployeeSrv, async (employeeSrv, req) => {
    console.log('After READ EmployeeSrv', employeeSrv)
  })
  this.before (['CREATE', 'UPDATE'], BusinessPartnerSet, async (req) => {
    console.log('Before CREATE/UPDATE BusinessPartnerSet', req.data)
  })
  this.after ('READ', BusinessPartnerSet, async (businessPartnerSet, req) => {
    console.log('After READ BusinessPartnerSet', businessPartnerSet)
  })
  this.before (['CREATE', 'UPDATE'], AddressSet, async (req) => {
    console.log('Before CREATE/UPDATE AddressSet', req.data)
  })
  this.after ('READ', AddressSet, async (addressSet, req) => {
    console.log('After READ AddressSet', addressSet)
  })
  this.before (['CREATE', 'UPDATE'], ProductSet, async (req) => {
    console.log('Before CREATE/UPDATE ProductSet', req.data)
  })
  this.after ('READ', ProductSet, async (productSet, req) => {
    console.log('After READ ProductSet', productSet)
  })
  this.before (['CREATE', 'UPDATE'], PurchaseOrderSet, async (req) => {
    console.log('Before CREATE/UPDATE PurchaseOrderSet', req.data)
  })
  // this.after ('READ', PurchaseOrderSet, async (purchaseOrderSet, req) => {
  //   console.log('After READ PurchaseOrderSet', purchaseOrderSet)
  //   // Get all the order ids
  //   let ids = purchaseOrderSet.map(rec => rec.id);
  //   console.log(ids);
  //   const partnerCount =  await SELECT .from(PurchaseOrderSet)
  //                               .columns('PARTNER_GUID', {func : 'count'})
  //                               .where({'ID' : {in : ids}})
  //                               .groupBy('PARTNER_GUID'); 
  //   for(let record of purchaseOrderSet){
  //     const myData = partnerCount.find(partnerCount => partnerCount.ID = record.ID);
  //     if (!record.NOTE){
  //       record.NOTE = '(No Value Found *** )';
  //     }
  //     record.PARTNER_COUNT = myData.count;
  //   }
  // })
  this.before (['CREATE', 'UPDATE'], POItems, async (req) => {
    console.log('Before CREATE/UPDATE POItems', req.data)
  })
  this.after ('READ', POItems, async (pOItems, req) => {
    console.log('After READ POItems', pOItems)
  })

  // implement action
  this.on ('boost', async (req) => { 
    try {
      // fetch the incoming node key  -- {NODE_KEY: 'jklusadasdl'}
      const nodeKey = req.params[0];
      // Database transaction handler object
      const tx = cds.tx(req);
      // Fire an update on DB
      await tx.update(PurchaseOrderSet).with({
        GROSS_AMOUNT : { '+=' : 20000 },
        NOTE: 'boosted !!'
      // }).where({NODE_KEY : ''});
      }).where(nodeKey);
      //use this object to fetch the data from db
      // Read
      const reply = await tx.read(PurchaseOrderSet).where(nodeKey);
      console.log(reply);
      return reply;
    } catch (error) {

    }

  });


  this.on ('getLargestOrder', async (req) => { 
    try {
      console.log("reach code");
      // Database transaction handler object
      const tx = cds.tx(req);
      //use this object to fetch the data from db
      //sort order by amount in desc and get the top 1st record
      const reply = await tx.read(PurchaseOrderSet).
                          orderBy({
                            "GROSS_AMOUNT" : "desc"
                          }).limit(1);
      console.log(reply);
      return reply;
    } catch (error) {

    }

  });
  this.on ('getOrderDefault', async (req) => {
   
    try {
      let reply = {
        OVERALL_STATUS : 'N'
      }
      return reply;


    } catch (error) {
     
    }


  })

  return super.init()
}}
