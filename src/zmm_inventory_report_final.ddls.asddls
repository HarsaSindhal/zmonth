@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_INVENTORY_REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X, 
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_INVENTORY_REPORT_FINAL
   with parameters
     p_fromdate : abap.dats,
    p_todate   : abap.dats
 as select from ZMM_INVENTORY_CLOSING( P_KeyDate:$parameters.p_todate) as closing
 left outer join ZMM_INVENTORY( P_KeyDate:$parameters.p_fromdate ) as opening on 
                                   ( opening.Plant = closing.Plant and opening.Material = closing.Material 
                                   and opening.StorageLocation = closing.StorageLocation )
 left outer join ZMM_INVENTORY_C2( p_fromdate:$parameters.p_fromdate ,  p_todate:$parameters.p_todate ) as A  on 
                                   ( A.Plant = closing.Plant and A.Material = closing.Material 
                                   and A.StorageLocation = closing.StorageLocation  )
  left outer join ZMM_VALUE_CDS ( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate )  as b on 
                                      ( b.Material = A.Material and b.Plant = A.Plant and b.StorageLocation = A.StorageLocation
                                        )
   left outer join ZMM_COST_CDS ( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate )  as C on 
     ( C.Material = A.Material and C.Plant = A.Plant and C.StorageLocation = A.StorageLocation )
                                                                          
//     left outer join I_ActualPlanJournalEntryItem as CC on ( CC.WBSElementInternalID = closing.WBSElementInternalID )                                   
//     left outer join I_EnterpriseProjectElement_2 as DD on ( DD.WBSElementInternalID = CC.WBSElementInternalID )                                
                                   
{
    
    key A.Plant,
    key A.Material, 
//    key A.Batch,
    key A.StorageLocation,
    
         closing.ABCIndicator,
         closing.ProductType,
          closing.ProductGroup,
           closing.WarehouseStorageBin,
         closing. ProductTypeName,
         closing.ProductGroupName,
         closing.LastsupplierName,
//         closing.PersonFullName,
     //   opening.MaterialBaseUnit as MaterialBaseUnit,
//        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        cast(opening.Openingqty as abap.dec( 20, 3 ) ) as Openingqty,
        cast(opening.OpeningValue as abap.dec( 20, 2 ) ) as OpeningValue,
        
        cast(  substring( A.Material, 1 ,1 ) as abap.char(1) ) as Type , 
       case when  opening.ProductDescription is null then closing.ProductDescription 
       else opening.ProductDescription end as ProductDescription,
//        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        cast(closing.Closingqty as abap.dec( 20, 3 ) ) as Closingqty,
        cast(closing.ClosingValue as abap.dec( 20, 2 ) ) as ClosingValue,
        
         A.MaterialBaseUnit as MaterialBaseUnit,
//        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        cast(sum(A.Receiptqty) as abap.dec( 20, 3 ) ) as Receiptqty,
        
//        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        cast(sum(A.Issueqty) as abap.dec( 20, 3 ) ) as Issueqty,
        
//        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        cast(sum(A.SalesQty) as abap.dec( 20, 3 ) ) as SalesQty,
        
//        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        cast(sum(A.Adjustqty) as abap.dec( 20, 3 ) ) as Adjustqty,
        
        A.CompanyCodeCurrency,
        closing.ProductOldID,
        
//          case when b.DocumentCurrency  = 'CHF'
//          then cast(A.RECEIPTVALUE as abap.dec( 13, 2  ) ) * 100  
//          else cast(sum(A.RECEIPTVALUE) as abap.dec( 20, 2 ) ) end as RECEIPTVALUE, 
            cast(sum(A.RECEIPTVALUE) as abap.dec( 20, 2 ) )  as RECEIPTVALUE,
//       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        cast(sum(A.issuevalue) as abap.dec( 20, 2 ) )  as issuevalue,
        
        
//        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        cast(sum(A.Salesvalue) as abap.dec( 20, 2 ) ) as Salesvalue ,
//        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        cast(sum(A.Adjustvalue) as abap.dec( 20, 2 ) ) as Adjustvalue ,
        
        
        
               
//          case when b.DocumentCurrency  = 'CHF'
//         then cast(b.Actual_value as abap.dec( 13, 2  ) ) * 100  
//        cast(sum(b.total_cost) as abap.dec( 20, 2 ) )  as  Actual_value,
        case when cast(sum(b.total_cost) as abap.dec( 20, 2 ) ) is not null
        then cast(sum(b.total_cost) as abap.dec( 20, 2 ) ) 
        else cast(sum(A.RECEIPTVALUE) as abap.dec( 20, 2 ) ) end as Actual_value, 
        
         cast(sum(C.COST) as abap.dec( 20, 2 ) ) as  COST,
        
                
        substring(A.Material , 11 ,1 ) as ORIGIN,
        
         cast(sum(A.returnqty) as abap.dec( 20, 2 ) ) as  returnqty ,
         
         cast(sum(A.returnvalue) as abap.dec( 20, 2 ) ) as  returnvalue ,
         
         cast(sum(A.Receiptqty311) as abap.dec( 20, 3 ) ) as Receiptqty311,  
         
          cast(
    cast(sum(A.Receiptqty311) as abap.dec(15, 3)) 
    * cast(sum(A.MovingAveragePrice) as abap.dec(15, 2))
    as abap.dec(28, 5)
) as RECEIPTVAL311,  
         
         cast(sum(A.value561) as abap.dec( 20, 3 ) ) as value561,  
         
         
         cast(sum(A.value531) as abap.dec( 20, 3 ) ) as value531,  
         
         cast(sum(A.qty531) as abap.dec( 20, 3 ) ) as qty531,  
       
          cast( coalesce(A.Receiptqty ,0 ) as abap.dec(23,2) ) + cast( coalesce(A.qty531 ,0 ) as abap.dec(23,2) ) -  cast( coalesce( A.returnqty  ,0 ) as abap.dec(23,2) )  - cast( coalesce( A.SalesQty  ,0 ) as abap.dec(23,2) ) - cast( coalesce( A.Adjustqty  ,0 ) as abap.dec(23,2) ) 
          as actualinv ,
       
//         b.DocumentCurrency,
 //        @Semantics.amount.currencyCode: 'DocumentCurrency'
         sum(b.total_cost ) as total_cost
         
//         CC.WBSElementExternalID,
//         DD.ProjectElementDescription
  
        
       
      
       
   
   
} where ( opening.Openingqty > 0 or closing.Closingqty > 0 or A.Receiptqty > 0 or A.Issueqty  > 0   )   
          and A.StorageLocation != ' '
  group by A.Plant,
           A.Material,
           A.StorageLocation,
      //     opening.MaterialBaseUnit,
           A.MaterialBaseUnit,
           A.CompanyCodeCurrency,
           opening.Openingqty,
           opening.OpeningValue,
           opening.ProductDescription,
           closing.Closingqty,
           closing.ClosingValue,
           closing.ProductDescription,
           closing.ABCIndicator,
           closing.ProductType,
           closing.ProductGroup,
           closing.WarehouseStorageBin,
         closing.ProductTypeName,
         closing.ProductGroupName,
         closing.LastsupplierName,
         A.SalesQty,
         A.Receiptqty,
         A.returnqty,
         A.Adjustqty,
         A.RECEIPTVALUE,
         A.returnvalue,
         A.Salesvalue,
         A.Adjustvalue,
         A.Receiptqty311,
         A.RECEIPTVAL311,
 //        b.Actual_value,
//         b.DocumentCurrency,
         closing.ProductOldID,
         A.value531,
         A.qty531,
         A.MovingAveragePrice
//    CC.WBSElementExternalID,
//    DD.ProjectElementDescription
//    A.Batch,
//    closing.PersonFullName
//         b.total_cost
         
         
           
   
