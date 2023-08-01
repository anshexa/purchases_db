create view dbo.vw_SKUPrice
as
    select
        sku.ID
        ,sku.Code
        ,sku.Name
        ,dbo.udf_GetSKUPrice(sku.ID) as unitPrice
    from dbo.SKU as sku;
go
