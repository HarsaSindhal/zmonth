@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VALUE CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_VALUE_CDS 
       with parameters
     p_fromdate : abap.dats,
    p_todate   : abap.dats
    as select from ZMM_STORE_PURCHASE as A
//    left outer join ZMM_COST_CDS ( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate )  as b on 
//                                      ( b.Material = A.Material and b.Plant = A.Plant and b.StorageLocation = A.StorageLocation
//                                        )
{
    key A.Material,
    key    A.Plant,
//    key A.Batch,
    A.StorageLocation,
//    A.DocumentCurrency,
    sum(A.total_cost)  as  total_cost
//    A.PostingDate,
//    @Semantics.amount.currencyCode: 'DocumentCurrency'
//    sum(A.PurchaseOrderAmount ) as Actual_value
    
} 
where A.PostingDate between $parameters.p_fromdate and $parameters.p_todate

group by  A.Material,
        A.Plant,
        A.StorageLocation
//    A.DocumentCurrency
