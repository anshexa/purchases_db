create procedure dbo.usp_MakeFamilyPurchase
    @FamilySurName varchar(255)
as
    set nocount on;

    begin try
        declare @ID_family int;
        set @ID_family = (select Family.ID
                          from dbo.Family
                          where SurName = @FamilySurName);

        if @ID_family is null
            throw 51000, N'Семья с такой фамилией не найдена.', 1;

        declare @sum_basket_of_family decimal(18, 2);
        set @sum_basket_of_family = (select sum(dbo.Basket.Value)
                                     from dbo.Basket
                                     where ID_Family = @ID_family);

        if @sum_basket_of_family is not null
            begin
                update dbo.Family
                set Family.BudgetValue = Family.BudgetValue - @sum_basket_of_family
                where Family.ID = @ID_family;
            end
    end try
    begin catch
        print concat(N'Ошибка: ', error_message());
        throw;
    end catch;
go
