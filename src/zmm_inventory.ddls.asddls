@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_INVENTORY_REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_INVENTORY
  with parameters 
      @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date
  //  p_fromdate : vdm_v_key_date
 as select from I_MaterialStock_2 as A 
  left outer join I_ProductDescription_2 as B on ( B.Product = A.Material and B.Language = 'E' )
  left outer join I_ProductValuationBasic as C on ( C.Product = A.Material  and C.ValuationArea = A.Plant )
  
{
    key A.Plant,
    key A.Material,
//    key A.Batch,
       A.StorageLocation,
        A.MaterialBaseUnit,
        B.ProductDescription,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(A.MatlWrhsStkQtyInMatlBaseUnit) as Openingqty,
     ( cast( ( C.MovingAveragePrice ) as abap.dec( 13, 3 ) )  
       * cast(sum(A.MatlWrhsStkQtyInMatlBaseUnit) as abap.dec( 13, 3 ))  )  as OpeningValue
      
      
      
   } 
    where A.MatlDocLatestPostgDate <= dats_add_days($parameters.P_KeyDate,-1,'UNCHANGED')//$parameters.P_KeyDate //
  and  ( A.Material like 'PKPM%' or  A.Material like 'ST%' or A.Material like 'CP%' )
  and A.InventorySpecialStockType <> 'Q'
   group by A.Plant,
            A.Material,
            A.StorageLocation,
            A.MaterialBaseUnit,
            B.ProductDescription,
             C.MovingAveragePrice
//    A.Batch
         //   C.Currency
