@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_INVENTORY_C'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_INVENTORY_C2
  with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
     as select from I_MaterialDocumentItem_2 as a
     left outer join ZMM_INVENTORY_C( p_fromdate : $parameters.p_fromdate  , p_todate : $parameters.p_todate ) as b on
                                    ( b.Material = a.Material and b.Plant = a.Plant and b.StorageLocation = a.StorageLocation   )
{
    key a.Plant,
    key a.Material,
//    key a.Batch,
    key   a.StorageLocation,
    b.MaterialBaseUnit,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    b.MovingAveragePrice,
    b.CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    b.RECEIPTVALUE,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
    b.Receiptqty,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    b.Salesvalue,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
    b.SalesQty,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    b.Adjustvalue,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
    b.Adjustqty,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
    b.Issueqty,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    b.issuevalue,
     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
    b. returnqty,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    b.returnvalue,
    
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
    b.Receiptqty311,
    
     @Semantics.amount.currencyCode: 'CompanyCodeCurrency' 
    b.RECEIPTVAL311  ,
    
    
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency' 
    b.value561,
    
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
    b.qty531,
    
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency' 
    b.value531
//    a.PurchaseOrder
//    b.DocumentCurrency,
//    @Semantics.amount.currencyCode: 'DocumentCurrency'
//    b.Actual_value
}  
 where   ( a.Material like 'PKPM%' or  a.Material like 'ST%'  or a.Material like 'CP%' )
// and a.CostCenter <> '1000COMST'
   and  a.InventorySpecialStockType <> 'Q'
 group by 
 a.Plant,
 a.Material,
       a.StorageLocation,
    b.MaterialBaseUnit,
    b.CompanyCodeCurrency,
    b.RECEIPTVALUE,
    b.Receiptqty,
    b.Salesvalue,
    b.SalesQty,
    b.Adjustvalue,
    b.Adjustqty,
    b.Issueqty,
    b.issuevalue,
    b.returnqty,
    b.returnvalue,
    b.Receiptqty311,
    b.RECEIPTVAL311,
     b.MovingAveragePrice,
    b.value561,
    b.value531,
    b.qty531
//    a.PurchaseOrder
//    a.Batch
//    b.Actual_value,
//    b.DocumentCurrency
