@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cost Cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_COST_CDS  with parameters
     p_fromdate : abap.dats,
    p_todate   : abap.dats as select from I_MaterialDocumentItem_2 as a
    
left outer join I_PurOrdHistDeliveryCostAPI01 as b on ( b.PurchasingHistoryDocument = a.MaterialDocument and b.PurchasingHistoryDocumentItem = a.MaterialDocumentItem)


{
    key a.Material,
    key a.Plant,
   key a.StorageLocation,
   cast( sum(b.PurOrdAmountInCompanyCodeCrcy) as abap.dec( 20, 2 )) as COST
}
where a.PostingDate between $parameters.p_fromdate and $parameters.p_todate and a.GoodsMovementIsCancelled = '' and b.PurchasingHistoryCategory = 'F'
and a.InventorySpecialStockType <> 'Q'
group by 
 a.Material,
    a.Plant,
      a.StorageLocation
