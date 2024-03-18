sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/ibm/purchaseorderapp/test/integration/FirstJourney',
		'com/ibm/purchaseorderapp/test/integration/pages/POsList',
		'com/ibm/purchaseorderapp/test/integration/pages/POsObjectPage',
		'com/ibm/purchaseorderapp/test/integration/pages/PurchaseOrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, PurchaseOrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/ibm/purchaseorderapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePurchaseOrderItemsObjectPage: PurchaseOrderItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);