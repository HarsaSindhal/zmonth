@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'INVENTORY REPO FINAL TOTAL'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Zmm_Inventory_Report_Final_Cds 
  with parameters
     p_fromdate : zdate,
    p_todate   :  zdate
as select from ZMM_INVENTORY_REPORT_FINAL( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate ) as A
 
{

      
     @UI.lineItem      : [{position: 10}]
      @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 10}]
      @EndUserText.label:     'Plant'
   key  A.Plant,
   
     @UI.lineItem      : [{position: 20}]
      @UI.selectionField: [{position: 20}]
      @UI.identification: [{position: 20}]
      @EndUserText.label:     'Material'
    key    A.Material,
    
     @UI.lineItem      : [{position: 30}]
      @UI.selectionField: [{position: 30}]
      @UI.identification: [{position: 30}]
      @EndUserText.label:     'StorageLocation'
    key    A.StorageLocation,
    
     @UI.lineItem      : [{position: 40}]
//      @UI.selectionField: [{position: 40}]
      @UI.identification: [{position: 40}]
      @EndUserText.label:     'Emergency Flag'
      key A.ABCIndicator,
        
     @UI.lineItem      : [{position: 50}]
//      @UI.selectionField: [{position: 50}]
      @UI.identification: [{position: 50}]
      @EndUserText.label:     'ProductType'
       key A.ProductType,
        
     @UI.lineItem      : [{position: 60}]
//      @UI.selectionField: [{position: 60}]
      @UI.identification: [{position: 60}]
      @EndUserText.label:     'ProductGroup'
       key A.ProductGroup,
        
     @UI.lineItem      : [{position: 70}]
//      @UI.selectionField: [{position: 70}]
      @UI.identification: [{position: 70}]
      @EndUserText.label:     'StorageBin'
       key A.WarehouseStorageBin,
        
     @UI.lineItem      : [{position: 80}]
//      @UI.selectionField: [{position: 80}]
      @UI.identification: [{position: 80}]
      @EndUserText.label:     'ProductTypeName'
       key A.ProductTypeName,
        
     @UI.lineItem      : [{position: 90}]
//      @UI.selectionField: [{position: 90}]
      @UI.identification: [{position: 90}]
      @EndUserText.label:     'ProductGroupName'
       key A.ProductGroupName,
        
     @UI.lineItem      : [{position: 100}]
//      @UI.selectionField: [{position: 100}]
      @UI.identification: [{position: 100}]
      @EndUserText.label:     'LastsupplierName'
       key A.LastsupplierName,
        
     @UI.lineItem      : [{position: 101}]
//      @UI.selectionField: [{position: 101}]
      @UI.identification: [{position: 101}]
      @Aggregation.default: #SUM
      @EndUserText.label:     'Openingqty'
       key A.Openingqty,
        
     @UI.lineItem      : [{position: 102}]
//      @UI.selectionField: [{position: 102}]
      @UI.identification: [{position: 102}]
      @Aggregation.default: #SUM
      @EndUserText.label:     'OpeningValue'
       key A.OpeningValue,
        
     @UI.lineItem      : [{position: 103}]
//      @UI.selectionField: [{position: 103}]
      @UI.identification: [{position: 103}]
      @EndUserText.label:     'Type'
       key A.Type,
        
     @UI.lineItem      : [{position: 104}]
//      @UI.selectionField: [{position: 104}]
      @UI.identification: [{position: 104}]
      @EndUserText.label:     'ProductDescription'
       key A.ProductDescription,
        
     
       
//       key  cast( coalesce(A.Openingqty ,0 ) as abap.dec(23,4) ) + cast( coalesce(A.qty531 ,0 ) as abap.dec(23,4) ) +  cast( coalesce( A.Receiptqty  ,0 ) as abap.dec(23,4) )  - cast( coalesce( A.returnqty  ,0 ) as abap.dec(23,4) ) - cast( coalesce( A.Issueqty  ,0 ) as abap.dec(23,4) )  - cast( coalesce( A.SalesQty  ,0 ) as abap.dec(23,4) )  - cast( coalesce( A.Adjustqty  ,0 ) as abap.dec(23,4) )  as   Closingqty ,
        
     @UI.lineItem      : [{position: 106}]
//      @UI.selectionField: [{position: 106}]
      @UI.identification: [{position: 106}]
      @Aggregation.default: #SUM
      @EndUserText.label:     'ClosingValue'
       key ClosingValue,
//       key case when (
//        cast( coalesce( A.Closingqty, 0 ) as abap.dec(23,4) ) > 0
//        and cast( coalesce( A.ClosingValue,0 ) as abap.dec(23,4) ) = 0
//       )
//    then cast(
//         ( cast( coalesce(Actual_value ,0 ) as abap.dec(23,4) ) +
//          cast( coalesce(COST ,0 ) as abap.dec(23,4) ) -  
//          cast( coalesce( A.returnvalue  ,0 ) as abap.dec(23,4) ) -
//          cast( coalesce( A.Salesvalue  ,0 ) as abap.dec(23,4) ) - 
//          cast( coalesce( A.Adjustvalue  ,0 ) as abap.dec(23,4) ) )
//           / cast( coalesce( A.actualinv, 0 ) as abap.dec(23,4) )
//          * cast( coalesce( A.Closingqty, 0 ) as abap.dec(23,4) )
//       as abap.dec(23,4) )
//  else cast( coalesce( A.ClosingValue, 0 ) as abap.dec(23,4) )
//end as ClosingValue,
       
      
//     key  cast( coalesce(A.OpeningValue ,0 ) as abap.dec(23,4) ) + cast( coalesce(A.value531 ,0 ) as abap.dec(23,4) ) +  cast( coalesce( A.Actual_value  ,0 ) as abap.dec(23,4) ) + cast( coalesce( A.value561  ,0 ) as abap.dec(23,4) ) - cast( coalesce( A.returnvalue  ,0 ) as abap.dec(23,4) )  - cast( coalesce( A.issuevalue  ,0 ) as abap.dec(23,4) ) - cast( coalesce( A.Salesvalue  ,0 ) as abap.dec(23,4) ) - cast( coalesce( A.Adjustvalue  ,0 ) as abap.dec(23,4) )  as   ClosingValue ,
       

        
     @UI.lineItem      : [{position: 107}]
//      @UI.selectionField: [{position: 107}]
      @UI.identification: [{position: 107}]
      @EndUserText.label:     'MaterialBaseUnit'
       key A.MaterialBaseUnit,
        
     @UI.lineItem      : [{position: 108}]
 //     @UI.selectionField: [{position: 108}]
      @UI.identification: [{position: 108}]
      @Aggregation.default: #SUM
      @EndUserText.label:     'Receiptqty'
//       key A.Receiptqty,
       key  cast( coalesce(A.Receiptqty ,0 ) as abap.dec(23,4) ) + cast( coalesce(A.qty531 ,0 ) as abap.dec(23,4) ) as Receiptqty,
        
     @UI.lineItem      : [{position: 109}]
 //     @UI.selectionField: [{position: 109}]
      @UI.identification: [{position: 109}]
      @Aggregation.default: #SUM
      @EndUserText.label:     'Issueqty'
       key A.Issueqty,
        
     @UI.lineItem      : [{position: 110}]
 //     @UI.selectionField: [{position: 110}]
      @UI.identification: [{position: 110}]
      @Aggregation.default: #SUM
      @EndUserText.label:     'SalesQty'
       key A.SalesQty,
        
     @UI.lineItem      : [{position: 111}]
 //     @UI.selectionField: [{position: 111}]
      @UI.identification: [{position: 111}]
      @Aggregation.default: #SUM
      @EndUserText.label:     'Adjustqty'
       key A.Adjustqty,
        
     @UI.lineItem      : [{position: 112}]
 //     @UI.selectionField: [{position: 112}]
      @UI.identification: [{position: 112}]
      @EndUserText.label:     'CompanyCodeCurrency'
      
     key A.CompanyCodeCurrency,
       // A.CompanyCodeCurrency,
        
     @UI.lineItem      : [{position: 113}]
 //     @UI.selectionField: [{position: 113}]
      @UI.identification: [{position: 113}]
      @Aggregation.default: #SUM
      @EndUserText.label:     'Receiptvalue'
//      @EndUserText.label:     'CompanyCodeCurrency'
      
//        A.Actual_value,
      key A.RECEIPTVALUE  ,
//      key cast( coalesce(A.OpeningValue ,0 ) as abap.dec(23,4) ) + cast( coalesce(A.RECEIPTVALUE ,0 ) as abap.dec(23,4) ) + cast( coalesce(A.value531 ,0 ) as abap.dec(23,4) )  as RECEIPTVALUE,
        
        
     @UI.lineItem      : [{position: 114}]
 //     @UI.selectionField: [{position: 114}]
      @UI.identification: [{position: 114}]
      @Aggregation.default: #SUM
      @EndUserText.label:     'Issuevalue'
//       key A.issuevalue + A.RECEIPTVAL311 as issuevalue,
     key  cast( coalesce(A.issuevalue ,0 ) as abap.dec(23,4) ) + cast( coalesce(A.RECEIPTVAL311 ,0 ) as abap.dec(23,4) ) as issuevalue,
     @UI.lineItem      : [{position: 115}]
 //     @UI.selectionField: [{position: 115}]
      @UI.identification: [{position: 115}]
       @Aggregation.default: #SUM
      @EndUserText.label:     'Salesvalue'
       key A.Salesvalue,
        
        @UI.lineItem      : [{position: 116}]
 //     @UI.selectionField: [{position: 116}]
      @UI.identification: [{position: 116}]
       @Aggregation.default: #SUM
      @EndUserText.label:     'Adjustvalue'
       key A.Adjustvalue,
        
         @UI.lineItem      : [{position: 117}]
 //     @UI.selectionField: [{position: 117}]
      @UI.identification: [{position: 117}]
 //      @Aggregation.default: #SUM
      @EndUserText.label:     'Origin'
       key A.ORIGIN,
        
        @UI.lineItem      : [{position: 118}]
 //     @UI.selectionField: [{position: 117}]
      @UI.identification: [{position: 118}]
       @Aggregation.default: #SUM
      @EndUserText.label:     ' Returnqty '
       key A. returnqty ,
        
          @UI.lineItem      : [{position: 119}]
 //     @UI.selectionField: [{position: 117}]
      @UI.identification: [{position: 119}]
       @Aggregation.default: #SUM
      @EndUserText.label:     ' Returnvalue '
       key A.returnvalue ,
        
         @UI.lineItem      : [{position: 120}]
 //     @UI.selectionField: [{position: 117}]
      @UI.identification: [{position: 120}]
       @Aggregation.default: #SUM
      @EndUserText.label:     'Actualinventory'
     key A.actualinv,
      
      
//      @UI.lineItem      : [{position: 120}]
// //     @UI.selectionField: [{position: 117}]
//      @UI.identification: [{position: 120}]
////       @Aggregation.default: #SUM
//      @EndUserText.label:     'Document Currency'
//      A.DocumentCurrency,
//      
     
      
      @UI.lineItem      : [{position: 121}]
 //     @UI.selectionField: [{position: 117}]
      @UI.identification: [{position: 121}]
       @Aggregation.default: #SUM
      @EndUserText.label:     'Actualinventoryvalue'
      
//      key case when DocumentCurrency  = 'CHF'
//         then  cast( coalesce(Actual_value  ,0 ) as abap.dec(23,4) ) -  cast( coalesce( A.returnvalue  ,0 ) as abap.dec(23,4) )  - cast( coalesce( A.Salesvalue  ,0 ) as abap.dec(23,4) ) - cast( coalesce( A.Adjustvalue  ,0 ) as abap.dec(23,4) ) * 100
//    else   cast( coalesce(Actual_value  ,0 ) as abap.dec(23,4) ) -  cast( coalesce( A.returnvalue  ,0 ) as abap.dec(23,4) )  - cast( coalesce( A.Salesvalue  ,0 ) as abap.dec(23,4) ) - cast( coalesce( A.Adjustvalue  ,0 ) as abap.dec(23,4) )  end  as   actualinvalue ,


    key  cast( coalesce(Actual_value ,0 ) as abap.dec(23,4) ) + cast( coalesce(COST ,0 ) as abap.dec(23,4) ) -  cast( coalesce( A.returnvalue  ,0 ) as abap.dec(23,4) )  - cast( coalesce( A.Salesvalue  ,0 ) as abap.dec(23,4) ) - cast( coalesce( A.Adjustvalue  ,0 ) as abap.dec(23,4) )   as   actualinvalue ,
    
        @UI.lineItem      : [{position: 122}]
        @UI.identification: [{position: 122}]
        @EndUserText.label:     'Product Old Id'
       key A.ProductOldID,
       
       
      
//        @UI.lineItem      : [{position: 122}]
//        @UI.identification: [{position: 122}]
//        @EndUserText.label:     'WBSElementExternalID'
//       key A.WBSElementExternalID,
//       
//        @UI.lineItem      : [{position: 122}]
//        @UI.identification: [{position: 122}]
//        @EndUserText.label:     'ProjectElementDescription'
//       key A.ProjectElementDescription,
//       
       
//       @UI.lineItem      : [{position: 123}]
// //     @UI.selectionField: [{position: 108}]
//      @UI.identification: [{position: 123}]
//      @Aggregation.default: #SUM
//      @EndUserText.label:     '311'
//       key A.Receiptqty311,
//       
//       @UI.lineItem      : [{position: 124}]
// //     @UI.selectionField: [{position: 108}]
//      @UI.identification: [{position: 124}]
//      @Aggregation.default: #SUM
//      @EndUserText.label:     '311'
//       key A.RECEIPTVAL311,
       
       
       @UI.lineItem      : [{position: 105}]
//      @UI.selectionField: [{position: 105}]
      @UI.identification: [{position: 105}]
      @Aggregation.default: #SUM
      @EndUserText.label:     'Closingqty'
      
       case when ( Material = 'STSPMTRFRTD006958' and StorageLocation = 'ST01' ) then Closingqty / 2 else 
       Closingqty end as Closingqty
  
        
      
      

      
     
      
      
      
}
