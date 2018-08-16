namespace Core.Entities
{
#pragma warning disable CA1717 // Only FlagsAttribute enums should have plural names
    public enum LotStatus
#pragma warning restore CA1717 // Only FlagsAttribute enums should have plural names
    {
        None,
        InSale,
        Sold,
        NotSold
    }
}
