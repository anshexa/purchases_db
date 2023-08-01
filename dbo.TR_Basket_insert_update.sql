create trigger dbo.TR_Basket_insert_update
    on dbo.Basket
    after insert
    as

    set nocount on;

    declare @discount_5_percent decimal(3, 2) = 0.05;
    declare @discount_0_percent decimal(1) = 0;

    update dbo.Basket
    set DiscountValue = Basket.Value *
                        case
                            when Basket.ID_SKU in (select ID_SKU
                                                   from inserted
                                                   group by ID_SKU
                                                   having count(ID_SKU) >= 2)
                                then @discount_5_percent
                            else @discount_0_percent
                        end
    from dbo.Basket
        join inserted on Basket.ID = inserted.ID
    where Basket.ID_SKU in (select ID_SKU
                            from inserted);
go
