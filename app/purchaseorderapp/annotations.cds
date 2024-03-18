using CatalogService as service from '../../srv/CatalogService';

//purchase order header
annotate service.POs with @(

    UI.SelectionFields:[
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT,
        OVERALL_STATUS
    ],
    UI.HeaderInfo: {
        TypeName : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title: {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        Description: {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        ImageUrl: 'https://yt3.googleusercontent.com/zCgSuKDRBWCoEFP52F5WNm-8q6FYKiiIlgpdqjdQaZekQc-PDcyFhi-cO8bkvtvOvH6qPBSg=s900-c-k-c0x00ffffff-no-rj'
    },
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label: 'boost',
            Inline : true,
            Action : 'CatalogService.boost',
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality: Criticality
        },

    ],
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID_NODE_KEY,
        },
    ],
    UI.FieldGroup #Spiderman:{
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
        ],
    },
    UI.FieldGroup #Superman:{
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
            {
                $Type : 'UI.DataField',
                Value : OVERALL_STATUS,
            },
            {
                $Type : 'UI.DataField',
                Value : LIFECYCLE_STATUS,
            },
            
        ],
    },
    UI.Facets: [
        {
            Label : 'Additional Info',
            $Type : 'UI.CollectionFacet',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label: 'More Info',
                    Target : '@UI.Identification',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label: 'Pricing',
                    Target : '@UI.FieldGroup#Spiderman',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label: 'Status',
                    Target : '@UI.FieldGroup#Superman',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Line Items',
            Target : 'Items/@UI.LineItem',
        },
    ]   

);

//purchase order items
annotate service.PurchaseOrderItems with @(

    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
    ],
    UI.HeaderInfo:{
        TypeName : 'Item',
        TypeNamePlural : 'Items',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        }
    },
    UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Item Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Item Data',
                    Target : '@UI.FieldGroup#ItemData',
                },{
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Product Data',
                    Target : '@UI.FieldGroup#ProductData',
                }
            ],
        },
    ],
    UI.FieldGroup #ItemData:{
        Label : 'Item Data',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID_NODE_KEY,
            },{
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
    },
    UI.FieldGroup #ProductData:{
        Label: 'Product Details',
        Data: [
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.CATEGORY,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.DESCRIPTION,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRICE,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.SUPPLIER_GUID.ADDRESS_GUID.COUNTRY,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.SUPPLIER_GUID.COMPANY_NAME,
            }
        ]
    }


);

annotate CatalogService.POs with {
    PARTNER_GUID@(
        Common : { 
            Text : PARTNER_GUID.COMPANY_NAME,
         },
         ValueList.entity: CatalogService.BusinessPartnerSet
    )
};

annotate CatalogService.PurchaseOrderItems with {
    PRODUCT_GUID@(
        Common : { 
            Text : PRODUCT_GUID.DESCRIPTION,
         },
         ValueList.entity: CatalogService.ProductSet
    )
};


@cds.odata.valuelist
annotate CatalogService.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    }]
);

@cds.odata.valuelist
annotate CatalogService.ProductSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : DESCRIPTION,
    }]
);