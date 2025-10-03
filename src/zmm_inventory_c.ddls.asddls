@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_INVENTORY_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_INVENTORY_C
  with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from I_MaterialDocumentItem_2 as a 
  left outer join I_ProductValuationBasic as B on  ( B.Product = a.Material and B.ValuationArea = a.Plant )
//  left outer join ZMM_INVENTORY_VALUE_CDS( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate )  as b on 
  //                                    ( b.Material = a.Material and b.Plant = a.Plant and b.StorageLocation = a.StorageLocation  )
  
{
  key a.Plant,
  key a.Material,
  key a.StorageLocation,
//      a.PostingDate,
      a.MaterialBaseUnit,
      a.CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      B.MovingAveragePrice,
//      b.DocumentCurrency,
//       @Semantics.amount.currencyCode: 'DocumentCurrency'
//      sum(b.Actual_value)  as Actual_value ,
//      
      
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum( case when ( a.GoodsMovementType = '101' or 
                    a.GoodsMovementType = '561' or
                     a.GoodsMovementType = '301' ) and ( a.DebitCreditCode = 'S' ) and ( a.Plant <> a.IssuingOrReceivingPlant )
                     then a.TotalGoodsMvtAmtInCCCrcy
                    else null end )       as RECEIPTVALUE,
            
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
      sum(case when ( a.GoodsMovementType = '101' or 
                     a.GoodsMovementType = '561' or
                     a.GoodsMovementType = '301' ) and ( a.DebitCreditCode = 'S' ) and ( a.Plant <> a.IssuingOrReceivingPlant )
               then a.QuantityInBaseUnit
                 else null end )               as Receiptqty,
                 
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum( case when ( a.GoodsMovementType = '601' )
      then a.TotalGoodsMvtAmtInCCCrcy
      else null end )       as Salesvalue, 
      
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
      sum( case when ( a.GoodsMovementType = '601' ) 
      then a.QuantityInBaseUnit
      else null end )       as SalesQty,
      
                 
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum( case when ( a.GoodsMovementType = '701'  or a.GoodsMovementType ='702')
      then a.TotalGoodsMvtAmtInCCCrcy
      else null end )       as Adjustvalue,
      
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
      sum( case when ( a.GoodsMovementType = '701'  or a.GoodsMovementType ='702' ) 
      then a.QuantityInBaseUnit
      else null end )       as Adjustqty,
      
      
                
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(case when (  a.GoodsMovementType = '201'    or
                      a.GoodsMovementType = '261' or 
                    a.GoodsMovementType = '301'   or 
                    a.GoodsMovementType = '241'
                    or a.GoodsMovementType = '311'
                    )  and ( a.DebitCreditCode = 'H' ) 
            then  a.QuantityInBaseUnit  else null   end ) as Issueqty,
            
            
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum( case when (  a.GoodsMovementType = '201'  
       or  a.GoodsMovementType = '301'    or a.GoodsMovementType = '261' or a.GoodsMovementType = '241' )   and 
                     ( a.DebitCreditCode = 'H' )   then
      a.TotalGoodsMvtAmtInCCCrcy else null end )           as issuevalue,
      
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
      sum(case when ( a.GoodsMovementType = '122' or  a.GoodsMovementType = '161' ) 
      and ( a.DebitCreditCode = 'H')
      then a.QuantityInBaseUnit 
      else null end ) as returnqty,
      
      
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(case when ( a.GoodsMovementType = '122' or  a.GoodsMovementType = '161' ) 
      and ( a.DebitCreditCode = 'H')
      then a.TotalGoodsMvtAmtInCCCrcy 
      else null end ) as returnvalue ,
      
      
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
      sum(case when ( a.GoodsMovementType = '311' 
                      ) and ( a.DebitCreditCode = 'H' ) 
               then a.QuantityInBaseUnit 
                 else null end )               as Receiptqty311,
                 
     @Semantics.amount.currencyCode: 'CompanyCodeCurrency'            
         sum(case when ( a.GoodsMovementType = '311' 
                      ) and ( a.DebitCreditCode = 'H' ) 
               then a.TotalGoodsMvtAmtInCCCrcy
                 else null end )               as RECEIPTVAL311,
         
                 
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(case when ( a.GoodsMovementType = '561'  ) 
      
      then a.TotalGoodsMvtAmtInCCCrcy 
      else null end ) as value561  , 
               
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(case when ( a.GoodsMovementType = '531'  ) 
      
      then a.TotalGoodsMvtAmtInCCCrcy 
      else null end ) as value531 ,
      
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
      sum(case when ( a.GoodsMovementType = '531' 
                      ) 
               then a.QuantityInBaseUnit
                 else null end )               as qty531
      
      
      


}
where  
    
//   a.GoodsMovementType = '201'  and (a.CostCenter <> '1000COMON' ) or
       
       a.GoodsMovementIsCancelled =    ''
       and (a.CostCenter <> '1000COMST' )
//       and ( a.MaterialDocumentItemText = '' or a.GoodsMovementType <> '101' )
  and(
       a.GoodsMovementType        =    '101'
    or a.GoodsMovementType        =    '561'
    or a.GoodsMovementType        =    '261'
    or a.GoodsMovementType        =    '201'
    or a.GoodsMovementType        =    '161'
    or a.GoodsMovementType        =    '301'
    or a.GoodsMovementType        =    '122'
    or a.GoodsMovementType        =   '601'
    or a.GoodsMovementType        =    '701'
    or a.GoodsMovementType        =    '702'
    or a.GoodsMovementType        =    '241'
    or a.GoodsMovementType        =    '311'
    or a.GoodsMovementType        =    '531'
    
    and a.InventorySpecialStockType <> 'Q'
   
   
  )

  and  a.PostingDate              between $parameters.p_fromdate and $parameters.p_todate
//   and  b.PostingDate              between $parameters.p_fromdate and $parameters.p_todate
//  and  a.PostingDate            <=  $parameters.p_todate
  and(
       a.Material                 like 'PKPM%'
    or a.Material                 like 'ST%'
    or a.Material                 like 'CP%'
  )

group by
  a.Plant,
  a.Material,
//  a.PostingDate,
  a.MaterialBaseUnit,
//  a.PostingDate,
  a.CompanyCodeCurrency,
  B.MovingAveragePrice,
  a.StorageLocation
//  b.Actual_value,
//  b.DocumentCurrency
