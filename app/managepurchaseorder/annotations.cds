using CatalogService as service from '../../srv/CatalogService';


//annotation our PO entity which comes from the service layer
annotate service.PurchaseOrderSet with @(
    //Selection fields for the filter bar
    UI.SelectionFields: [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT,
        OVERALL_STATUS
    ],
    //Columns to be added in the table - Ctrl+space for code completion
    UI.LineItem:[
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
            Action : 'CatalogService.boost',
            Label : 'boost',
            Inline: true
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality : IconColor,
        },
    ],
    UI.HeaderInfo: {
        TypeName: 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title: {Value: PO_ID},
        Description: {Value: PARTNER_GUID.COMPANY_NAME},
        ImageUrl: 'https://images.seeklogo.com/logo-png/12/2/sony-logo-png_seeklogo-129420.png'
    },
    //Add multiple tabs in a tabstrip = Facets
    UI.Facets: [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Additional Info',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Info',
                    Target : '@UI.Identification',
                },                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing Info',
                    Target : '@UI.FieldGroup#Spiderman',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Status',
                    Target : '@UI.FieldGroup#Superman',
                },

            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Items',
            Target : 'Items/@UI.LineItem',
        },

    ],
    ///a default block which is a collection of fields - Identification block
    UI.Identification: [
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
            Value : NOTE,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID_NODE_KEY,
        },
    ],
    UI.FieldGroup #Spiderman: {
        Data: [
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
        ]
    },
    UI.FieldGroup #Superman: {
        Data: [
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
        ]
    }


);

///Adding annotation for purchase order items
annotate service.POItems with @(
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
            Value : TAX_AMOUNT,
        },
    ],
    UI.HeaderInfo:{
        TypeName: 'PO Item',
        TypeNamePlural: 'Purchase Order Items',
        Title :  { Value: PO_ITEM_POS },
        Description : { Value : PRODUCT_GUID.DESCRIPTION }
    },
    UI.Facets:[
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Item Details',
            Target : '@UI.Identification',
        },
    ],
    UI.Identification: [
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
            Value : TAX_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
    ]
);

annotate service.PurchaseOrderSet with {
    @Common : { FilterDefaultValue : 'P', }
    OVERALL_STATUS;
    @Common : {
            Text: PARTNER_GUID.COMPANY_NAME,
            ValueList.entity: service.BusinessPartnerSet
    }
    PARTNER_GUID;

};

annotate service.POItems with {
    @Common : { FilterDefaultValue : 'P',
                Text : PRODUCT_GUID.DESCRIPTION,
                ValueList: service.ProductSet }
    PRODUCT_GUID;
};

//Define value help for BP
@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : COMPANY_NAME,
        },
    ]
);
//Define value help for Product
@cds.odata.valuelist
annotate service.ProductSet with @(
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : DESCRIPTION,
        },
    ]
);

