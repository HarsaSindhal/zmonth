@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_INVENTORY_REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_INVENTORY_CLOSING with parameters 
 @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date
 as select from I_MaterialStock_2 as a 
   left outer join I_ProductValuationBasic as C on ( C.Product = a.Material and C.ValuationArea = a.Plant )
   left outer join I_ProductDescription_2 as B on ( B.Product = a.Material and B.Language = 'E' )
   
   left outer join I_ProductPlantBasic as D on (D.Product = a.Material and D.Plant = a.Plant )
   left outer join I_Product as E on (E.Product = B.Product)
    left outer join I_ProductStorageLocationBasic as G on (G.Plant = a.Plant and G.Product = a.Material 
      and (G.StorageLocation = 'ST01' or G.StorageLocation = 'ST02'  or G.StorageLocation = 'ST03'
   or G.StorageLocation = 'ST04' ) and G.WarehouseStorageBin <> '' )
  // left outer join I_ProductStorageLocationBasic as G on ( G.StorageLocation = a.StorageLocation 
  // and G.Product = a.Material and G.Plant = '1000'  )
   left outer join I_ProductTypeText as H on (H.ProductType = E.ProductType and H.Language = 'E')
   left outer join I_ProductGroupText_2 as I on ( I.ProductGroup = E.ProductGroup and I.Language = 'E' )
//   left outer join I_MaterialDocumentItem_2 as J on (J.Material = a.Material )
   left outer join ZMM_INVENTORY_CDS as K on (K.Material = a.Material and K.Plant = a.Plant)
//   left outer join zmm_pr_user_cds as L on (L.Material = a.Material and L.Plant = a.Plant and L.Batch = a.Batch )
   
  // inner join ZMM_MATERIAL_STOCK as CA on ( CA.Material = a.Material )
 { 
   key a.Plant,
//   key a.Batch,
   key a.Material,
       a.StorageLocation,
       a.MaterialBaseUnit,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
       sum(a.MatlWrhsStkQtyInMatlBaseUnit) as Closingqty,
//      CA.STOCK as Closingqty,
       ( cast( ( C.MovingAveragePrice ) as abap.dec( 13, 3 ) )  
       * cast(sum(a.MatlWrhsStkQtyInMatlBaseUnit) as abap.dec( 13, 3 ))  ) as ClosingValue,
       B.ProductDescription,
        D.ABCIndicator,
         E.ProductType,
         E.ProductGroup,
         G.WarehouseStorageBin,
         a.WBSElementInternalID,
         
         H.MaterialTypeName as ProductTypeName,
         I.ProductGroupName as ProductGroupName,
         K.SupplierName as LastsupplierName,
         E.ProductOldID
//         L.PersonFullName
         
      
 
      
      
      
   } where a.MatlDocLatestPostgDate <= $parameters.P_KeyDate 
       //  a.MatlDocLatestPostgDate <= dats_add_days($parameters.P_KeyDate,-1,'UNCHANGED')
     and ( a.Material like 'PKPM%' or  a.Material like 'ST%'  or a.Material like 'CP%' )
     and a.StorageLocation != ' '
     and a.InventorySpecialStockType <> 'Q'
   
   group by
   a.Plant,
   a.Material,
   a.StorageLocation,
   C.MovingAveragePrice ,
   a.MaterialBaseUnit,
   B.ProductDescription,
   D.ABCIndicator,
   E.ProductType,
   E.ProductGroup,
   G.WarehouseStorageBin,
    H.MaterialTypeName,
    I.ProductGroupName,
    K.SupplierName,
    E.ProductOldID,
    a.WBSElementInternalID
//    a.Batch,
//    L.PersonFullName,
//    CA.STOCK
   
 