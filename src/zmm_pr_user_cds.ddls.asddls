@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'mm pr user cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zmm_pr_user_cds as select from I_MaterialDocumentItem_2 as a
     inner join I_PurchaseRequisitionItemAPI01 as b on ( b.PurchasingDocument = a.PurchaseOrder 
                                                       and b.PurchasingDocumentItem = a.PurchaseOrderItem )
     left outer join I_BusinessUserBasic as c on ( c.UserID = b.CreatedByUser )                                                  

{
  key a.Material,
  key a.Plant,
  key a.Batch,
      c.PersonFullName
      
      
} where a.GoodsMovementIsCancelled = '' and a.GoodsMovementType = '101'
