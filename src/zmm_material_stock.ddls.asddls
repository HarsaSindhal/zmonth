@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Stock'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_MATERIAL_STOCK as select from I_MaterialStock_2 as A
{
    key A.Material,
    
    A.MaterialBaseUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(A.MatlWrhsStkQtyInMatlBaseUnit) as STOCK
}
group by
  A.Material,
  A.MaterialBaseUnit
