@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR VALUE INVENTORY'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_INVENTORY_VALUE_CDS 

   with parameters
     p_fromdate : abap.dats,
    p_todate   : abap.dats
    as select from ZMM_STORE_PURCHASE as A
{
    key A.Material,
    key    A.Plant,
//    key A.Batch,
    A.StorageLocation,
    A.DocumentCurrency,
    sum(A.total_cost) as  total_cost,
//    A.PostingDate,
    @Semantics.amount.currencyCode: 'DocumentCurrency'
    sum(A.PurchaseOrderAmount ) as Actual_value
    
} 
where A.PostingDate between $parameters.p_fromdate and $parameters.p_todate

group by  A.Material,
        A.Plant,
        A.StorageLocation,
    A.DocumentCurrency
//    A.Batch
//    A.total_cost
//    A.PostingDate,
//    A.PurchaseOrderAmount
