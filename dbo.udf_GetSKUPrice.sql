create function dbo.udf_GetSKUPrice(
    @ID_SKU int
)
returns decimal(18, 2)
as
    begin
        declare @sumValues decimal(18, 2);
        declare @sumQuantities decimal(18, 2);
        select
            @sumValues = sum(basket.Value)
            ,@sumQuantities = sum(basket.Quantity)
        from dbo.Basket as basket
        where ID_SKU = @ID_SKU;
        return convert(decimal(18, 2), @sumValues / @sumQuantities);
    end;
go
