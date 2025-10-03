@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_INVENTORY_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_INVENTORY_CDS as select from I_MaterialDocumentItem_2    as A 
       inner join I_MaterialDocumentHeader_2  as B on ( B.MaterialDocument = A.MaterialDocument 
       and B.MaterialDocumentYear = A.MaterialDocumentYear)
       inner join I_Supplier as C on (C.Supplier = A.Supplier)
       

{   
  key  A.Plant,
  key   A.Material,
   max( C.Supplier) as Supplier ,
   max( C.SupplierName)as SupplierName ,
     max(A.PostingDate) as PostingDate
     

    
} where  A.GoodsMovementType = '101'
      and A.GoodsMovementRefDocType = 'B'
      and A.GoodsMovementIsCancelled = ''
//      ORDER BY a.materialdocument  descending

group by
A.Plant,
A.Material

